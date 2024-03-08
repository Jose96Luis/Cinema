//
//  Movie.swift
//  Cinema
//
//  Created by José Rodriguez Romero on 06/03/24.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let voteAverage: Double
    let duration: Int?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case duration = "runtime"
        case genres
    }
}

struct Genre: Identifiable, Decodable {
    let id: Int
    let name: String
}
