//
//  SnapKit+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 22.06.2022.
//

import UIKit
import SnapKit

extension ConstraintMakerEditable {

    // MARK: - Public Methods

    @discardableResult
    func offsetBy(_ constant: CGFloat) -> ConstraintMakerEditable {
        offset(constant)
    }

    @discardableResult
    func insetBy(_ constant: CGFloat) -> ConstraintMakerEditable {
        inset(constant)
    }
}
