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
    @IBOutlet weak var passwordRepeatView: UIView!
    @IBOutlet weak var passwordRepeatInput: UITextField!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonView.layer.cornerRadius = buttonView.frame.size.height/2
        buttonView.layer.backgroundColor = UIColor.getWustlGreen(UIColor())().cgColor
        buttonLabel.text = "Login"
        passwordRepeatView.isHidden = true
    }
    
}
