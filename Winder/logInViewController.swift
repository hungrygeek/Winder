//
//  LoginViewController.swift
//  Winder
//
//  Created by Rokee on 4/10/17.
//  Copyright © 2017 Winder. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
//        signUpButton.addTarget(self, action: #selector(gotoSignUp), for:UIControlEvents.touchUpInside)
    }
    
    
    @IBAction func Login(_ sender: Any) {
        print("login")
    }
    @IBAction func singUp(_ sender: Any) {
        print("sign up")

    }
}
