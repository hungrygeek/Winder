//
//  MessageViewController.swift
//  Winder
//
//  Created by ShiShu on 12/4/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UITableViewController {
    
    let cellId = "cellId"
    
    var userlist = [String]()
    var idlist = [String]()
    
    let partner = ShareData.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(handleBack))
        tableView.registerClass(UserCell.self, forCellReuseIdentifier: cellId)
        self.title = "Talk to your peer"
        fetchUser()
        fetchUserName(){
            self.tableView.reloadData()
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchUserName(onCompletion: ()->Void) {
        self.userlist = []
        FIRDatabase.database().reference().child("users").observeEventType(.Value, withBlock: { (snapshot) in
            print(snapshot)
            if let d = snapshot.value as? [String: NSDictionary] {
                print(d)
                for id in self.idlist{
                    if let uname = d[id]?["username"] {
                        self.userlist.append(uname as! String)
                    } else{
                        print("fail to get username of id \(id)")
                    }
                }
                print("usernames \(self.userlist)")
                self.tableView.reloadData()
                dispatch_async(dispatch_get_main_queue(), {
                    /*
                     this will be executed len(idlist) times
                     */
                    self.tableView.reloadData()
                })
            }
            
            }, withCancelBlock: nil)
    }
    func fetchUser() {
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("matched").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            if snapshot.key != FIRAuth.auth()?.currentUser?.uid  {
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
                self.idlist.append(String(snapshot.key))
                //this will crash because of background thread, so lets use dispatch_async to fix
//                dispatch_async(dispatch_get_main_queue(), {
                    /*
                     this will be executed len(idlist) times
                        */
//                })
            }
            
            }, withCancelBlock: nil)
    }
    
    
    func handleBack() {
        let matchView = MatchViewController()
        presentViewController(matchView, animated: true, completion: nil)
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userlist.count
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        let user = userlist[indexPath.row]
        cell.textLabel?.text = user
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.partner.partnerID = self.idlist[indexPath.row]
        self.partner.partnerName = self.userlist[indexPath.row]
        let vc = ChatViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(navController, animated: false, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
