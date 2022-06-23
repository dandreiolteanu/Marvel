//
//  CharactersListFlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

protocol CharactersListFlowControllerDelegate: AnyObject {
    func didFinish(on flow: SplashScreenFlowController)
}

final class CharactersListFlowController: NavigationFlowController {

    // MARK: - Public Properties

    weak var flowDelegate: CharactersListFlowControllerDelegate?

    // MARK: - Private Properties

    private let appCore: AppCore

    // MARK: - Init

    init(appCore: AppCore, from parent: FlowController? = nil, for presentation: FlowControllerPresentation = .custom) {
        self.appCore = appCore

        super.init(from: parent, for: presentation)
    }
    
    required init(from parent: FlowController? = nil, for presentation: FlowControllerPresentation = .custom) {
        fatalError("init(from:for:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func firstScreen() -> UIViewController {
        CharactersListViewController(viewModel: {
            let viewModel = CharactersListViewModelImpl(charactersService: appCore.charactersService)
            viewModel.flowDelegate = self
            return viewModel
        }())
    }

    // MARK: - Private Methods

    private func makeCharacterDetailsViewController(marvelCharacter: MarvelCharacter) -> UIViewController {
        let viewController = CharacterDetailsViewController(viewModel: {
            let viewModel = CharacterDetailsViewModelImpl(marvelCharacter: marvelCharacter, characterComicsService: appCore.characterComicsService)
            viewModel.flowDelegate = self
            return viewModel
        }())
        
        viewController.modalPresentationStyle = .overFullScreen

        return viewController
    }
}

// MARK: - CharactersListFlowDelegate

extension CharactersListFlowController: CharactersListFlowDelegate {
    func shouldShowCharacterDetails(on viewModel: CharactersListViewModel, marvelCharacter: MarvelCharacter) {
        let characterDetailsViewController = makeCharacterDetailsViewController(marvelCharacter: marvelCharacter)
        currentPresentedViewController = characterDetailsViewController

        navigationController?.present(characterDetailsViewController, animated: true)
    }
}

// MARK: - CharacterDetailsFlowDelegate

extension CharactersListFlowController: CharacterDetailsFlowDelegate {
    func didPressClose(on viewModel: CharacterDetailsViewModel) {
        currentPresentedViewController?.dismiss(animated: true)
    }
}
