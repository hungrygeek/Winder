//
//  ViewController.swift
//  Winder
//
//  Created by ShiShu on 11/11/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UIAlertViewDelegate {
    

    private let backgroundPic = UIImageView()
    private let logoImage = UIImageView()
    private let choseButtonLeft = UIButton()
    private let choseButtonRight = UIButton()
    private let logInUserName = UITextField()
    private let underlineUsername = UIView()
    private let logInPassword = UITextField()
    private let signUpPassword = UITextField()
    private let underlinePassword2 = UIView()
    private let underlinePassword = UIView()
    private let logInButton = UIButton()
    private let signUpButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in ViewController")
        // Do any additional setup after loading the view, typically from a nib.
        //background setting
        if FIRAuth.auth()?.currentUser != nil{
            print("DID login in viewDidLoad")
            goToMatchView()
//            let vc = PersonalViewController()
//            vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
//            presentViewController(vc, animated: true, completion: nil)
        } else {
            print("did NOT login in viewDidLoad")
        }
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
        logoImage.center = CGPoint(x: self.view.center.x,y: self.view.center.y*0.47)
        logoImage.image = UIImage(named: "logo")
        self.view.addSubview(logoImage)
        
        //mode change button
        
//        let logInChose = UIButton()
//        logInChose.frame = CGRectMake(0, 0, 50, 30)
//        logInChose.center = CGPoint(x: self.view.center.x-40, y: 380)
//        logInChose.setTitle("Log In", forState: UIControlState.Normal)
        
        
        choseButtonLeft.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        choseButtonLeft.center = CGPoint(x: self.view.center.x-75, y: self.view.center.y*0.95)
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
        choseButtonRight.center = CGPoint(x: self.view.center.x+75, y: self.view.center.y*0.95)
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
        logInUserName.center = CGPoint(x: self.view.center.x, y:self.view.center.y*1.2)
        //logInUserName.layer.borderColor = UIColor.whiteColor().CGColor
        //logInUserName.layer.borderWidth = 3
        //logInUserName.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65).CGColor
        //logInUserName.layer.cornerRadius = 10
        logInUserName.textColor = UIColor.getWustlGreenColor(UIColor())()
        logInUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.getWustlGreenColor(UIColor())()])
        logInUserName.text = "rokee.lv@gmail.com"
        self.view.addSubview(logInUserName)
        
        underlineUsername.frame = CGRectMake(0, 0, 300, 1)
        underlineUsername.center = CGPoint(x: logInUserName.center.x, y: logInUserName.center.y+10)
        underlineUsername.backgroundColor = UIColor.getWustlGreenColor(UIColor())()
        self.view.addSubview(underlineUsername)
    
        //password textfield
        
        logInPassword.frame = CGRectMake(0, 0, 300, 50)
        logInPassword.center = CGPoint(x: self.view.center.x, y: self.view.center.y*1.4)
        //logInPassword.layer.borderColor = UIColor.whiteColor().CGColor
        //logInPassword.layer.borderWidth = 3
        //logInPassword.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.65).CGColor
        //logInPassword.layer.cornerRadius = 10
        logInPassword.textColor = UIColor.getWustlGreenColor(UIColor())()
        logInPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.getWustlGreenColor(UIColor())()])
        logInPassword.secureTextEntry = true
        logInPassword.text = "111111"
        self.view.addSubview(logInPassword)
        
        underlinePassword.frame = CGRectMake(0, 0, 300, 1)
        underlinePassword.center = CGPoint(x: logInUserName.center.x, y: logInPassword.center.y+10)
        underlinePassword.backgroundColor = UIColor.getWustlGreenColor(UIColor())()
        self.view.addSubview(underlinePassword)
        
        // sign up password again
        
        signUpPassword.frame = CGRectMake(0, 0, 300, 50)
        signUpPassword.center = CGPoint(x: self.view.center.x, y: self.view.center.y*1.6)
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
        
        
        
        signUpButton.frame = CGRectMake(0, 0, 300, 50)
        signUpButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y*1.8)
        signUpButton.setTitle("SIGN UP", forState: UIControlState.Normal)
        signUpButton.titleLabel?.textColor = UIColor.whiteColor()
        signUpButton.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        signUpButton.layer.cornerRadius = 25
        self.view.addSubview(signUpButton)
        signUpButton.hidden = true
        
        signUpButton.addTarget(self, action: #selector(ViewController.signUpClick), forControlEvents:UIControlEvents.TouchUpInside)
        
        logInButton.frame = CGRectMake(0, 0, 300, 50)
        logInButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y*1.8)
        logInButton.setTitle("LOG IN", forState: UIControlState.Normal)
        logInButton.titleLabel?.textColor = UIColor.whiteColor()
        logInButton.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        logInButton.layer.cornerRadius = 25
        self.view.addSubview(logInButton)
        
        logInButton.addTarget(self, action: #selector(ViewController.logInClick), forControlEvents:UIControlEvents.TouchUpInside)
        
    }
    func goToMatchView(){
        let vc = PersonalViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: true, completion: nil)
    }
    func signOut(){
        print("sign out")
        // [START signout]
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // [END signout]
    }
    
    func logInClick(){
        
//        signOut()
//        if let email = logInUserName.text != nil && logInUserName.text != "" ? logInUserName.text : "rokee.lv@gmail.com", pwd = logInPassword.text != nil && logInPassword.text != "" ? logInPassword.text : "111111" {
        if let email = logInUserName.text, pwd = logInPassword.text{
            print("try to sign up with \(email) and \(pwd)")
            FIRAuth.auth()?.signInWithEmail(email, password: pwd) {
                (user, error) in
                if let error = error {
                    self.popUpAlert(error)
                    return
                }
                if FIRAuth.auth()?.currentUser != nil {
                    print("login success")
                    print("user \(user?.uid)")
                    print("display name \(FIRAuth.auth()?.currentUser?.displayName)")
                    print("login in with \(FIRAuth.auth()?.currentUser?.email)")
                    self.goToMatchView()
                } else {
                    print("error.localizedDescription", error?.localizedDescription)
                    print("error.localizedFailureReason", error?.localizedFailureReason)
                }
            }
            let vc = MatchViewController()
            vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            presentViewController(vc, animated: false, completion: nil)
        } else {
            print("something wrong")
        }
        
        
        
        // transition to next view

    }
    
    func signUpClick(){
        
        // [START signout]
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // [END signout]
        
        if let email = logInUserName.text, pwd = logInPassword.text where signUpPassword.text == logInPassword.text{
            // [START create_user]
            print("sign up with \(email) and \(pwd)")
            firebaseAuth?.createUserWithEmail(email, password: pwd) { (user, error) in
                //edit something basic into DB
                var ref: FIRDatabaseReference!
                ref = FIRDatabase.database().reference()
                if let user = user{
                    ref.child("users/\(user.uid)/username").setValue("ya name")
                    ref.child("users/\(user.uid)/school").setValue("ya school")
                    ref.child("users/\(user.uid)/email").setValue(email)
                } else {
                    self.popUpAlert(error!)
                    print("error \(error?.localizedDescription)")
                }
                
                
            }
            // [END create_user]

        } else {
            print("email/pass1/pass2 is wrong")
        }
//        if signUpPassword.text != logInPassword.text{
//            let alert = UIAlertController(title: "OOPS!", message: "You entered different password!", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//            print("Repeat Wrong Password")
//        }else{
//            let vc = PersonalViewController()
//            vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
//            presentViewController(vc, animated: true, completion: nil)
//        }
    }
    
    func choseLogIn(){
        print("log in mode chosen")
        choseButtonRight.layer.backgroundColor = UIColor.grayColor().CGColor
        choseButtonLeft.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        signUpPassword.hidden = true
        underlinePassword2.hidden = true
        signUpButton.hidden = true
        logInButton.hidden = false
    }
    
    func choseSignUp(){
//        signOut()
//        let firebaseAuth = FIRAuth.auth()
        print("is user logged in?", FIRAuth.auth()?.currentUser?.uid)
        print("sign up mode chosen")
        choseButtonRight.layer.backgroundColor = UIColor.getWustlGreenColor(UIColor())().CGColor
        choseButtonLeft.layer.backgroundColor = UIColor.grayColor().CGColor
        signUpPassword.hidden = false
        underlinePassword2.hidden = false
        signUpButton.hidden = false
        logInButton.hidden = true
        
    }
    
    func popUpAlert(error: NSError){
        print("error? \(error.localizedDescription)")
        let refreshAlert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        //
        //                    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
        //                        print("Handle Cancel Logic here")
        //                    }))
        
        self.presentViewController(refreshAlert, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
}

