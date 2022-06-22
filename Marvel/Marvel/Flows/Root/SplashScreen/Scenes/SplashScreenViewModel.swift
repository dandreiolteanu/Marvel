//
//  SplashScreenViewModel.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation

protocol SplashScreenFlowDelegate: AnyObject {
    func shouldGoToNextStep(on viewModel: SplashScreenViewModel)
}

protocol SplashScreenViewModelInputs {
    func viewLoaded()
}

protocol SplashScreenViewModelOutputs {
    var animationShouldRepeat: Bool { get }
}

protocol SplashScreenViewModel {
    var inputs: SplashScreenViewModelInputs { get }
    var outputs: SplashScreenViewModelOutputs { get }
}

final class SplashScreenViewModelImpl: SplashScreenViewModel, SplashScreenViewModelInputs, SplashScreenViewModelOutputs {

    // MARK: - FlowDelegate

    weak var flowDelegate: SplashScreenFlowDelegate?

    // MARK: - Inputs

    var inputs: SplashScreenViewModelInputs { self }
    
    // MARK: - Outputs

    var outputs: SplashScreenViewModelOutputs { self }

    var animationShouldRepeat: Bool = true

    // MARK: - Public Methods

    func viewLoaded() {
        // We simulate that the splash screen takes some time to load data, just so that the animation loops a few times
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }

            self.animationShouldRepeat = false
            self.flowDelegate?.shouldGoToNextStep(on: self)
        }
    }
}
