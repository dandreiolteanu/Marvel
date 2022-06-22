//
//  String+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation

extension String {

    // MARK: - Public Properties

    var nilIfEmpty: String? {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : self
    }
}
