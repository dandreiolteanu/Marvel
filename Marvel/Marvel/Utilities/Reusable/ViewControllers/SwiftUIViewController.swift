//
//  SwiftUIViewController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import SwiftUI
import UIKit

final class SwiftUIViewController<V: View>: UIViewController {

    // MARK: - Private Propeties

    private let swiftUIView: V

    // MARK: - Init
    
    init(_ swiftUIView: V) {
        self.swiftUIView = swiftUIView

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseClass Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = swiftUIView.asUIViewController
        viewController.view.backgroundColor = .clear
        addChildViewController(viewController, to: view)
    }
}
