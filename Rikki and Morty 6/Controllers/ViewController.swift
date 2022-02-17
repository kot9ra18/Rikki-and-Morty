//
//  ViewController.swift
//  Rikki and Morty 6
//
//  Created by Александр Прохоров on 13.08.2021.
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var results: [Result] = []
    var isPagination = false
    var infoData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadPersons.shared.loadPersons { results, infoData    in
            self.results = results
            print(results.count)
            self.tableView.reloadData()
            self.infoData = infoData.info.next
        } 
    }
}

// MARK: - колличество ячеек и их наполнение
extension ViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeronsCell") as! PersonCellTableViewCell
        
        cell.initCell(cell: results[indexPath.row], url: results[indexPath.row].image)
        return cell
    }
    
    
    // MARK: - Переход по нажатию на ячейку и передача данных
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoPersonViewController = self.storyboard?.instantiateViewController(identifier: "Info") as! InfoPersonViewController
        let id = results[indexPath.row].id
        infoPersonViewController.id = id
        self.present(infoPersonViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Пагинация при прокрутке
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 10) && self.infoData != nil
        {
            DispatchQueue.main.async {
                LoadPersons.shared.isPagination = true
                guard let url = URL(string: self.infoData ?? "") else { return  }
                LoadPersons.shared.forPagination(url: url) { results, next in
                    self.results += results
                    self.infoData = next
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    
}



