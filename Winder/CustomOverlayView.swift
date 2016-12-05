//
//  OverlayView.swift
//  Winder
//
//  Created by Rokee on 11/20/16.
//  Copyright © 2016 cse438. All rights reserved.
//


import UIKit
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class CustomOverlayView: OverlayView {
    
    
    @IBOutlet lazy var overlayImageView: UIImageView!={
        [unowned self] in
        
        var imageView = UIImageView(frame:self.bounds)
//        imageView.layer.backgroundColor = UIColor.clearColor().CGColor
        self.addSubview(imageView)
        return imageView
        
    }()
    
    override var overlayState: SwipeResultDirection?{
        didSet{
            switch overlayState {
            case .Left?:
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .Right?:
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }
}