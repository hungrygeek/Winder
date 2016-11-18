//
//  MatchViewController.swift
//  Winder
//
//  Created by Rokee on 11/12/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit

class MatchViewController:UIViewController{
    
//    var profileButton
    
    var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Cat Wang"
        label.textColor = UIColor.redColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(25, weight: UIFontWeightLight)
        label.frame = CGRect(x:0,y:0,width: 200,height: 50)
        return label
    }()
    
    var schoolLabel:UILabel = {
        let label = UILabel()
        label.text = "Cashington University"
        label.textColor = UIColor.redColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        label.frame = CGRect(x:0,y:0,width: 200,height: 50)
        return label
    }()

    var likeButton: UIButton = {
        let checkImg = UIImage(named:"check_mark")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 100,height: 100)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        return button
    }()
    
    var dislikeButton: UIButton = {
        let checkImg = UIImage(named:"cross_mark")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 100,height: 100)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        return button
    }()
    
    var personButton: UIButton = {
        let checkImg = UIImage(named:"person")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 45,height: 45)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        return button
    }()
    
    override func viewDidAppear(animated: Bool) {
        print("here")
//        print(view.backgroundColor)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeButton.center = CGPoint(x: view.frame.width-likeButton.frame.width, y: view.frame.height-likeButton.frame.height)
        view.addSubview(likeButton)
        
        dislikeButton.center = CGPoint(x: likeButton.frame.width, y: view.frame.height-likeButton.frame.height)
        view.addSubview(dislikeButton)
        
        
        personButton.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height)
        view.addSubview(personButton)
        
        nameLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2)
        view.addSubview(nameLabel)
        
        schoolLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*1.618)
        view.addSubview(schoolLabel)
        
        view.backgroundColor = UIColor.whiteColor()
    }
    
}
