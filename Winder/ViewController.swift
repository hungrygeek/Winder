//
//  ViewController.swift
//  Winder
//
//  Created by ShiShu on 11/11/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        logInUserName.center = CGPoint(x: self.view.center.x, y: 450)
        logInUserName.layer.borderColor = UIColor.blackColor().CGColor
        logInUserName.layer.backgroundColor = UIColor.grayColor().CGColor
        logInUserName.alpha = 0.8
        logInUserName.layer.cornerRadius = 10
        self.view.addSubview(logInUserName)
        
        let logInPassword = UITextField()
        logInPassword.frame = CGRectMake(0, 0, 300, 50)
        logInPassword.center = CGPoint(x: self.view.center.x, y: 550)
        logInPassword.layer.borderColor = UIColor.blackColor().CGColor
        logInPassword.layer.backgroundColor = UIColor.grayColor().CGColor
        logInPassword.alpha = 0.8
        logInPassword.layer.cornerRadius = 10
        self.view.addSubview(logInPassword)
        
        let logInButton = UIButton()
        logInButton.frame = CGRectMake(0, 0, 300, 50)
        logInButton.center = CGPoint(x: self.view.center.x, y: 650)
        logInButton.setTitle("LOG IN", forState: UIControlState.Normal)
        logInButton.titleLabel?.textColor = UIColor.whiteColor()
        logInButton.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        logInButton.layer.cornerRadius = 10
        self.view.addSubview(logInButton)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

