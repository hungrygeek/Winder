//
//  logInViewController.swift
//  Winder
//
//  Created by Yugui Chen on 16/11/12.
//  Copyright © 2016年 cse438. All rights reserved.
//

import UIKit

class logInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let backgroundPic = UIImageView()
        backgroundPic.frame = self.view.frame
        backgroundPic.center = self.view.center
        backgroundPic.image = UIImage(named: "background")
        backgroundPic.alpha = 0.5
        self.view.addSubview(backgroundPic)
        
        let logoImage = UIImageView()
        logoImage.frame = CGRectMake(0, 0, 300, 300)
        logoImage.center = CGPoint(x: self.view.center.x,y: 200)
        logoImage.image = UIImage(named: "logo")
        self.view.addSubview(logoImage)
        
        let logInUserName = UITextField()
        logInUserName.frame = CGRectMake(0, 0, 300, 50)
        logInUserName.center = CGPoint(x: self.view.center.x, y: 400)
        logInUserName.layer.borderColor = UIColor.blackColor().CGColor
        logInUserName.layer.backgroundColor = UIColor.whiteColor().CGColor
        logInUserName.alpha = 0.8
        logInUserName.layer.cornerRadius = 10
        self.view.addSubview(logInUserName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


