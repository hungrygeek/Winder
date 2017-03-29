//
//  personalViewController.swift
//  Winder
//
//  Created by ShiShu on 11/12/16.
//  Copyright © 2016 Team Winder. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PersonalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    var courses :[String] = ["Artificial Intelligence", "Swift", "Machine Learning", "Calculus", "Differentail Equation","Asian History", "Computer Architecture"]
    var courses :[String] = []
    var skillLevels = ["","","","","","",""]
    let cellReuseIdentifier = "cell"
    var skillSet = UITableView()
    let editSkill = UIButton()
    let editicon = UIImage(named: "edit_icon_100")
    let okicon = UIImage(named: "ok_100")
    let uniName = UILabel()
    let personName = UILabel()
    let personalAvatar = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        
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
                        
                        self.personalAvatar.image = downloadedImage
                    }
                    
                })
                
            }).resume()
        }
        
        ref.child("users").child(userID!).child("image").observeSingleEvent(of: .value, with: { (snapshot) in
            if String(describing: snapshot.value!) != "" {
                loadImageUsingCacheWithUrlString(String(describing: snapshot.value!))
            } else {
            
                self.personalAvatar.image = UIImage(named: "avatar1")
            }
            
        })

        ref.child("users").child(userID!).child("skill").observeSingleEvent(of: .value, with: { (snapshot) in
            let diction1 = snapshot.value! as! [String: AnyObject]
            self.courses = []
            self.skillLevels = []
            for keydic in diction1.keys {
                self.courses.append(keydic)
                self.skillLevels.append(String(describing: diction1[keydic]!))
            }
            self.skillSet.reloadData()
        })
        
        
        
//        let avatarBackG = UIView()
//        avatarBackG.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 480)
//        avatarBackG.center = CGPoint(x: self.view.center.x, y: 240)
//        avatarBackG.backgroundColor = UIColor.green
//        self.view.addSubview(avatarBackG)
        
        //let personalAvatar = UIImageView()
        self.personalAvatar.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        self.personalAvatar.center = CGPoint(x: self.view.center.x, y: 180)
        //self.personalAvatar.image = UIImage(named: "avatar1")
        //personalAvatar.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.personalAvatar.layer.cornerRadius = 150
        self.personalAvatar.clipsToBounds = true
        self.personalAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        self.personalAvatar.isUserInteractionEnabled = true
        self.view.addSubview(personalAvatar)

        
        self.uniName.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        self.uniName.center = CGPoint(x: self.view.center.x, y: 350)
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            print(userID)
            let snapvalue = snapshot.value as! [String: Any]
            let uniNamef = (snapvalue[userID!]! as! [String: Any])["school"]!
            // print(String(uniNamef!))
            let attachment = NSTextAttachment()
            attachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(describing: uniNamef) + "  "))
            myString.append(attachmentString)
            self.uniName.attributedText = myString
            //uniName.text = String(uniNamef!)
            
        })
        // uniName.text = "Washington University"
        self.uniName.textAlignment = .center
        self.uniName.isUserInteractionEnabled = true
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(PersonalViewController.schoolPressed(_:)))
        self.uniName.addGestureRecognizer(gestureRecognizer1)
        self.view.addSubview(self.uniName)
        
        
        //let personName = UILabel()
        self.personName.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        self.personName.center = CGPoint(x: self.view.center.x, y: 380)
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            print()
            let snapvalue = snapshot.value as! [String: Any]
            let personNamef = (snapvalue[userID!]! as! [String: Any])["username"]!
            let attachment = NSTextAttachment()
            attachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(describing: personNamef) + "  "))
            myString.append(attachmentString)
            self.personName.attributedText = myString
        })
