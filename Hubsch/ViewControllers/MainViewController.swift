//
//  ViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 04.03.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    private let ItemInfo = [
        ["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],["title":"Hubsch","imageUrl":"dress","price":"$100"],
        ["title":"Hubsch","imageUrl":"dress","price":"$100"]
    ]
    
    @IBOutlet weak var imageSlider:UIView!
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
        cell.setupView(itemImage: UIImage(named:ItemInfo[indexPath.row]["imageUrl"]!)!, itemTitle: ItemInfo[indexPath.row]["title"]!, itemPrice: ItemInfo[indexPath.row]["price"]!)
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
    
}
