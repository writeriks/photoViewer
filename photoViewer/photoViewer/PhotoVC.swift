//
//  PhotoVC.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 22/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    

    var imagesArray: [UIImage] = []
    var namesArray : [String] = []
    var currentImage = UIImage()
    var currentName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = view.frame
        for i in 0..<imagesArray.count{
            let imageView = UIImageView()
            imageView.image = imagesArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height/2)
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
