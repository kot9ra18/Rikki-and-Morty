//
//  LoadInfoPerson.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 11.09.2021.
//ccылка в домашке https://rickandmortyapi.com/api/character/2

import Foundation
import Alamofire
import AlamofireImage

class LoadInfoPerson {
    
    static let shared = LoadInfoPerson()
    var episodesArrayLink: [String] = []

//    MARK: - Load Info
    func loadInfoPerson(linkFinal: String, _ completion: @escaping (WelcomeInfo) -> Void) {
            guard let url = URL(string: linkFinal) else {return}
        
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    let data = response.data
                    let decoder = JSONDecoder()
                        do{
                            let jsonDec: WelcomeInfo = try! decoder.decode(WelcomeInfo.self, from: data!)
                            for linkEpisodes in jsonDec.episodeInfo{
                                self.episodesArrayLink.append(linkEpisodes)
                            }
                            DispatchQueue.main.async {
                                completion(jsonDec)
                            }
                        }catch{print(error.localizedDescription)}
                case .failure(let error):
                    print(error)
            }
        }
    }
    //    MARK: - Load Episodes

    func loadEpisode(urlEpisodes: [String], _ completionEp: @escaping ([Episodes]) -> ()){
        var episodes: [Episodes] = []
        for episodeLink in urlEpisodes{
            guard let url = URL(string: episodeLink) else {return}
                AF.request(url).validate().responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let data = response.data
                            let decoder = JSONDecoder()
                            do{
                                let jsonDecEp: Episodes = try! decoder.decode(Episodes.self, from: data!)
                                episodes.append(jsonDecEp)
                                DispatchQueue.main.async {
                                    completionEp(episodes)
                                }
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
        }
    }
    //    MARK: - Load image

    func loadImageInfo(link: String, _ completionEp: @escaping (UIImage) -> ()){
        guard let url = URL(string: link) else {return}
            AF.request(url).responseImage { response in
                    if case .success(let image) = response.result {
                        DispatchQueue.main.async {
                            completionEp(image)
                        }
                    }
                }
    }
}
