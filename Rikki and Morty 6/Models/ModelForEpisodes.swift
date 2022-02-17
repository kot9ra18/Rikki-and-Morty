//
//  ModelForEpisodes.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 24.09.2021.
//

import Foundation
/*"name":"Pilot",
 "air_date":"December 2, 2013",
 "episode":"S01E01",*/

struct Episodes: Decodable {
    var name: String?
    var airDate: String?
    var episode: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
        case episode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try! container.decode(String.self, forKey: .name)
        self.airDate = try! container.decode(String.self, forKey: .airDate)
        self.episode = try! container.decode(String.self, forKey: .episode)
    }
}