//        personName.text = "Shi Shu"
        self.personName.textAlignment = .center
        self.personName.isUserInteractionEnabled = true
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(PersonalViewController.namePressed(_:)))
        self.personName.addGestureRecognizer(gestureRecognizer2)
        self.view.addSubview(personName)
        
        let addSkill = UIButton()
        let addicon = UIImage(named: "add_skill_100")
        addSkill.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        addSkill.center = CGPoint(x: 35, y: 420)
        addSkill.setImage(addicon, for: UIControlState())
        self.view.addSubview(addSkill)
        addSkill.imageView?.contentMode = .scaleAspectFit
        addSkill.addTarget(self, action: #selector(PersonalViewController.addClick), for:UIControlEvents.touchUpInside)

        
        self.editSkill.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        self.editSkill.center = CGPoint(x: self.view.frame.width-35, y: 420)
        self.editSkill.setImage(editicon, for: UIControlState())
        self.editSkill.imageView?.contentMode = .scaleAspectFit
        self.editSkill.addTarget(self, action: #selector(PersonalViewController.editClick), for:UIControlEvents.touchUpInside)
        self.view.addSubview(self.editSkill)
        
        
        
        skillSet.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-440)
        skillSet.center = CGPoint(x: self.view.center.x, y: 220 + self.view.frame.height/2)
        skillSet.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        skillSet.dataSource = self
        skillSet.delegate = self
        self.view.addSubview(skillSet)
        
        let logout = UIButton()
        logout.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        logout.center = CGPoint(x: self.view.frame.width - 40, y: 35)
        //logout.backgroundColor = UIColor.blueColor()
        logout.setTitle("Log Out", for: UIControlState())
        logout.titleLabel!.textAlignment = .right
        logout.setTitleColor(UIColor.black, for: UIControlState())
        logout.addTarget(self, action: #selector(PersonalViewController.signout), for:UIControlEvents.touchUpInside)
        self.view.addSubview(logout)
        self.view.bringSubview(toFront: logout)
        
        
        view.backgroundColor = UIColor.white

        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PersonalViewController.swipeLeft(_:)))
        recognizer.direction = .left
        self.view.addGestureRecognizer(recognizer)

        


        
        
        
    }
    
    
    
    // image picker
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.personalAvatar.image = selectedImage
        }
        
        let imageName = UUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(self.personalAvatar.image!) {
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    
                    let ref = FIRDatabase.database().reference()
                    let userID = FIRAuth.auth()?.currentUser?.uid
                    ref.child("users").child(userID!).updateChildValues(["image":profileImageUrl])
                    
                }
            })
        
        dismiss(animated: true, completion: nil)
        
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    
    // end of image picker
    
    

    
    
    
    func addClick() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add a new skill", message: "Enter a new skill", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = "Course name:Skill level(0-100)"
        })
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0] as UITextField
            let input = textField.text?.components(separatedBy: ":")
            print("Text field: \(textField.text)")
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("users").child(userID!).child("skill").updateChildValues([input![0]:Int(input![1])!])
            ref.child("users").child(userID!).child("skill").observeSingleEvent(of: .value, with: { (snapshot) in
                let diction1 = snapshot.value! as! [String: AnyObject]
                self.courses = []
                self.skillLevels = []
                for keydic in diction1.keys {
                    self.courses.append(keydic)
                    self.skillLevels.append(String(describing: diction1[keydic]!))
                }
                self.skillSet.reloadData()
            })
            
            
            
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel Logic")
        }))
        
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func swipeLeft(_ recognizer: UIGestureRecognizer) {
        let vc = MatchViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(vc, animated: false, completion: nil)
        print("Swiped")
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
            // Delete the row from the data source
            courses.remove(at: indexPath.row)
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("users").child(userID!).child("skill").child(self.courses[indexPath.row]).removeValue()
            
            skillSet.deleteRows(at: [indexPath], with: .fade)
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
    
    
    func editClick() {

        self.skillSet.isEditing = !self.skillSet.isEditing
        
    }
    
    
    func signout() {
         // signout function for Firebase.
        //try FIRAuth.auth()?.signOut()
        let vc = ViewController()
        vc.view.backgroundColor = UIColor.white
        present(vc, animated: true, completion: nil)

        
    }
    
    func schoolPressed(_ gestureRecognizer1 :UITapGestureRecognizer){
        print("Label pressed")
        let alert = UIAlertController(title: "Edit your School", message: "Enter your School", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0] as UITextField
            print("Text field: \(textField.text)")
            let attachment = NSTextAttachment()
            attachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(textField.text!) + "  "))
            myString.append(attachmentString)
            self.uniName.attributedText = myString
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID! + "/school").setValue(String(textField.text!))
            
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel Logic")
        }))
        
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        //Your awesome code.
    }
    
    
    
    
    
    func namePressed(_ gestureRecognizer2 :UITapGestureRecognizer){
        print("Label pressed")
        let alert = UIAlertController(title: "Edit your Name", message: "Enter your Name", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert!.textFields![0] as UITextField
            print("Text field: \(textField.text)")
            let attachment = NSTextAttachment()
            attachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            attachment.image = UIImage(named: "edit_name")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: (String(textField.text!) + "  "))
            myString.append(attachmentString)
            self.personName.attributedText = myString
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(userID! + "/username").setValue(String(textField.text!))
            
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel Logic")
        }))
        
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        //Your awesome code.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
