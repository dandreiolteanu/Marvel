//
//  SplashScreenViewController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit
import SnapKit

final class SplashScreenViewController: BaseViewController {

    // MARK: - Private Properties

    private let bannerStackView = UIStackView()
    private let marvelImageView = UIImageView(image: Asset.imgBanner.image)
    private let studiosImageView = UIImageView(image: Asset.imgMarvelStudios.image)

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startAnimation()
    }

    override func setupView() {
        super.setupView()

        view.backgroundColor = .primaryBackground

        bannerStackView.axis = .horizontal
        bannerStackView.spacing = .padding
        bannerStackView.distribution = .fillEqually
        bannerStackView.addArrangedSubview(marvelImageView)
        bannerStackView.addArrangedSubview(studiosImageView)
        view.addSubview(bannerStackView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        bannerStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().insetBy(.padding3x)
            $0.trailing.lessThanOrEqualToSuperview().insetBy(.padding3x)
        }
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.inputs.viewLoaded()
    }

    // MARK: - Private Methods

    private func startAnimation() {
        UIView.transition(with: view, duration: 0.55, options: .transitionCrossDissolve, animations: {
            self.studiosImageView.isHidden = true
        }, completion: { [weak self] _ in
            self?.startReplicatingAnimation(until: { [weak self] in
                self?.viewModel.outputs.animationShouldRepeat == false
            })
        })
    }
}

// MARK: - ReplicatedViewAnimating

extension SplashScreenViewController: ReplicatedViewAnimating {
    var replicatorsNumber: Int {
        6
    }

    func xOffset(at index: Int) -> CGFloat {
        -14 * CGFloat(index)
    }

    func yOffset(at index: Int) -> CGFloat {
        -14 * CGFloat(index)
    }

    func replicatedView(at index: Int) -> UIView {
        // I've added the index to maybe use different images or views based on it
        // example: (index % 2 == 0) ? banner with a color : banner with another color
        UIImageView(image: Asset.imgBanner.image)
    }
}
