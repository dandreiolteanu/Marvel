//
//  Color.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit.UIColor

/// All colors used in the app are defined here.
/// Don't forget to add the color in Colors.xcassets as well with the same name as the case's name.
private enum Colors: String {
    case primaryBackground
    case secondaryBackground

    case primaryText
    case primaryTextDark
    case secondaryText
}

// MARK: - Colors

extension UIColor {
    static let primaryBackground = UIColor.initialize(with: .primaryBackground)
    static let secondaryBackground = UIColor.initialize(with: .secondaryBackground)

    static let primaryText = UIColor.initialize(with: .primaryText)
    static let primaryTextDark = UIColor.initialize(with: .primaryTextDark)
    static let secondaryText = UIColor.initialize(with: .secondaryText)
}

// MARK: - Helpers

private extension UIColor {
    
    // MARK: - Methods

    static func initialize(with style: Colors) -> UIColor {
        guard let color = UIColor(named: style.rawValue) else {
            fatalError("Color named \(style.rawValue) not found. Make sure you added it in Colors.xcassets.")
        }

        return color
    }
}
