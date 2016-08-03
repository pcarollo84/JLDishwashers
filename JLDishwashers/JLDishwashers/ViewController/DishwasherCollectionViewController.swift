//
//  DishwasherCollectionViewController.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 29/07/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var products: [Product] = []
    
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.backgroundColor()
        self.collectionView?.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.title = "Dishwashers"
        
        let netWorkController = NetworkController()
        
        netWorkController.listOfDishwashers({
            
            (result: [Product]?) in
            
            for product in result!{
                
                print(product.productId)
                
            }

            guard let products = result else {return}
            
            self.products = products
            
            self.navigationItem.title = "Dishwashers (" + String(products.count) + ")"
            
            self.collectionView?.reloadData()
            
        })
        
    }
    
    //MARK: UICollectionView DataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dishwasherCollectionViewCellId", forIndexPath: indexPath) as! DishwasherCollectionViewCell
        cell.product = products[indexPath.row]
        
        return cell
        
    }
    
    //MARK: UICollectionView Delegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedProduct = products[indexPath.row]
        self.performSegueWithIdentifier("showProductDetailSegue", sender: self)
        
    }
    
    //MARK: UICollectionView Layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var horizontalNumberOfCells: CGFloat
        
        var verticalNumberOfCells:CGFloat
        
        switch UIDevice.currentDevice().orientation {
        case UIDeviceOrientation.Portrait:
            horizontalNumberOfCells = 3
            verticalNumberOfCells = 3
        case UIDeviceOrientation.LandscapeLeft, UIDeviceOrientation.LandscapeRight:
            horizontalNumberOfCells = 4
            verticalNumberOfCells = 2
        default:
            horizontalNumberOfCells = 3
            verticalNumberOfCells = 3
        }
        
        
        return CGSize(width: self.view.frame.size.width / horizontalNumberOfCells - 1, height: self.view.frame.size.height / verticalNumberOfCells - 1)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    //MARK: Orientation

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("transition")
        self.collectionView?.reloadData()
    }
    
    //MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showProductDetailSegue" {
            
            let destinationVC = segue.destinationViewController as! DishwasherDetailViewController
            
            guard let product = selectedProduct else {return}
            
            destinationVC.product = product
            
        }
        
    }
    
}

