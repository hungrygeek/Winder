//
//  PeerViewController.swift
//  Winder
//
//  Created by Rokee on 4/1/17.
//  Copyright © 2017 Winder. All rights reserved.
//

import UIKit
import Firebase

class PeerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
   
    @IBAction func CloseThisView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    var array = [ ["Moscow", "Saint Petersburg", "Novosibirsk", "Novosibirsk", "Nizhny Novgorod", "Samara", "Omsk" ],
                  
                  ["Kiyv", "Odessa", "Donetsk", "Harkiv", "Lviv", "Uzhgorod", "Zhytomyr", "Luhansk", "Mikolayv", "Kherson"],
                  
                  ["Berlin", "Hamburg", "Munich", "Cologne", "Frankfurt", "Stuttgart", "Düsseldorf", "Dortmund", "Essen", "Bremen"]]
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
//        tableView.register(GroupedCellsViewTableViewCell.self, forCellReuseIdentifier: "infoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
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
                    self.tableView.backgroundColor = UIColor.yellow
                    self.headerView.backgroundColor = UIColor.blue
                } else {
                    print("downloaded image wrong cast to UIImage")
                }
            })
        }).resume()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "infoCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier) as? PeerInfoTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("PeerInfoTableViewCell", owner: self, options: nil)?.first as? PeerInfoTableViewCell
                }
        cell?.title?.text = "title \(indexPath.row)"
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  array[section][0]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("GroupedCellsViewTableViewCell", owner: self, options: nil)?.first as! GroupedCellsViewTableViewCell
        header.backgroundColor = UIColor.green
        header.headerLabel.text = "!"
        header.footerLabel.text = "?"
        return header
    }
    
    // this is set in storyboard
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return CGFloat(0.0)
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
}
