//
//  InfoPersonViewController.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 25.08.2021.
//

import UIKit

class InfoPersonViewController: UIViewController {
        
    var copmletInfo: WelcomeInfo?
    var episodesArrayLink: [String] = []
    var episodesArray: [Episodes] = []
    var id: Int = 0
    var linkCompleate = ""
    
    @IBOutlet weak var tableViewInfo: UITableView!
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var nameInfo: UILabel!
    @IBOutlet weak var liveStatusInfo: UILabel!
    @IBOutlet weak var speciesAndGender: UILabel!
    @IBOutlet weak var lastLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var link = "https://rickandmortyapi.com/api/character/" + String(id)
        linkCompleate = link
        
        LoadInfoPerson.shared.loadInfoPerson(linkFinal: linkCompleate) { result  in
            self.nameInfo.text = result.nameInfo
            self.liveStatusInfo.text = result.statusInfo
            self.lastLocation.text = result.locationInfo.nameInfo
            self.speciesAndGender.text = result.genderInfo + ": " + result.speciesInfo
            self.episodesArrayLink = result.episodeInfo
            
            LoadInfoPerson.shared.loadEpisode(urlEpisodes: self.episodesArrayLink) { episodes in
                self.episodesArray = episodes
                self.tableViewInfo.reloadData()
            }
            LoadInfoPerson.shared.loadImageInfo(link: result.imageInfo) { image in
                self.imageInfo.image = image
            }
        }
    }
}

extension InfoPersonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo =  tableViewInfo.dequeueReusableCell(withIdentifier: "CellInfo", for: indexPath) as! CellInfoTableViewCell
        
        cellInfo.initCellInfo(cellInfo: episodesArray[indexPath.row])
        return cellInfo
    }
    
}
