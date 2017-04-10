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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func CloseThisView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var peerInfo: PersonalInfo!
    
    let backGroundGray = UIColor(red: 240/255, green: 241/255, blue: 240/255, alpha: 1)

    var sectionTitles = ["Academic", "Top Skills"]
    var numberOfRows = [2, 4]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        var ref: FIRDatabaseReference!
//        self.view.backgroundColor = UIColor.white
//        ref = FIRDatabase.database().reference()
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        ref.child("users").child(userID!).child("image").observeSingleEvent(of: .value, with: { (snapshot) in
//            if String(describing: snapshot.value!) != "" {
//                self.loadImageUsingCacheWithUrlString(String(describing: snapshot.value!))
//            } else {
//                self.profileImageView.image = UIImage(named: "avatar1")
//            }
//        })
        profileImageView.image = peerInfo.image.image
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        tableView.backgroundColor = backGroundGray
//        headerView.backgroundColor = backGroundGray
        nameLabel.text = peerInfo.username
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("unable to load image from url \(urlString)")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
            switch indexPath.row {
            case 0:
                (cell as! BasicCell).title.text = "School"
                (cell as! BasicCell).content.text = self.peerInfo.school
                break
            case 1:
                (cell as! BasicCell).title.text = "Email"
                (cell as! BasicCell).content.text = self.peerInfo.email
                break
            default: break
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "infoCell")!
            (cell as! PeerInfoTableViewCell).infoCellTitle?.text = "\(peerInfo.skills.allKeys[indexPath.row])"
            var newFrame = (cell as! PeerInfoTableViewCell).infoCellContent.frame
            newFrame.origin.y = newFrame.origin.y+5
            newFrame.size.height = newFrame.height-10
            let w = peerInfo.skills.allValues[indexPath.row] as! CGFloat
            newFrame.size.width = w/100*newFrame.size.width
            if newFrame.size.width <  newFrame.size.height {
                newFrame.size.width = newFrame.size.height
            }
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = newFrame
            let color1 = UIColor.getWustlGreen(UIColor())().cgColor
            let color2 = UIColor(red: 108/255, green: 115/255, blue: 115/255, alpha: 1).cgColor
            gradientLayer.colors = [color1, color2]
            if w >= 75 {
                gradientLayer.locations = [0.0, 0.75]
            } else {
                gradientLayer.locations = [0.75]
            }
            gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
            gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
            cell.layer.addSublayer(gradientLayer)
            gradientLayer.cornerRadius = newFrame.size.height/2
        }
        
        return cell
        
    }
    // will be overrided when there is tableView:viewForHeaderInSection
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("GroupedCellsViewTableViewCell", owner: self, options: nil)?.first as! GroupedCellsViewTableViewCell
        if section == 0 {
            header.headerLabel.text = "Academic Info"
        } else {
            header.headerLabel.text = "Top Skills"
        }
//        header.footerLabel.text = "?"
        header.backgroundColor = backGroundGray
        return header
    }
    
    // this is set in storyboard
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return CGFloat(0.0)
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(35)
    }
}
