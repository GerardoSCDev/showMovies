//
//  Movie.swift
//  showMovies
//
//  Created by Gerardo Santillan on 16/03/25.
//

struct Movie: Codable {
    let id: Int?
    let popularity: Double?
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
}

