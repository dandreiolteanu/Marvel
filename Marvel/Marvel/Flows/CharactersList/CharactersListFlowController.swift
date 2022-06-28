//
//  CharactersListFlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

final class CharactersListFlowController: NavigationFlowController {

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

    private func makeCharacterDetailsFlowController(marvelCharacter: MarvelCharacter) -> CharacterDetailsFlowController {
        CharacterDetailsFlowController(appCore: appCore, marvelCharacter: marvelCharacter, from: self, for: .present)
    }
}

// MARK: - CharactersListFlowDelegate

extension CharactersListFlowController: CharactersListFlowDelegate {
    func shouldShowCharacterDetails(on viewModel: CharactersListViewModel, marvelCharacter: MarvelCharacter) {
        let flowController = makeCharacterDetailsFlowController(marvelCharacter: marvelCharacter)
        flowController.flowDelegate = self
        flowController.start()

        appendChild(flowController)
    }
}

// MARK: - CharacterDetailsFlowDelegate

extension CharactersListFlowController: CharacterDetailsFlowControllerDelegate {
    func didFinish(on flow: CharacterDetailsFlowController) {
        flow.finish(completion: { [weak self, weak flow] in
            guard let flow = flow else { return }

            self?.removeChild(flow)
        })
    }
}

extension CharactersListFlowController: ComicDetailsFlowDelegate {
    func shouldCloseComicDetails() {
        mainViewController?.presentedViewController?.dismiss(animated: true)
    }
}
