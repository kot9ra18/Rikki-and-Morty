//
//  PersonCellTableViewCell.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 13.08.2021.
//

import UIKit

class PersonCellTableViewCell: UITableViewCell {
    var loadImg: LoadPersons?
    
    @IBOutlet weak var imagePerson: UIImageView!
    @IBOutlet weak var namePersons: UILabel!
    @IBOutlet weak var statusPersons: UILabel!
    @IBOutlet weak var locationPerson: UILabel!
    
    override func prepareForReuse() {
        namePersons.text = ""
        locationPerson.text = ""
        imagePerson.image = nil
    }
    
    func initCell(cell: Result, url: String){
        namePersons.text = cell.name
        locationPerson.text = cell.location.name
        LoadPersons.shared.loadImage(url: url) { image in
            self.imageView?.image = image
        }
    }
    
    
    
    
    
    
    
    
    
    
}
