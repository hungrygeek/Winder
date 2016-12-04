//
//  personalViewController.swift
//  Winder
//
//  Created by ShiShu on 11/12/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PersonalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var courses :[String] = ["Artificial Intelligence", "Swift", "Machine Learning", "Calculus", "Differentail Equation","Asian History", "Computer Architecture"]
    let cellReuseIdentifier = "cell"
    var skillSet = UITableView()
    let editSkill = UIButton()
    let editicon = UIImage(named: "edit_icon_100")
    let okicon = UIImage(named: "ok_100")
    let uniName = UILabel()
    let personName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
<<<<<<< HEAD
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            print(snapshot.value![userID!]!!["username"]);
        })
        
=======
        print("in personal view", self.view.window?.rootViewController?.nibName)
        print("match view")
        if FIRAuth.auth()?.currentUser != nil {
            print("login success")
            print("user \(FIRAuth.auth()?.currentUser?.uid)")
            print("display name \(FIRAuth.auth()?.currentUser?.displayName)")
            print("login in with \(FIRAuth.auth()?.currentUser?.email)")
        }
>>>>>>> 8b03f55dbf0bc3c1a6063292fefc56e632f58daa
        let personalAvatar = UIImageView()
        personalAvatar.frame = CGRectMake(0, 0, 300, 300)
        personalAvatar.center = CGPoint(x: self.view.center.x, y: 180)
        personalAvatar.image = UIImage(named: "avatar1")
        //personalAvatar.layer.backgroundColor = UIColor.whiteColor().CGColor
        personalAvatar.layer.cornerRadius = 150
        personalAvatar.clipsToBounds = true
        self.view.addSubview(personalAvatar)
        
        
        self.uniName.frame = CGRectMake(0, 0, 300, 40)
        self.uniName.center = CGPoint(x: self.view.center.x, y: 350)
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let uniNamef = snapshot.value![userID!]!!["school"]!
            // print(String(uniNamef!))
            let attachment = NSTextAttachment()
            attachment.bounds = CGRectMake(0, 0, 20, 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(uniNamef!) + "  "))
            myString.appendAttributedString(attachmentString)
            self.uniName.attributedText = myString
            //uniName.text = String(uniNamef!)
            
        })
        // uniName.text = "Washington University"
        self.uniName.textAlignment = .Center
        self.uniName.userInteractionEnabled = true
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(PersonalViewController.schoolPressed(_:)))
        self.uniName.addGestureRecognizer(gestureRecognizer1)
        self.view.addSubview(self.uniName)
        
        
        //let personName = UILabel()
        self.personName.frame = CGRectMake(0, 0, 300, 40)
        self.personName.center = CGPoint(x: self.view.center.x, y: 380)
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let personNamef = snapshot.value![userID!]!!["username"]!
            let attachment = NSTextAttachment()
            attachment.bounds = CGRectMake(0, 0, 20, 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(personNamef!) + "  "))
            myString.appendAttributedString(attachmentString)
            self.personName.attributedText = myString
        })
