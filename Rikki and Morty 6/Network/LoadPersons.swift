//
//  LoadPersons.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 14.08.2021.
//

import Foundation
import Alamofire
import AlamofireImage

class LoadPersons {
    
    static let shared = LoadPersons()
    let linkForLoad = "https://rickandmortyapi.com/api/character"
    var isPagination = false
    var imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - LOad persons
    func loadPersons(_ completion: @escaping ([Result], Welcome) -> Void) {
        guard let url = URL(string: linkForLoad) else {return}
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let data = response.data
                let decoder = JSONDecoder()
                do{
                    let jsonDec: Welcome = try! decoder.decode(Welcome.self, from: data!)
                    print(jsonDec.info.next)
                    var results: [Result] = []
                    var infoData = jsonDec
                    for result in jsonDec.results {
                        results.append(result)
                    }
                    
                    DispatchQueue.main.async {
                        completion(results, infoData)
                    }
                }catch{print(error.localizedDescription)}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pagination func
    
    func forPagination(url: URL, _ completion: @escaping ([Result], String) -> Void) {
        if isPagination {
            self.isPagination = false
            let url = url
            AF.request(url).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let data = response.data
                    let decoder = JSONDecoder()
                    var results: [Result] = []
                    var next = String()
                    do{
                        let result: Welcome = try! decoder.decode(Welcome.self, from: data!)
                        next = result.info.next ?? ""
                        
                        for rez in result.results{
                            results.append(rez)
                        }
                        DispatchQueue.main.async {
                            completion(results, next)
                        }
                    }catch{print(error.localizedDescription)}
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    func loadImage(url: String, _ completion: @escaping (UIImage) -> Void){
        guard let url = URL(string: url) else {return}
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString){
            completion(cachedImage)
        } else {
            AF.request(url).responseImage { response in
                if case .success(let image) = response.result {
                    guard image != nil else {return}
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
    
    
    
}
