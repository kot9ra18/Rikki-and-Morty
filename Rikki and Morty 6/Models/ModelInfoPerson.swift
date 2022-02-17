//
//  ModelInfoPerson.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 22.09.2021.
//

import Foundation



struct WelcomeInfo: Decodable {
    
    let nameInfo, statusInfo, speciesInfo, typeInfo: String
    let genderInfo: String
    let locationInfo: LocationInfo
    let imageInfo: String
    let episodeInfo: [String]
    
    enum CodingKeys: String, CodingKey {
        case nameInfo = "name"
        case statusInfo = "status"
        case speciesInfo = "species"
        case typeInfo = "type"
        case genderInfo = "gender"
        case imageInfo = "image"
        //        case originInfo = "origin"
        case locationInfo = "location"
        case episodeInfo = "episode"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.nameInfo = try! container.decode(String.self, forKey: .nameInfo)
        self.statusInfo = try! container.decode(String.self, forKey: .statusInfo)
        self.speciesInfo = try! container.decode(String.self, forKey: .speciesInfo)
        self.typeInfo = try! container.decode(String.self, forKey: .typeInfo)
        self.genderInfo = try! container.decode(String.self, forKey: .genderInfo)
        self.imageInfo = try! container.decode(String.self, forKey: .imageInfo)
        self.episodeInfo = try! container.decode([String].self, forKey: .episodeInfo)
        self.locationInfo = try! container.decode(LocationInfo.self, forKey: .locationInfo)
    }
}

// MARK: - Location
struct LocationInfo: Codable {
    let nameInfo: String
    
    enum CodingKeys: String, CodingKey{
        case nameInfo = "name"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nameInfo = try! container.decode(String.self, forKey: .nameInfo)
    }
}

