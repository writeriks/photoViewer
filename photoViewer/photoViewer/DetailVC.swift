//
//  DetailVC.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 22/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var photoActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var overlayLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    var photoIndex: Int!
    
    var currentAuthor : Author!
    var authors = [Author]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in authors{
            if item.vIndices == currentAuthor.vIndices{
                print(item.vIndices)
                print(item.vAuthor)
            }
        }
        
        photoActivityIndicator.startAnimating()
        overlayLabel.text = "\(currentAuthor!.vAuthor) - \(String(describing: currentAuthor!.vIndices)) - \(currentAuthor!.vWidth)x\(currentAuthor!.vHeight)"
        getImage( currentAuthor!, imageView:imageview)
        scrollView.delegate = self
    }

    func getImage(_ author:Author, imageView : UIImageView){
        DispatchQueue.global(qos:DispatchQoS.QoSClass.default).async {
            
            let urlString = "https://unsplash.it/\(author.vWidth)/\(author.vHeight)?image=\(author.vID)"
            
            let data = try? Data(contentsOf: URL(string: urlString)!)
            
            var image : UIImage?
            
            if data != nil{
                author.vImageData = data
                image = UIImage(data: data!)
            }
            
            DispatchQueue.main.async {
                self.photoActivityIndicator.stopAnimating()
                imageView.image = image
            }
        }
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageview.bounds.width
        let heightScale = size.height / imageview.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
}

extension DetailVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageview
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - imageview.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageview.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }

}
