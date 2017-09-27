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
    
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    var author:Author?{
        didSet{
            updateCell()
        }
    }
    
    override func prepareForReuse() {
        photoImage.image = nil
    }
    
    func updateCell(){
        let urlString = "https://unsplash.it/300/300?image=\(author!.vID)"
        nameLabel.text = "\(author!.vAuthor) \(String(describing: author!.vIndices))"
        
        if let image = imageCache.object(forKey: urlString as AnyObject ) {
            photoImage.image = image as? UIImage
        }else{
            getImage(author!, imageView: photoImage, urlString: urlString)
        }
        
    }
        
    func getImage(_ author:Author, imageView : UIImageView, urlString:String ){
        DispatchQueue.global(qos:DispatchQoS.QoSClass.default).async {
            
            let data = try? Data(contentsOf: URL(string: urlString)!)
            
            var image : UIImage?
            
            if data != nil{
                author.vImageData = data
                image = UIImage(data: data!)
                self.imageCache.setObject(image!, forKey: urlString as AnyObject)
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
