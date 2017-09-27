//
//  PeopleTVC.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 21/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import UIKit
import CoreData
class PeopleTVC: UITableViewController{
    
    
    
    var author = [Author]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        
        if author.count > 0 {
            print("do not refresh API")
        } else {
            apicall()
        }
        self.tableView.tableFooterView = UIView()
    }
    
    func apicall(){// API CALL
        let api = APIManager()
        api.loadData("http://unsplash.it/list", completion: didLoadData)
    }

    func didLoadData(_ author:[Author]){ // DID LOAD DATA
        self.author = author
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return author.count
    }
    
    fileprivate struct storyboard{
        
        static let cellReuseIdentifier = "photoCell"
        static let segueIdentifier = "PageViewController"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier, for: indexPath) as! PhotoCell        
        cell.tag = indexPath.row
        DispatchQueue.main.async {() -> Void in
            if(cell.tag == indexPath.row) {
                    if let updateCell = tableView.cellForRow(at: indexPath) as? PhotoCell {
                        updateCell.author = self.author[(indexPath as NSIndexPath).row]
                    }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = Storyboard.instantiateViewController(withIdentifier: storyboard.segueIdentifier) as! ManagePVC
        vc.authors = author
        vc.currentIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
