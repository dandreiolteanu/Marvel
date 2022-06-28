//
//  View+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 24.06.2022.
//

import UIKit
import SwiftUI

extension View {

    // MARK: - Public Properties
    
    var asUIViewController: UIViewController {
        UIHostingController(rootView: self)
    }
}
