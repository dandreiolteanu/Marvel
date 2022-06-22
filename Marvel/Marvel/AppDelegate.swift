//
//  AppDelegate.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public Properties

    var window: UIWindow?
    var flow: RootFlowController?

    // MARK: - Private Properties

    private lazy var appCore = AppCore()

    // MARK: - Lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        flow = RootFlowController(window: window, appCore: appCore)
        flow?.start()

        return true
    }
}
