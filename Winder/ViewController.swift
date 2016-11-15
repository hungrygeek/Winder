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
//        let vc = MatchViewController()
//        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
//        presentViewController(vc, animated: false, completion: nil)
//        print("go")
    }
    
    override func viewDidAppear(animated: Bool) {
        let vc = MatchViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: false, completion: nil)
        print("go")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
}

