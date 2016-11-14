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
        
        //background setting
        
        let backgroundPic = UIImageView()
        backgroundPic.frame = self.view.frame
        backgroundPic.center = self.view.center
        backgroundPic.image = UIImage(named: "background1")
        backgroundPic.alpha = 0.4
        self.view.addSubview(backgroundPic)
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        blurEffectView.alpha = 0.6
        view.addSubview(blurEffectView)
        
        let logoImage = UIImageView()
        logoImage.frame = CGRectMake(0, 0, 300, 300)
        logoImage.center = CGPoint(x: self.view.center.x,y: 200)
        logoImage.image = UIImage(named: "logo")
        self.view.addSubview(logoImage)
        
        //mode change button
        
//        let logInChose = UIButton()
//        logInChose.frame = CGRectMake(0, 0, 50, 30)
//        logInChose.center = CGPoint(x: self.view.center.x-40, y: 380)
//        logInChose.setTitle("Log In", forState: UIControlState.Normal)
        
        let choseButtonLeft = UIButton()
        choseButtonLeft.frame = CGRectMake(0, 0, 150, 50)
        //choseButtonLeft.center = CGPoint(x: self.view.center.x-75, y: 370)
        //choseButtonLeft.layer.backgroundColor = UIColor.blackColor().CGColor
        let rectShape = CAShapeLayer()
        rectShape.bounds = choseButtonLeft.frame
        rectShape.position = choseButtonLeft.center
        rectShape.path = UIBezierPath(roundedRect: rectShape.bounds, byRoundingCorners: [UIRectCorner.BottomLeft,UIRectCorner.TopLeft], cornerRadii: CGSize(width: 25, height: 25)).CGPath
        choseButtonLeft.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        choseButtonLeft.layer.mask = rectShape
        
        self.view.addSubview(choseButtonLeft)
        
        //username textfield
        
        let logInUserName = UITextField()
        logInUserName.frame = CGRectMake(0, 0, 300, 50)
        logInUserName.center = CGPoint(x: self.view.center.x, y: 450)
        //logInUserName.layer.borderColor = UIColor.whiteColor().CGColor
        //logInUserName.layer.borderWidth = 3
        //logInUserName.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65).CGColor
        //logInUserName.layer.cornerRadius = 10
        logInUserName.textColor = UIColor.getWustlGreenColor(UIColor())()
        logInUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.getWustlGreenColor(UIColor())()])
        self.view.addSubview(logInUserName)
        
        let underlineUsername = UIView()
        underlineUsername.frame = CGRectMake(0, 0, 300, 1)
        underlineUsername.center = CGPoint(x: logInUserName.center.x, y: logInUserName.center.y+10)
        underlineUsername.backgroundColor = UIColor.getWustlGreenColor(UIColor())()
        self.view.addSubview(underlineUsername)
    
        //password textfield
        
        let logInPassword = UITextField()
        logInPassword.frame = CGRectMake(0, 0, 300, 50)
        logInPassword.center = CGPoint(x: self.view.center.x, y: 550)
        //logInPassword.layer.borderColor = UIColor.whiteColor().CGColor
        //logInPassword.layer.borderWidth = 3
        //logInPassword.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65).CGColor
        //logInPassword.layer.cornerRadius = 10
        logInPassword.textColor = UIColor.whiteColor()
        logInPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.getWustlGreenColor(UIColor())()])
        logInPassword.secureTextEntry = true
        self.view.addSubview(logInPassword)
        
        let underlinePassword = UIView()
        underlinePassword.frame = CGRectMake(0, 0, 300, 1)
        underlinePassword.center = CGPoint(x: logInUserName.center.x, y: logInPassword.center.y+10)
        underlinePassword.backgroundColor = UIColor.getWustlGreenColor(UIColor())()
        self.view.addSubview(underlinePassword)
        
        // Login button setting
        
        let logInButton = UIButton()
        logInButton.frame = CGRectMake(0, 0, 300, 50)
        logInButton.center = CGPoint(x: self.view.center.x, y: 650)
        logInButton.setTitle("LOG IN", forState: UIControlState.Normal)
        logInButton.titleLabel?.textColor = UIColor.whiteColor()
        logInButton.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        logInButton.layer.cornerRadius = 25
        self.view.addSubview(logInButton)
        
        logInButton.addTarget(self, action: #selector(ViewController.logInClick), forControlEvents:UIControlEvents.TouchUpInside)
        
        
    }
    
    func logInClick(){
        print("Clicked")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

