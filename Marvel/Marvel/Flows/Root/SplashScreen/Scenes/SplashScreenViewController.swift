//
//  SplashScreenViewController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

final class SplashScreenViewController: BaseViewController {

    // MARK: - Private Properties

    private let viewModel: SplashScreenViewModel

    // MARK: - Init
    
    init(viewModel: SplashScreenViewModel) {
        self.viewModel = viewModel

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseClass Overrides

    override func setupView() {
        super.setupView()

        view.backgroundColor = .primaryBackground
    }

    override func setupBindings() {
        super.setupBindings()

        startReplicatingAnimation(until: { [weak self] in
            self?.viewModel.outputs.animationShouldRepeat == false
        })

        viewModel.inputs.viewLoaded()
    }
}

// MARK: - ReplicatedViewAnimating

extension SplashScreenViewController: ReplicatedViewAnimating {
    var replicatorsNumber: Int {
        6
    }

    func xOffset(at index: Int) -> CGFloat {
        -12 * CGFloat(index)
    }

    func yOffset(at index: Int) -> CGFloat {
        -12 * CGFloat(index)
    }

    func replicatedView(at index: Int) -> UIView {
        // I've added the index to maybe use different images or views based on it
        // example: (index % 2 == 0) ? banner with a color : banner with another color
        UIImageView(image: Asset.imgBanner.image)
    }
}
