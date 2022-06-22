//
//  AppStyle.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit

enum AppStyle {

    // MARK: - CornerRadiusDecorator

    /// 14
    static var normalCornerRadiusDecorator: CornerRadiusDecorator {
        CornerRadiusDecorator(radius: 14)
    }
    
    /// 8 matching as a child corner radius for the normalCornerRadiusDecorator
    static var childNormalCornerRadiusDecorator: CornerRadiusDecorator {
        CornerRadiusDecorator(radius: 8)
    }

    /// Will have corner radius max(height, width) / 2
    static var squareCornerRadiusDecorator: CornerRadiusDecorator {
        CornerRadiusDecorator()
    }

    // MARK: - ShadowDecorator

    static var shadowDecorator: ShadowDecorator {
        ShadowDecorator(radius: 10, color: .primaryBackground, opacity: 0.5, offset: .zero)
    }
}
