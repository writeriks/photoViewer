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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
