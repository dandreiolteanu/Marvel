//
//  NavigationFlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

class NavigationFlowController: NSObject, FlowController {

    // MARK: - Public Properties

    var currentPresentedFlow: NavigationFlowController?
    var childFlowControllers: [NavigationFlowController] = []
    
    var mainViewController: UIViewController? {
        switch flowPresentation {
        case .present, .push:
            return navigationController
        case .custom:
            return navigationController ?? firstScreen()
        }
    }

    // MARK: - Private Properties

    private(set) var parentFlow: FlowController?
    private(set) var flowPresentation: FlowControllerPresentation
    private(set) var navigationController: UINavigationController?

    // MARK: - Init

    required init(from parent: FlowController? = nil, for presentation: FlowControllerPresentation = .custom) {
        parentFlow = parent
        flowPresentation = presentation
    }

    // MARK: - FlowCycle

    open func firstScreen() -> UIViewController {
        return UIViewController()
    }

    open func start(customPresentation: ((UIViewController) -> Void)? = nil, animated: Bool = true) {
        (self as FlowController).start(customPresentation: customPresentation, animated: animated)
    }

    func initMainViewController() {
        guard navigationController == nil else { return }

        if let parentFlow = parentFlow {
            switch flowPresentation {
            case .present:
                navigationController = UINavigationController(rootViewController: firstScreen())
            case .push:
                if let parentNavFlow = parentFlow as? NavigationFlowController {
                    navigationController = parentNavFlow.navigationController
                } else {
                    assertionFailure("Parent flow needs to be a navigation flow for a push presentation!")
                }
            case .custom:
                break
            }
        } else {
            switch flowPresentation {
            case .present:
                navigationController = UINavigationController(rootViewController: firstScreen())
            case .push:
                assertionFailure("Need to have a parent flow for a push presentation!")
            case .custom(let shouldCreateNavigationController):
                if shouldCreateNavigationController {
                    navigationController = UINavigationController(rootViewController: firstScreen())
                }
            }
        }
    }

    // MARK: - Public Methods

    func appendChild(_ navigationFlowController: NavigationFlowController) {
        childFlowControllers.append(navigationFlowController)
    }

    func removeChild(_ navigationFlowController: NavigationFlowController) {
        childFlowControllers.removeAll(where: { $0 === navigationFlowController })
    }
}
