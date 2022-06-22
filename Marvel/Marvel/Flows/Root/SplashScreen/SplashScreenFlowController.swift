//
//  SplashScreenFlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

protocol SplashScreenFlowControllerDelegate: AnyObject {
    func didFinish(on flow: SplashScreenFlowController)
}

final class SplashScreenFlowController: NavigationFlowController {

    // MARK: - Public properties

    weak var flowDelegate: SplashScreenFlowControllerDelegate?

    // MARK: - Lifecycle

    override func firstScreen() -> UIViewController {
        SplashScreenViewController(viewModel: {
            let viewModel = SplashScreenViewModelImpl()
            viewModel.flowDelegate = self
            return viewModel
        }())
    }
}

// MARK: - SplashScreenFlowDelegate

extension SplashScreenFlowController: SplashScreenFlowDelegate {

    func shouldGoToNextStep(on viewModel: SplashScreenViewModel) {
        flowDelegate?.didFinish(on: self)
    }
}
