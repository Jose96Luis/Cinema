//
//  MovieResponse.swift
//  Cinema
//
//  Created by José Rodriguez Romero on 06/03/24.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}
