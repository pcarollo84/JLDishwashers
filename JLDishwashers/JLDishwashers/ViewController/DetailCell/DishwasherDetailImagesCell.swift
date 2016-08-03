//
//  DishwasherDetailImagesCell.swift
//  JLDishwashers
//
//  Created by Paolo Carollo on 3/08/2016.
//  Copyright © 2016 Paolo Carollo. All rights reserved.
//

import UIKit

class DishwasherDetailImagesCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var imagesScrollView: UIScrollView!
    
    @IBOutlet weak var imagesPageControl: UIPageControl!
    
    let netWorkController = NetworkController()
    
    var imageURLs: [String]? {
        
        didSet{
            
            updateUI()
            
        }
    }
    
    override func awakeFromNib() {
        
        imagesScrollView.delegate = self
    
        imagesPageControl.addTarget(self, action: #selector(DishwasherDetailImagesCell.handlePageControlValueChanged(_:)), forControlEvents: .ValueChanged)
        
    }
    
    func updateUI() {

        imagesPageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        imagesPageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        
        for subview in imagesScrollView.subviews {
            subview.removeFromSuperview()
        }
        
        layoutIfNeeded()
        
        print("Content size")
        print(imagesScrollView.contentSize)
    }
    

    func buildImagesRoll(){
        
        guard let imageURLsNotNil = imageURLs else {return}
        
        imagesPageControl.numberOfPages = imageURLsNotNil.count
        imagesPageControl.currentPage = 0
        
        var x = 0.0 as CGFloat
        
        for imageURL in imageURLsNotNil {
            
            print("first")
            print(imagesScrollView.frame)
            
            let imageView = UIImageView(frame: CGRect(x: x, y: 0, width: imagesScrollView.frame.size.width, height: imagesScrollView.frame.size.height - 20))
            imageView.contentMode = .ScaleAspectFit
            
            x = x + imagesScrollView.frame.size.width
            
            imagesScrollView.addSubview(imageView)
            
            netWorkController.downloadImageWithURLString(imageURL, completion: { (image) in
                
                imageView.image = image
                
            })
            
        }
        
        imagesScrollView.contentSize = CGSize(width: x, height: imagesScrollView.frame.size.height - 20)

        
    }
    
    //MARK: ScrollView Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let numberOfPage = scrollView.contentOffset.x / scrollView.frame.size.width
        
        imagesPageControl.currentPage = Int(numberOfPage)
        
    }
    
    func handlePageControlValueChanged(pageControl: UIPageControl) {
        
        let x = CGFloat(pageControl.currentPage) * imagesScrollView.frame.size.width
        
        imagesScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        
    }


    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        

        buildImagesRoll()
       
        
    }
    
    
}
