//
//  RootFlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

class RootFlowController {

    // MARK: - Private Properties

    weak var window: UIWindow?

    // MARK: - Private Properties

    private let appCore: AppCore

    // MARK: - FlowControllers

    private var splashScreenFlowController: NavigationFlowController?
    private var charactersListFlowController: NavigationFlowController?

    // MARK: - Init

    init(window: UIWindow?, appCore: AppCore) {
        self.window = window
        self.appCore = appCore
    }
    
    // MARK: - Public Methods

    func start() {
        showSplashScreenFlowController()
    }

    // MARK: - Private Methods

    private func showSplashScreenFlowController() {
        let splashScreenFlowController = SplashScreenFlowController()
        splashScreenFlowController.flowDelegate = self
        self.splashScreenFlowController = splashScreenFlowController

        show(flow: splashScreenFlowController)
    }

    private func showCharactersListFlowController() {
        let charactersListFlowController = CharactersListFlowController(appCore: appCore)
        self.charactersListFlowController = charactersListFlowController

        show(flow: charactersListFlowController) { [weak self] in
            self?.splashScreenFlowController = nil
        }
    }
}

// MARK: - SplashScreenFlowControllerDelegate

extension RootFlowController: SplashScreenFlowControllerDelegate {
    
    func didFinish(on flow: SplashScreenFlowController) {
        showCharactersListFlowController()
    }
}
