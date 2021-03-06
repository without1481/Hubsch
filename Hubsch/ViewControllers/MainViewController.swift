//
//  ViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 04.03.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit
import Kingfisher
import AACarousel

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AACarouselDelegate {

    let pathArray  = ["defaultImage","defaultImage","defaultImage","defaultImage"]
    let titleArray = ["1","2","3","4"]
    
    private let ItemInfo = [
        ["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],["title":"Hubsch","imageUrl":"girl","price":"$100"],
        ["title":"Hubsch","imageUrl":"girl","price":"$100"]
    ]
    
    @IBOutlet weak var carouselView:AACarousel!
    @IBOutlet weak var collect:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collect.delegate = self
        collect.dataSource = self
        
        carouselView.delegate = self
        carouselView.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
        //optional methods
        carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 0, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        print(index)
    }
    
    //optional method (show first image faster during downloading of all images)
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    
    func startAutoScroll() {
        //optional method
        carouselView.startScrollImageView()
        
    }
    
    func stopAutoScroll() {
        //optional method
        carouselView.stopScrollImageView()
    }
    
    //require method
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.carouselView.images[index] = downloadImage!
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath) as! CollectionViewCell
        cell.setupView(itemImage: UIImage(named:ItemInfo[indexPath.row]["imageUrl"]!)!, itemTitle: ItemInfo[indexPath.row]["title"]!, itemPrice: ItemInfo[indexPath.row]["price"]!, isFavourite: false, id: indexPath.row)
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
