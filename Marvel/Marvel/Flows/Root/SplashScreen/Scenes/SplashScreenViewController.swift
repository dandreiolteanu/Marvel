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
        startReplicatingAnimation()
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.inputs.viewLoaded()
    }
}

// MARK: - ReplicatedViewAnimating

extension SplashScreenViewController: ReplicatedViewAnimating {
    var replicatorsNumber: Int {
        6
    }

    func replicatedView(at replicatorNumber: Int) -> UIView {
        UIImageView(image: Asset.imgBanner.image)
    }
}
