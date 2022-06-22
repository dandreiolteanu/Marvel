//
//  TabBarFlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

class TabBarFlowController: FlowController {

    // MARK: - Public Properties

    var mainViewController: UIViewController? {
        tabBarController
    }

    // MARK: - Private Properties

    private(set) var parentFlow: FlowController?
    private(set) var flowPresentation: FlowControllerPresentation
    private(set) var tabBarController: UITabBarController?

    // MARK: - Init

    required init(from parent: FlowController? = nil, for presentation: FlowControllerPresentation = .custom) {
        parentFlow = parent
        flowPresentation = presentation
    }

    // MARK: - FlowCycle

    func firstScreen() -> UIViewController {
        guard let tabBar = tabBarController else {
            fatalError("TabBarController is not initialized")
        }

        return tabBar
    }

    func initMainViewController() {
        guard tabBarController == nil else { return }

        tabBarController = UITabBarController()
        tabBarController?.viewControllers = tabBarViewControllers()
    }

    func tabBarViewControllers() -> [UIViewController] {
        return []
    }
}
