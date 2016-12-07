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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(handleBack))

        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        //let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(self.selectedUserID).child("image").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let url = snapshot.value! as! String
            self.loadImageUsingCacheWithUrlString(url)
        })
        ref.child("users").child(self.selectedUserID).child("skill").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let diction1 = snapshot.value! as! [String: AnyObject]
            self.courses = []
            self.skillLevels = []
            for keydic in diction1.keys {
                self.courses.append(keydic)
                self.skillLevels.append(String(diction1[keydic]!))
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
        
        
        self.uniName.frame = CGRectMake(0, 0, 300, 40)
        self.uniName.center = CGPoint(x: self.view.center.x, y: 400)
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            //print(userID)
            let uniNamef = snapshot.value![self.selectedUserID]!!["school"]!
            self.uniName.text = String(uniNamef!)
            
        })
        // uniName.text = "Washington University"
        self.uniName.textAlignment = .Center
        self.view.addSubview(self.uniName)
        
        
        //let personName = UILabel()
        self.personName.frame = CGRectMake(0, 0, 300, 40)
        self.personName.center = CGPoint(x: self.view.center.x, y: 430)
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let personNamef = snapshot.value![self.selectedUserID]!!["username"]!
            self.personName.text = String(personNamef!)
        })
        //        personName.text = "Shi Shu"
        self.personName.textAlignment = .Center
        self.view.addSubview(personName)
        
        
        
        
        skillSet.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-350)
        skillSet.center = CGPoint(x: self.view.center.x, y: 280 + self.view.frame.height/2)
        skillSet.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        skillSet.dataSource = self
        skillSet.delegate = self
        self.view.addSubview(skillSet)
        
        
        view.backgroundColor = UIColor.whiteColor()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = UITableViewCell(style: .Value1, reuseIdentifier: cellReuseIdentifier)
        cell!.textLabel?.text = courses[indexPath.row]
        cell!.detailTextLabel?.text = String(self.skillLevels[indexPath.row]) + "%"
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        skillSet.deselectRowAtIndexPath(indexPath, animated: true)
        print(courses[indexPath.row])
    }
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        }
        
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = courses[fromIndexPath.row]
        courses.removeAtIndex(fromIndexPath.row)
        courses.insert(itemToMove, atIndex: toIndexPath.row)
    }
    
    
    private func loadImageUsingCacheWithUrlString(urlString: String) {
        if urlString == "" || self.image.image != nil {
            print("we got profile image or the url is null")
            
        } else {
            print("got \(urlString)")
            let url = NSURL(string: urlString)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                
                //download hit an error so lets return out
                if error != nil {
                    print(error)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if let downloadedImage = UIImage(data: data!) {
                        
                        self.image = UIImageView(image: downloadedImage)
                        self.image.frame = CGRectMake(0, 0, 240, 240)
                        self.image.layer.cornerRadius = 120
                        self.image.clipsToBounds = true
                        self.image.layer.backgroundColor = UIColor.whiteColor().CGColor
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
        presentViewController(vc, animated: true, completion: nil)
    }

}