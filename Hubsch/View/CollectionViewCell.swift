//
//  CollectionViewCell.swift
//  Hubsch
//
//  Created by Piter Stivenson on 04.03.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var price:UILabel!
    
    func setupView(itemImage:UIImage,itemTitle:String,itemPrice:String) {
        image.image = itemImage
        title.text = itemTitle
        price.text = itemPrice
    }
}