//        personName.text = "Shi Shu"
        self.personName.textAlignment = .Center
        self.personName.userInteractionEnabled = true
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(PersonalViewController.namePressed(_:)))
        self.personName.addGestureRecognizer(gestureRecognizer2)
        self.view.addSubview(personName)
        
        let addSkill = UIButton()
        let addicon = UIImage(named: "add_skill_100")
        addSkill.frame = CGRectMake(0, 0, 30, 30)
        addSkill.center = CGPoint(x: 35, y: 420)
        addSkill.setImage(addicon, forState: .Normal)
        self.view.addSubview(addSkill)
        addSkill.imageView?.contentMode = .ScaleAspectFit
        addSkill.addTarget(self, action: #selector(PersonalViewController.addClick), forControlEvents:UIControlEvents.TouchUpInside)

        
        self.editSkill.frame = CGRectMake(0, 0, 50, 30)
        self.editSkill.center = CGPoint(x: self.view.frame.width-35, y: 420)
        self.editSkill.setImage(editicon, forState: .Normal)
        self.editSkill.imageView?.contentMode = .ScaleAspectFit
        self.editSkill.addTarget(self, action: #selector(PersonalViewController.editClick), forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(self.editSkill)
        
        
        
        skillSet.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-440)
        skillSet.center = CGPoint(x: self.view.center.x, y: 220 + self.view.frame.height/2)
        skillSet.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        skillSet.dataSource = self
        skillSet.delegate = self
        self.view.addSubview(skillSet)
        
        let logout = UIButton()
        logout.frame = CGRectMake(0, 0, 80, 40)
        logout.center = CGPoint(x: self.view.frame.width - 40, y: 35)
        //logout.backgroundColor = UIColor.blueColor()
        logout.setTitle("LogOut", forState: .Normal)
        logout.titleLabel!.textAlignment = .Right
        logout.setTitleColor(UIColor.blackColor(), forState: .Normal)
        logout.addTarget(self, action: #selector(PersonalViewController.signout), forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(logout)
        self.view.bringSubviewToFront(logout)
        
        
        view.backgroundColor = UIColor.whiteColor()

        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PersonalViewController.swipeLeft(_:)))
        recognizer.direction = .Left
        self.view.addGestureRecognizer(recognizer)

        


        
        
        
    }
    
    
    func addClick() {
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Add a new skill", message: "Enter a new skill", preferredStyle: .Alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Your Skills Here."
        })
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0] as UITextField
            print("Text field: \(textField.text)")
            self.courses.append(textField.text!)
            self.skillSet.reloadData()
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Cancel Logic")
        }))
        
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func swipeLeft(recognizer: UIGestureRecognizer) {
        let vc = MatchViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: false, completion: nil)
        print("Swiped")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = UITableViewCell(style: .Value1, reuseIdentifier: cellReuseIdentifier)
        cell!.textLabel?.text = courses[indexPath.row]
        cell!.detailTextLabel?.text = String(Int(arc4random_uniform(100))) + "%"
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        skillSet.deselectRowAtIndexPath(indexPath, animated: true)
        print(courses[indexPath.row])
    }
    

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            courses.removeAtIndex(indexPath.row)
            skillSet.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
    
    
    func editClick() {

        self.skillSet.editing = !self.skillSet.editing
        
    }
    
    
    func signout() {
        // signout function for Firebase.
//        let vc = ViewController()
//        presentViewController(vc, animated: false, completion: nil)
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            print(snapshot.value![userID!]!!["username"]);
        })
        
    }
    
    func schoolPressed(gestureRecognizer1 :UITapGestureRecognizer){
        print("Label pressed")
        var alert = UIAlertController(title: "Edit your School", message: "Enter your School", preferredStyle: .Alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0] as UITextField
            print("Text field: \(textField.text)")
            let attachment = NSTextAttachment()
            attachment.bounds = CGRectMake(0, 0, 20, 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(textField.text!) + "  "))
            myString.appendAttributedString(attachmentString)
            self.uniName.attributedText = myString
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID! + "/school").setValue(String(textField.text!))
            
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Cancel Logic")
        }))
        
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        //Your awesome code.
    }
    
    
    
    
    
    func namePressed(gestureRecognizer2 :UITapGestureRecognizer){
        print("Label pressed")
        var alert = UIAlertController(title: "Edit your Name", message: "Enter your Name", preferredStyle: .Alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0] as UITextField
            print("Text field: \(textField.text)")
            let attachment = NSTextAttachment()
            attachment.bounds = CGRectMake(0, 0, 20, 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(textField.text!) + "  "))
            myString.appendAttributedString(attachmentString)
            self.personName.attributedText = myString
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID! + "/username").setValue(String(textField.text!))
            
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Cancel Logic")
        }))
        
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        //Your awesome code.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}