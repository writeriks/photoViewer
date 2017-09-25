//
//  PhotoCell.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 21/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoImage: UIImageView!

    var author:Author?{
        didSet{
            updateCell()
        }
    }
    
    override func prepareForReuse() {
        photoImage.image = nil
    }
    
    func updateCell(){
        nameLabel.text = "\(author!.vAuthor) \(String(describing: author!.vIndices))"
        photoImage.image = UIImage(named: "placeholder")
        if author?.vImageData != nil{
            photoImage.image = UIImage(data: author!.vImageData! as Data)
        }else{
            getImage( author!, imageView:photoImage)
        }
    }
    
    func getImage(_ author:Author, imageView : UIImageView ){
        DispatchQueue.global(qos:DispatchQoS.QoSClass.default).async {
            
            let urlString = "https://unsplash.it/300/300?image=\(author.vID)"
            //"https://unsplash.it/\(author.vWidth)/\(author.vHeight))?image=\(author.vID)"

            
            let data = try? Data(contentsOf: URL(string: urlString)!)
            
            var image : UIImage?
            
            if data != nil{
                author.vImageData = data
                image = UIImage(data: data!)
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
