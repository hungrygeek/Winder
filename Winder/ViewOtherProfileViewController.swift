//
//  ViewOtherProfileViewController.swift
//  Winder
//
//  Created by ShiShu on 12/6/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class ViewOtherProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var courses :[String] = ["Artificial Intelligence", "Swift", "Machine Learning", "Calculus", "Differentail Equation","Asian History", "Computer Architecture"]
    var skillLevels = ["","","","","","",""]
    let cellReuseIdentifier = "cell"
    var skillSet = UITableView()
    let editSkill = UIButton()
    let editicon = UIImage(named: "edit_icon_100")
    let okicon = UIImage(named: "ok_100")
    let uniName = UILabel()
    let personName = UILabel()
    var selectedUserID = ""
    var image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))

        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        //let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(self.selectedUserID).child("image").observeSingleEvent(of: .value, with: { (snapshot) in
            let url = snapshot.value! as! String
            self.loadImageUsingCacheWithUrlString(url)
        })
        ref.child("users").child(self.selectedUserID).child("skill").observeSingleEvent(of: .value, with: { (snapshot) in
            let diction1 = snapshot.value! as! [String: AnyObject]
            self.courses = []
            self.skillLevels = []
            for keydic in diction1.keys {
                self.courses.append(keydic)
                self.skillLevels.append(String(describing: diction1[keydic]!))
            }
            self.skillSet.reloadData()
        })
        
//        let personalAvatar = UIImageView()
//        personalAvatar.frame = CGRectMake(0, 0, 300, 300)
//        personalAvatar.center = CGPoint(x: self.view.center.x, y: 220)
//        personalAvatar.image = UIImage(named: "avatar1")
        //personalAvatar.layer.backgroundColor = UIColor.whiteColor().CGColor
//        personalAvatar.layer.cornerRadius = 150
//        personalAvatar.clipsToBounds = true
//        self.view.addSubview(personalAvatar)
        
        
        self.uniName.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        self.uniName.center = CGPoint(x: self.view.center.x, y: 400)
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            //print(userID)
            let uniNamef = ((snapshot.value as! [String: Any])[self.selectedUserID]! as! [String: Any])["school"]!
            self.uniName.text = String(describing: uniNamef)
            
        })
        // uniName.text = "Washington University"
        self.uniName.textAlignment = .center
        self.view.addSubview(self.uniName)
        
        
        //let personName = UILabel()
        self.personName.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        self.personName.center = CGPoint(x: self.view.center.x, y: 430)
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let personNamef = ((snapshot.value! as! [String: Any])[self.selectedUserID]! as! [String: Any])["username"]!
            self.personName.text = String(describing: personNamef)
        })
        //        personName.text = "Shi Shu"
        self.personName.textAlignment = .center
        self.view.addSubview(personName)
        
        
        
        
        skillSet.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-350)
        skillSet.center = CGPoint(x: self.view.center.x, y: 280 + self.view.frame.height/2)
        skillSet.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        skillSet.dataSource = self
        skillSet.delegate = self
        self.view.addSubview(skillSet)
        
        
        view.backgroundColor = UIColor.white
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = UITableViewCell(style: .value1, reuseIdentifier: cellReuseIdentifier)
        cell!.textLabel?.text = courses[indexPath.row]
        cell!.detailTextLabel?.text = String(self.skillLevels[indexPath.row]) + "%"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        skillSet.deselectRow(at: indexPath, animated: true)
        print(courses[indexPath.row])
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        }
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let itemToMove = courses[fromIndexPath.row]
        courses.remove(at: fromIndexPath.row)
        courses.insert(itemToMove, at: toIndexPath.row)
    }
    
    
    fileprivate func loadImageUsingCacheWithUrlString(_ urlString: String) {
        if urlString == "" || self.image.image != nil {
            print("we got profile image or the url is null")
            
        } else {
            print("got \(urlString)")
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                //download hit an error so lets return out
                if error != nil {
                    print("error")
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    
                    if let downloadedImage = UIImage(data: data!) {
                        
                        self.image = UIImageView(image: downloadedImage)
                        self.image.frame = CGRect(x: 0, y: 0, width: 240, height: 240)
                        self.image.layer.cornerRadius = 120
                        self.image.clipsToBounds = true
                        self.image.layer.backgroundColor = UIColor.white.cgColor
                        self.image.center = CGPoint(x: self.view.center.x, y: 220)
//                        self.image.center = CGPointMake(self.view.frame.midX, self.view.frame.midY)
                        self.view.addSubview(self.image)
                        self.image.setNeedsDisplay()
                    }
                    
                })
                
            }).resume()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleBack() {
        let vc = MatchViewController()
        present(vc, animated: true, completion: nil)
    }

}
