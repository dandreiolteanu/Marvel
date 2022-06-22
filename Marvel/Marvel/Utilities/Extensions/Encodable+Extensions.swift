//
//  Encodable+Extensions.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import Foundation

extension Encodable {

    // MARK: - Public Methods

    func toJSON(using encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        do {
            let data = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]

            return json
        } catch {
            return [:]
        }
    }
}
