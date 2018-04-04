//
//  CartShopTableViewCell.swift
//  Hubsch
//
//  Created by Piter Stivenson on 07.03.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class CartShopTableViewCell: UITableViewCell {

    @IBOutlet weak var imageItem:UIImageView!
    @IBOutlet weak var titleItem:UILabel!
    @IBOutlet weak var priceItem:UILabel!
    @IBOutlet weak var sizeItem:UILabel!
    @IBOutlet weak var countItem:UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCellView(image:UIImage,title:String,price:String,size:String,count:String){
        imageItem.image = image
        titleItem.text = title
        priceItem.text = price
        countItem.text = count
        sizeItem.text = size
    }
}
