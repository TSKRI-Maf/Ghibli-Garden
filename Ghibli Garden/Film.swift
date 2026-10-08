//
//  Film.swift
//  Ghibli Garden
//
//  Created by María Fernanda Espinosa Vásquez on 07/10/26.
//

import Foundation

struct Film: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var description: String
    var image: String?
    var director: String
    var releaseDate: String
    var runningTime: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case image
        case director
        case releaseDate = "release_date"
        case runningTime = "running_time"
    }
}
