//
//  FlowController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

// swiftlint:disable line_length

// INFO:
/* ---

FlowController is the basic type for a regular flowcontroller
 
 Has 3 type of presentation possibility, definable on init:
 - present       - start flow by modal presentation
 - push          - start flow as a subflow of an existing navigation flow, pushing new screens in the same navigationcontroller
 - custom        - start flow customized, by passing in a customPresentation closure

 flow is started with start(), finished with finish()
 Subclasses need to implement the firstScreen() functions
  - init - basicly no need to do anything else in implementation, than assigning arguments to properties
  - initMainViewController() - responsible for creating something that will be used as the mainViewController. navigationcontroller for navigation flows, tabbarcontroller for tabbar flows. Or simple VC for simple, one-screen flows
  - firstScreen() - here is the defined and returned the first screen of the flow. makes sense mostly for navigation stacks, where the result is used as the root VC of the new navigationcontroller
 
--- */

enum FlowControllerPresentation {
    case present, push, custom(shouldCreateNavigationController: Bool)

    static let custom: FlowControllerPresentation = .custom(shouldCreateNavigationController: true)
}

protocol FlowController: AnyObject {
    var mainViewController: UIViewController? { get }
    var flowPresentation: FlowControllerPresentation { get }
    var parentFlow: FlowController? { get }

    init(from parent: FlowController?, for presentation: FlowControllerPresentation)

    func finish(customDismiss: ((_ mainViewController: UIViewController) -> Void)?, completion: (() -> Void)?, animated: Bool)

    func initMainViewController()
    func firstScreen() -> UIViewController
}

// MARK: - Flow cycle convenience

extension FlowController {

    func start(customPresentation: ((_ mainViewController: UIViewController) -> Void)? = nil, animated: Bool = true) {
        initMainViewController()

        start(with: flowPresentation, customPresentation: customPresentation, animated: animated)
    }

    func finish(customDismiss: ((_ mainViewController: UIViewController) -> Void)? = nil, completion: (() -> Void)? = nil, animated: Bool = true) {
        finish(from: flowPresentation, customDismiss: customDismiss, completion: completion, animated: animated)
    }

    func start(with flowPresentation: FlowControllerPresentation, customPresentation: ((_ mainViewController: UIViewController) -> Void)? = nil, animated: Bool = true) {
        guard let mainVC = mainViewController else {
            assertionFailure("No mainViewController available")
            return
        }

        switch flowPresentation {
        case .present:
            startPresented(main: mainVC)
        case .push:
            startPushed(animated: animated)
        case .custom:
            if let custom = customPresentation {
                custom(mainVC)
            }
        }
    }

    func finish(from flowPresentation: FlowControllerPresentation, customDismiss: ((_ mainViewController: UIViewController) -> Void)? = nil, completion: (() -> Void)? = nil, animated: Bool = true) {
        switch flowPresentation {
        case .present:
            finishPresented(completion: completion, animated: animated)
        case .push:
            finishPushed(completion: completion, animated: animated)
        case .custom:
            if let custom = customDismiss, let mainVC = mainViewController {
                custom(mainVC)
            }
        }
    }

    private func startPresented(main: UIViewController) {
        guard let parentFlow = parentFlow else {
            assertionFailure("parentFlow is nil when trying to present flow")
            return
        }
        parentFlow.mainViewController?.present(main, animated: true, completion: nil)
    }

    private func finishPresented(completion: (() -> Void)?, animated: Bool) {
        guard let parentFlow = parentFlow else {
            assertionFailure("parentFlow is nil when trying to finish flow")
            return
        }

        parentFlow.mainViewController?.dismiss(animated: animated, completion: completion)
    }

    private func startPushed(animated: Bool = true) {
        if let parentNavigationController = parentFlow?.mainViewController as? UINavigationController {
            let vc = firstScreen()
            parentNavigationController.pushViewController(vc, animated: animated)
        } else {
            assertionFailure("ParentFlow's main view controller is not a UINavigationController, but presentation style is push")
        }
    }

    private func finishPushed(completion: (() -> Void)?, animated: Bool = true) {
        guard let parentNavigationController = parentFlow?.mainViewController as? UINavigationController else {
            assertionFailure("parentFlow is nil, or it's main controller is not a navigationcontroller when trying to push flow")
            return
        }

        parentNavigationController.popViewController(animated: animated, completion: completion)
    }
}
