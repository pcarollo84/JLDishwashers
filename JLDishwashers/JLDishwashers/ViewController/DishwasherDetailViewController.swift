//
//  DishwasherDetailViewController.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 3/08/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var product: Product?
    
    @IBOutlet weak var productDetailTableView: UITableView!
    
    @IBOutlet weak var productDetailPriceContainerView: UIView!
    
    @IBOutlet weak var productDetailPriceContainerViewWidthLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.backgroundColor()
        
        productDetailTableView.dataSource = self
        productDetailTableView.delegate = self
        
        let netWorkController = NetworkController()
        
        guard let productNotNil = product,  productId = productNotNil.productId else { return }
        
        netWorkController.productDetail(productId) { (result) in
            
            self.product = result
            
            self.productDetailTableView.reloadData()
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        checkOrientation()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "priceEmbeddedSegue" {
            
            let embeddedVC = segue.destinationViewController as! DishwasherDetailPriceViewController
            
            embeddedVC.product = product
            
        }
    }
    
    //MARK: UITableView Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            
            guard let productNotNil = product, featuresNotNil = productNotNil.features else {return 0}
            
            return featuresNotNil.count
            
        default:
            return 1
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("productDetailImagesCellId", forIndexPath: indexPath) as! DishwasherDetailImagesCell
            
            cell.imageURLs = product!.imageDetails
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("productDetailInfoCellId", forIndexPath: indexPath) as! DishwasherDetailInfoCell
            
            cell.product = product
            
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("productDetailSpecificationCellId", forIndexPath: indexPath) as! DishwasherDetailSpecificationCell
            
            guard let productNotNil = product, featuresNotNil = productNotNil.features else {return cell}
            
            cell.feature = featuresNotNil[indexPath.row]
            
            return cell
            
            
        default:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("")
            return cell!
        }
        
    }
 
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Product Information"
        case 2:
            return "Product Specification"
            
        default:
            return nil
        }
    }
    
    //MARK: UITableView Delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 550
        case 1:
            return UITableViewAutomaticDimension
        default:
            return 44
        }
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: Orientation
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        checkOrientation()
        
    }
    
    func checkOrientation(){

        switch UIDevice.currentDevice().orientation {
        case UIDeviceOrientation.Portrait:
            productDetailPriceContainerViewWidthLayoutConstraint.constant = 0
        case UIDeviceOrientation.LandscapeLeft, UIDeviceOrientation.LandscapeRight:
            productDetailPriceContainerViewWidthLayoutConstraint.constant = 380
        default:
            productDetailPriceContainerViewWidthLayoutConstraint.constant = 380
        }
        
        self.productDetailTableView.reloadData()

        
    }

    
}
