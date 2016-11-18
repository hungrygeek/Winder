//
//  ViewController.swift
//  Winder
//
//  Created by ShiShu on 11/11/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    let backgroundPic = UIImageView()
    let logoImage = UIImageView()
    let choseButtonLeft = UIButton()
    let choseButtonRight = UIButton()
    let logInUserName = UITextField()
    let underlineUsername = UIView()
    let logInPassword = UITextField()
    let signUpPassword = UITextField()
    let underlinePassword2 = UIView()
    let underlinePassword = UIView()
    let logInButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //background setting
        
        backgroundPic.frame = self.view.frame
        backgroundPic.center = self.view.center
        backgroundPic.image = UIImage(named: "background1")
        backgroundPic.alpha = 0.4
        self.view.addSubview(backgroundPic)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        blurEffectView.alpha = 0.7
        view.addSubview(blurEffectView)
        
        logoImage.frame = CGRectMake(0, 0, 300, 300)
        logoImage.center = CGPoint(x: self.view.center.x,y: 200)
        logoImage.image = UIImage(named: "logo")
        self.view.addSubview(logoImage)
        
        //mode change button
        
//        let logInChose = UIButton()
//        logInChose.frame = CGRectMake(0, 0, 50, 30)
//        logInChose.center = CGPoint(x: self.view.center.x-40, y: 380)
//        logInChose.setTitle("Log In", forState: UIControlState.Normal)
        
        
        choseButtonLeft.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        choseButtonLeft.center = CGPoint(x: self.view.center.x-75, y: 370)
        //choseButtonLeft.layer.backgroundColor = UIColor.blackColor().CGColor
        let rectShape = CAShapeLayer()
        rectShape.frame = choseButtonLeft.bounds
        rectShape.path = UIBezierPath(roundedRect: rectShape.bounds, byRoundingCorners: [UIRectCorner.BottomLeft,UIRectCorner.TopLeft], cornerRadii: CGSize(width: 25, height: 25)).CGPath
        choseButtonLeft.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        choseButtonLeft.layer.mask = rectShape
        choseButtonLeft.setTitle("Log In", forState: UIControlState.Normal)
        choseButtonLeft.titleLabel?.textColor = UIColor.whiteColor()
        self.view.addSubview(choseButtonLeft)
        
        choseButtonLeft.addTarget(self, action: #selector(ViewController.choseLogIn), forControlEvents:UIControlEvents.TouchUpInside)

        
        choseButtonRight.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        choseButtonRight.center = CGPoint(x: self.view.center.x+75, y: 370)
        let rectShape2 = CAShapeLayer()
        rectShape2.frame = choseButtonRight.bounds
        rectShape2.path = UIBezierPath(roundedRect: rectShape2.bounds, byRoundingCorners: [UIRectCorner.BottomRight,UIRectCorner.TopRight], cornerRadii: CGSize(width: 25, height: 25)).CGPath
        choseButtonRight.layer.backgroundColor = UIColor.grayColor().CGColor
        choseButtonRight.layer.mask = rectShape2
        choseButtonRight.setTitle("Sign Up", forState: UIControlState.Normal)
        choseButtonRight.titleLabel?.textColor = UIColor.whiteColor()
        self.view.addSubview(choseButtonRight)
       
        choseButtonRight.addTarget(self, action: #selector(ViewController.choseSignUp), forControlEvents:UIControlEvents.TouchUpInside)
        
        //username textfield
        
        logInUserName.frame = CGRectMake(0, 0, 300, 50)
        logInUserName.center = CGPoint(x: self.view.center.x, y: 440)
        //logInUserName.layer.borderColor = UIColor.whiteColor().CGColor
        //logInUserName.layer.borderWidth = 3
        //logInUserName.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65).CGColor
        //logInUserName.layer.cornerRadius = 10
        logInUserName.textColor = UIColor.getWustlGreenColor(UIColor())()
        logInUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.getWustlGreenColor(UIColor())()])
        self.view.addSubview(logInUserName)
        
        underlineUsername.frame = CGRectMake(0, 0, 300, 1)
        underlineUsername.center = CGPoint(x: logInUserName.center.x, y: logInUserName.center.y+10)
        underlineUsername.backgroundColor = UIColor.getWustlGreenColor(UIColor())()
        self.view.addSubview(underlineUsername)
    
        //password textfield
        
        logInPassword.frame = CGRectMake(0, 0, 300, 50)
        logInPassword.center = CGPoint(x: self.view.center.x, y: 510)
        //logInPassword.layer.borderColor = UIColor.whiteColor().CGColor
        //logInPassword.layer.borderWidth = 3
        //logInPassword.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65).CGColor
        //logInPassword.layer.cornerRadius = 10
        logInPassword.textColor = UIColor.getWustlGreenColor(UIColor())()
        logInPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.getWustlGreenColor(UIColor())()])
        logInPassword.secureTextEntry = true
        self.view.addSubview(logInPassword)
        
        underlinePassword.frame = CGRectMake(0, 0, 300, 1)
        underlinePassword.center = CGPoint(x: logInUserName.center.x, y: logInPassword.center.y+10)
        underlinePassword.backgroundColor = UIColor.getWustlGreenColor(UIColor())()
        self.view.addSubview(underlinePassword)
        
        // sign up password again
        
        signUpPassword.frame = CGRectMake(0, 0, 300, 50)
        signUpPassword.center = CGPoint(x: self.view.center.x, y: 580)
        signUpPassword.textColor = UIColor.getWustlGreenColor(UIColor())()
        signUpPassword.attributedPlaceholder = NSAttributedString(string: "Repeat Your Password", attributes: [NSForegroundColorAttributeName: UIColor.getWustlGreenColor(UIColor())()])
        signUpPassword.secureTextEntry = true
        self.view.addSubview(signUpPassword)
        
        
        underlinePassword2.frame = CGRectMake(0, 0, 300, 1)
        underlinePassword2.center = CGPoint(x: logInUserName.center.x, y: signUpPassword.center.y+10)
        underlinePassword2.backgroundColor = UIColor.getWustlGreenColor(UIColor())()
        self.view.addSubview(underlinePassword2)
        
        signUpPassword.hidden = true
        underlinePassword2.hidden = true
        
        // Login button setting
        
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
        let vc = PersonalViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: false, completion: nil)
        print("Clicked")
    }
    
    func choseLogIn(){
        print("log in mode chosen")
        choseButtonRight.layer.backgroundColor = UIColor.grayColor().CGColor
        choseButtonLeft.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        signUpPassword.hidden = true
        underlinePassword2.hidden = true
    }
    
    func choseSignUp(){
        print("sign up mode chosen")
        choseButtonRight.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        choseButtonLeft.layer.backgroundColor = UIColor.grayColor().CGColor
        signUpPassword.hidden = false
        underlinePassword2.hidden = false
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

