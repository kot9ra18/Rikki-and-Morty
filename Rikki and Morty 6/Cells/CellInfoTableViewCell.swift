//
//  CellInfoTableViewCell.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 26.08.2021.
//

import UIKit

class CellInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var episode: UILabel!
    
    
    func initCellInfo(cellInfo: Episodes){
        name.text = cellInfo.name
        date.text = cellInfo.airDate
        episode.text = cellInfo.episode
    }
}
