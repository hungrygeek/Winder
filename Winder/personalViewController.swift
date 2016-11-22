//
//  personalViewController.swift
//  Winder
//
//  Created by ShiShu on 11/12/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import Foundation
import UIKit

class PersonalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let courses :[String] = ["Artificial Intelligence", "Swift", "Machine Learning", "Calculus", "Differentail Equation","Asian History", "Computer Architecture"]
    let cellReuseIdentifier = "cell"
    var skillSet = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let personalAvatar = UIImageView()
        personalAvatar.frame = CGRectMake(0, 0, 300, 300)
        personalAvatar.center = CGPoint(x: self.view.center.x, y: 180)
        personalAvatar.image = UIImage(named: "avatar1")
        //personalAvatar.layer.backgroundColor = UIColor.whiteColor().CGColor
        personalAvatar.layer.cornerRadius = 150
        personalAvatar.clipsToBounds = true
        self.view.addSubview(personalAvatar)
        
        let uniName = UILabel()
        uniName.frame = CGRectMake(0, 0, 300, 40)
        uniName.center = CGPoint(x: self.view.center.x, y: 350)
        uniName.text = "Washington University"
        uniName.textAlignment = .Center
        self.view.addSubview(uniName)
        
        let personName = UILabel()
        personName.frame = CGRectMake(0, 0, 300, 40)
        personName.center = CGPoint(x: self.view.center.x, y: 380)
        personName.text = "Shi Shu"
        personName.textAlignment = .Center
        self.view.addSubview(personName)
        
        let addSkill = UILabel()
        addSkill.frame = CGRectMake(0, 0, 80, 40)
        addSkill.center = CGPoint(x: 60, y: 420)
        addSkill.text = "+"
        addSkill.textAlignment = .Left
        addSkill.textColor = UIColor.blueColor()
        addSkill.font = addSkill.font.fontWithSize(25)
        self.view.addSubview(addSkill)
        
        let editSkill = UILabel()
        editSkill.frame = CGRectMake(0, 0, 80, 40)
        editSkill.center = CGPoint(x: self.view.frame.width-60, y: 420)
        editSkill.text = "Edit"
        editSkill.textAlignment = .Right
        editSkill.textColor = UIColor.blueColor()
        self.view.addSubview(editSkill)
        
        
        
        skillSet.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-440)
        skillSet.center = CGPoint(x: self.view.center.x, y: 220 + self.view.frame.height/2)
        skillSet.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        skillSet.dataSource = self
        skillSet.delegate = self
        self.view.addSubview(skillSet)
        
        view.backgroundColor = UIColor.whiteColor()

        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PersonalViewController.swipeLeft(_:)))
        recognizer.direction = .Left
        self.view.addGestureRecognizer(recognizer)
        
        
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}