//
//  CharacterDetailsFlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import UIKit

protocol CharacterDetailsFlowControllerDelegate: AnyObject {
    func didFinish(on flow: CharacterDetailsFlowController)
}

final class CharacterDetailsFlowController: NavigationFlowController {

    // MARK: - Public Properties

    weak var flowDelegate: CharacterDetailsFlowControllerDelegate?

    // MARK: - Private Properties

    private let appCore: AppCore
    private let marvelCharacter: MarvelCharacter
    private var characterDetailsTransitionDelegate = BlurTransitionAnimator()
    private var comicDetailsTransitionDelegate = BlurTransitionAnimator()

    // MARK: - Init

    init(appCore: AppCore, marvelCharacter: MarvelCharacter, from parent: FlowController? = nil, for presentation: FlowControllerPresentation = .custom) {
        self.appCore = appCore
        self.marvelCharacter = marvelCharacter

        super.init(from: parent, for: presentation)
    }
    
    required init(from parent: FlowController? = nil, for presentation: FlowControllerPresentation = .custom) {
        fatalError("init(from:for:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func firstScreen() -> UIViewController {
        navigationController?.modalPresentationStyle = .custom
        navigationController?.transitioningDelegate = characterDetailsTransitionDelegate
        
        return makeCharacterDetailsViewController(marvelCharacter: marvelCharacter,
                                                  transitioningDelegate: characterDetailsTransitionDelegate)
    }

    // MARK: - Private Methods

    private func makeCharacterDetailsViewController(marvelCharacter: MarvelCharacter, transitioningDelegate: UIViewControllerTransitioningDelegate?) -> UIViewController {
        let viewController = CharacterDetailsViewController(viewModel: {
            let viewModel = CharacterDetailsViewModelImpl(marvelCharacter: marvelCharacter,
                                                          characterComicsService: appCore.characterComicsService,
                                                          easterEggService: ThorCharacterEasterEgg(marvelCharacter: marvelCharacter))
            viewModel.flowDelegate = self
            return viewModel
        }())

        return viewController
    }

    private func makeComicDetailsViewController(characterComic: MarvelComic, transitioningDelegate: UIViewControllerTransitioningDelegate?) -> UIViewController {
        let viewModel = ComicDetailsViewModelImpl(characterComic: characterComic)
        viewModel.flowDelegate = self

        let view = ComicDetailsView(viewModel: viewModel)

        let viewController = SwiftUIViewController(view)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = transitioningDelegate

        return viewController
    }
}

// MARK: - CharacterDetailsFlowDelegate

extension CharacterDetailsFlowController: CharacterDetailsFlowDelegate {
    func shouldCloseCharacterDetails(on viewModel: CharacterDetailsViewModel) {
        flowDelegate?.didFinish(on: self)
    }

    func shouldShowComicDetails(on viewModel: CharacterDetailsViewModel, characterComic: MarvelComic) {
        mainViewController?.present(makeComicDetailsViewController(characterComic: characterComic, transitioningDelegate: comicDetailsTransitionDelegate),
                                    animated: true)
    }
}

extension CharacterDetailsFlowController: ComicDetailsFlowDelegate {
    func shouldCloseComicDetails() {
        mainViewController?.presentedViewController?.dismiss(animated: true)
    }
}
