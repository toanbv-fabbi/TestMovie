//
//  SearchResult.swift
//  Test
//
//  Created by cmc on 07/07/2022.
//

import UIKit

struct SearchResult: Codable, Hashable {
    var data: [MovieData]?
    var response: String
    enum CodingKeys : String, CodingKey {
        case data = "Search"
        case response = "Response"
    }
}
struct MovieData: Codable, Hashable {
    var title: String?
    var year: String?
    var imdbID: String?
    var type: String?
    var poster: String?
    enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
