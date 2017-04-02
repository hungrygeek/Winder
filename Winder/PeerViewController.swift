//
//  PeerViewController.swift
//  Winder
//
//  Created by Rokee on 4/1/17.
//  Copyright © 2017 Winder. All rights reserved.
//

import UIKit
import Firebase

class PeerViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var ref: FIRDatabaseReference!
        self.view.backgroundColor = UIColor.white
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(userID!).child("image").observeSingleEvent(of: .value, with: { (snapshot) in
            if String(describing: snapshot.value!) != "" {
                self.loadImageUsingCacheWithUrlString(String(describing: snapshot.value!))
            } else {
                //                self.profileImageView.image = UIImage(named: "avatar1")
            }
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
                } else {
                    print("downloaded image wrong cast to UIImage")
                }
            })
        }).resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
