//
//  FavouritesViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 04.03.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    private var ItemInfo = [
        ["title":"Hubsch","imageUrl":"dress","price":"$100","status":true],["title":"Hubsch","imageUrl":"dress","price":"$101","status":true],["title":"Hubsch","imageUrl":"dress","price":"$102","status":true],["title":"Hubsch","imageUrl":"dress","price":"$103","status":true],["title":"Hubsch","imageUrl":"dress","price":"$104","status":true],["title":"Hubsch","imageUrl":"dress","price":"$105","status":true],["title":"Hubsch","imageUrl":"dress","price":"$106","status":true],["title":"Hubsch","imageUrl":"dress","price":"$107","status":true],["title":"Hubsch","imageUrl":"dress","price":"$108","status":true],
        ["title":"Hubsch","imageUrl":"dress","price":"$109","status":true]
    ]
    
    @IBOutlet weak var collect:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collect.delegate = self
        collect.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath) as! CollectionViewCell
        cell.setupView(itemImage: UIImage(named:ItemInfo[indexPath.row]["imageUrl"]! as! String)!, itemTitle: ItemInfo[indexPath.row]["title"]! as! String, itemPrice: ItemInfo[indexPath.row]["price"]! as! String, isFavourite: ItemInfo[indexPath.row]["status"]! as! Bool, id: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    @IBAction func changeItemStatus(_ sender:UIButton) {
        ItemInfo.remove(at: sender.tag)
        //ItemInfo[sender.tag]["status"] = !(ItemInfo[sender.tag]["status"]! as! Bool)
        collect.reloadData()
    }

}
