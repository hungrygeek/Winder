//
//  PeerProfileViewController.swift
//  Winder
//
//  Created by Rokee on 3/31/17.
//  Copyright © 2017 Winder. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PeerProfileViewController: UIViewController{
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var ref: FIRDatabaseReference!
//        ref = FIRDatabase.database().reference()
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        
//        
//        
//        ref.child("users").child(userID!).child("image").observeSingleEvent(of: .value, with: { (snapshot) in
//            if String(describing: snapshot.value!) != "" {
//                self.loadImageUsingCacheWithUrlString(String(describing: snapshot.value!))
//            } else {
//                self.profileImageView.image = UIImage(named: "avatar1")
//            }
//            
//        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        
        
        ref.child("users").child(userID!).child("image").observeSingleEvent(of: .value, with: { (snapshot) in
            if String(describing: snapshot.value!) != "" {
                self.loadImageUsingCacheWithUrlString(String(describing: snapshot.value!))
            } else {
                self.profileImageView.image = UIImage(named: "avatar1")
            }
            
        })
    }
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    
                    self.profileImageView.image = downloadedImage
                }
                
            })
            
        }).resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
