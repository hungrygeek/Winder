//
//  OverlayView.swift
//  Winder
//
//  Created by Rokee on 11/20/16.
//  Copyright © 2016 cse438. All rights reserved.
//


import UIKit
import Koloda

private let overlayRightImageName = "swipeRight"
private let overlayLeftImageName = "swipeLeft"

class CustomOverlayView: OverlayView {
    
    
    @IBOutlet lazy var overlayImageView: UIImageView!={
        [unowned self] in
        
        var imageView = UIImageView(frame:self.bounds)
//          imageView.clipsToBounds = true
//          imageView.backgroundColor = UIColor.clearColor()
        self.addSubview(imageView)
        
        return imageView
        
    }()
    
    
    override var overlayState: SwipeResultDirection?{
        didSet{
            switch overlayState {
            case .Left?:
                overlayImageView.image = UIImage(named: overlayLeftImageName)
//                overlayImageView.clipsToBounds = true
//                overlayImageView.backgroundColor = UIColor.clearColor()
                
            case .Right?:
                overlayImageView.image = UIImage(named: overlayRightImageName)
//                overlayImageView.clipsToBounds = true
//                overlayImageView.backgroundColor = UIColor.clearColor()
                
                
            default:
                overlayImageView.image = nil
            }
        }
    }
}