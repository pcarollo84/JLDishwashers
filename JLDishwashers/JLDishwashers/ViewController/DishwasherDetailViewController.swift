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
    
    var priceViewController: DishwasherDetailPriceViewController?
    
    var showDetailPriceAsFooter = false
    
    @IBOutlet weak var productDetailTableView: UITableView!
    
    @IBOutlet weak var productDetailPriceContainerView: UIView!
    
    @IBOutlet weak var productDetailPriceContainerViewWidthLayoutConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.backgroundColor()
        
        productDetailTableView.dataSource = self
        productDetailTableView.delegate = self
        
        let netWorkController = NetworkController()
        
        guard let productNotNil = product,  productId = productNotNil.productId else { return }
        
        self.navigationItem.title = productNotNil.title
        
        netWorkController.productDetail(productId) { (result) in
            
            self.product = result
            
            self.productDetailTableView.reloadData()
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        checkOrientation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "priceEmbeddedSegue" {
            
            guard let priceViewControllerNotNil = segue.destinationViewController as? DishwasherDetailPriceViewController else { return }
            
            priceViewController = priceViewControllerNotNil
            
            priceViewControllerNotNil.product = product
            
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
            return 2
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
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("productDetailInfoCellId", forIndexPath: indexPath) as! DishwasherDetailInfoCell

                cell.product = product
                
                return cell
                
            }else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("productDetailCodeCellId", forIndexPath: indexPath) as! DishwasherDetailCodeCell
                
                guard let code = product!.code else {return cell}
                
                cell.code = code
                
                return cell
                
            }
            
            
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
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section != 0 || showDetailPriceAsFooter == false {return nil}
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let priceDetailVC = storyboard.instantiateViewControllerWithIdentifier("detailPriceVC") as! DishwasherDetailPriceViewController
        
        priceDetailVC.product = product
        
        guard let subview = priceDetailVC.view else { return nil }
        
        subview.backgroundColor = UIColor.clearColor()
        footerView.addSubview(subview)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.backgroundColor = UIColor.whiteColor()
        
        
        return footerView
        
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
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return showDetailPriceAsFooter ? 150 : 1
        }
        
        return 1
    }
    
    //MARK: Orientation
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        checkOrientation()
        
    }
    
    func checkOrientation(){

        switch UIDevice.currentDevice().orientation {
        case UIDeviceOrientation.Portrait, UIDeviceOrientation.PortraitUpsideDown:
            productDetailPriceContainerViewWidthLayoutConstraint.constant = 0
            showDetailPriceAsFooter = true
        case UIDeviceOrientation.LandscapeLeft, UIDeviceOrientation.LandscapeRight:
            productDetailPriceContainerViewWidthLayoutConstraint.constant = 380
            showDetailPriceAsFooter = false
        default:
            productDetailPriceContainerViewWidthLayoutConstraint.constant = 380
            showDetailPriceAsFooter = false
        }
        
        
        self.productDetailTableView.reloadData()
        
    }

    
}
