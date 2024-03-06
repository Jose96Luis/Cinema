//
//  Utils.swift
//  Cinema
//
//  Created by José Rodriguez Romero on 06/03/24.
//

import Foundation

struct Utils {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
