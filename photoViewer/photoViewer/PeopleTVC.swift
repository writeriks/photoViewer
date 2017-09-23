//
//  PeopleTVC.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 21/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import UIKit

class PeopleTVC: UITableViewController{
    
    var photoImage: [UIImage] = []
    var names : [String] = []
    var selectedImage:UIImage?
    var selectedName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        photoImage.append(UIImage(named: "emir")!)
        photoImage.append(UIImage(named: "emir2")!)
        photoImage.append(UIImage(named: "spM")!)
        names.append("Alejandro Escamilla 1")
        names.append("Alejandro Escamilla 2")
        names.append("Paul Jarvis 1")
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.photoImage.count
    }

    let cellID = "photoCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PhotoCell
        
        cell.photoImage.image = photoImage[(indexPath as IndexPath).row]
        cell.nameLabel.text = names[(indexPath as IndexPath).row]

        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            selectedImage = self.photoImage[indexPath.row]
            selectedName = self.names[indexPath.row]
        
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = Storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
            vc.imagesArray = self.photoImage
            vc.namesArray = self.names
            vc.currentImage = selectedImage!
            vc.currentName = selectedName!
            
            self.navigationController?.pushViewController(vc, animated: false)
            
            //        performSegue(withIdentifier: "photoDetailSegue", sender: self)
    }
}
