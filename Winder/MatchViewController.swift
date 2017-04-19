//
//  MatchViewController.swift
//  Winder
//
//  Created by Rokee on 11/12/16.
//  Copyright © 2016 Team Winder. All rights reserved.
//
//
//modified on Dec. 16, 2016 for Swift3
//

import UIKit
import Koloda
import Firebase
import SQLite



class MatchViewController:UIViewController{
    

    var ref: FIRDatabaseReference!
    var wasLoaded: Bool!
    var kolodaView: KolodaView!
    
    var dataSource = Array<PersonalInfo>()
    
    var picArray: Array<UIImage> = {
        var array1 = Array<UIImage>()
        for index in 0...11{
            array1.append(UIImage(named: "\(index+1)")!)
        }
        return array1
    }()
    
    var backgroundPicArray = Array<UIImage>()
    
    var nameLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightLight)
        label.frame = CGRect(x:0,y:0,width: 200,height: 50)
        return label
    }()
    
    var schoolLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        label.frame = CGRect(x:0,y:0,width: 200,height: 50)
        return label
    }()
    
    var likeButton: UIButton = {
        let checkImg = UIImage(named:"Thumb Up")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 75,height: 75)
        button.setBackgroundImage(checkImg, for: UIControlState())
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    var dislikeButton: UIButton = {
        let checkImg = UIImage(named:"Thumbs Down")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 75,height: 75)
        button.setBackgroundImage(checkImg, for: UIControlState())
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    var personButton: UIButton = {
        let checkImg = UIImage(named:"person")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 45,height: 45)
        button.setBackgroundImage(checkImg, for: UIControlState())
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    var backgroundPic = UIImageView()
    let blurEffect1 = UIBlurEffect(style: UIBlurEffectStyle.extraLight)

    
    // db setup
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    let id = Expression<String>("id")
    let date = Expression<String?>("date")
    let liked = Expression<Bool?>("like") //1 for like 0 for dislike and 3 for no
    let matched_id = Expression<String>("matched_id")
    let user_name = Expression<String?>("user_name")
    
    let matchedIDs = Table("matchedIDs")
    var db: Connection?
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            print("login success")
            print("uid: \(FIRAuth.auth()!.currentUser!.uid)")
            print("login in with \(FIRAuth.auth()!.currentUser!.email)")
            print("firebase data wasLoaded \(wasLoaded ?? false) in viewDidAppear")
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // db will store all matched person's id, whether the person is liked or disliked by user
        db = try! Connection("\(path)/winder.matchedIDs.sqlite3")
        do {
            try db?.run(matchedIDs.create(ifNotExists: true) {
                t in
                t.column(id)
                t.column(date)
                t.column(matched_id, primaryKey: true)
                t.column(liked)
                t.column(user_name)
            })
            print("new table for matchedIDs created")
        } catch  {
            print("error: \(error)")
        }
        
        self.backgroundPic.frame = self.view.frame
        self.backgroundPic.center = self.view.center
        self.backgroundPic.alpha = 0.4
        self.wasLoaded = false
        
        print("firebase data wasLoaded \(wasLoaded) in viewDidLoad")
        ref = FIRDatabase.database().reference()

        view.addSubview(backgroundPic)

        let blurEffectView = UIVisualEffectView(effect: blurEffect1)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.8
        view.addSubview(blurEffectView)

        
        likeButton.center = CGPoint(x: view.frame.width-likeButton.frame.width-10, y: view.frame.height-likeButton.frame.height-25)
        likeButton.addTarget(self, action: #selector(self.like), for:UIControlEvents.touchUpInside)
        view.addSubview(likeButton)
        
        dislikeButton.addTarget(self, action: #selector(self.dislike), for:UIControlEvents.touchUpInside)
        dislikeButton.center = CGPoint(x: likeButton.frame.width+10, y: view.frame.height-likeButton.frame.height-15)
        view.addSubview(dislikeButton)
        
        
        personButton.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height-25)
        personButton.addTarget(self, action: #selector(MatchViewController.personClick), for:UIControlEvents.touchUpInside)
        view.addSubview(personButton)
        
        nameLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.6)
        view.addSubview(nameLabel)
        
        schoolLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.2)
        view.addSubview(schoolLabel)
        
        kolodaView = KolodaView(frame: CGRect(x:0,y: 0,width:270,height:270))
        kolodaView.countOfVisibleCards = 1
        kolodaView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY-80)
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.view.addSubview(self.kolodaView)

        getMatchList(){
            self.kolodaView.reloadData()
            (self.dataSource[0]).setAbilityBarAndDisplay()
            print("Now have \(self.backgroundPicArray.count) images")
            self.backgroundPic.image = self.backgroundPicArray[0]
            self.nameLabel.text = self.dataSource[0].username
            self.schoolLabel.text = self.dataSource[0].school
            self.backgroundPic.setNeedsDisplay()
        }
        

        view.backgroundColor = UIColor.white
        
        let recognizer1: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(MatchViewController.swipeLeft(_:)))
        recognizer1.direction = .left
        self.view.addGestureRecognizer(recognizer1)
        
        let recognizer2: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(MatchViewController.swipeRight(_:)))
        recognizer2.direction = .right
        self.view.addGestureRecognizer(recognizer2)
    }
    
    /*
     query limited number of user info from firebase and store into array locally
    */
    func getMatchList(_ matchCount:UInt=5, onCompletion: @escaping ()->Void){
        
        //*IMPORTANT* TODO: drop the table if exists, for TEST only
        try! db?.run(self.matchedIDs.delete())
        
        if self.dataSource.count>0{
            print("matchList exist")
            onCompletion()
            return
        } else {
            print("matchList *DOES NOT* exist")

        }
        print("retrieving match list")
        self.ref = FIRDatabase.database().reference()
        if self.dataSource.count>0{
            self.kolodaView.reloadData()
            return
        }
        self.ref.child("users").queryLimited(toFirst: matchCount).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let users = snapshot.value as? NSDictionary {
                for key in (users.allKeys as! [String]){
                    if key==FIRAuth.auth()?.currentUser?.uid{
                        continue
                    }
                    do{
                        let count = try self.db?.scalar(self.matchedIDs.filter(self.matched_id == key).count)
                        /*
                            check if the incoming ID has already been seen by user,
                            if yes, skip that one
                            if NO, add the user info into koloda view
                         */
                        let userDict = users[key] as! NSDictionary
                        if count != nil && count==0 {
                            // insert the unmatched peer into koloda data source
                            let randomIndex = Int(arc4random_uniform(UInt32(self.picArray.count)))
                            let tempImage = self.picArray[randomIndex]
                            let pi = PersonalInfo(w: 270, h: 270, uid: key, userDict: userDict)
                            self.backgroundPicArray.append(tempImage)
                            self.dataSource.append(pi)
                        } else {
                            print("log: \(count) entry(s) found")
                            let username = userDict["username"] as? String ?? "name N/A"
                            print("we met this dude \(username) before, skip")
                        }
                    } catch {
                        print("error: \(error)")
                    }
                }
                self.wasLoaded = true
                onCompletion()
            } else {
                print("load match list wrong")
            }
        })
    }
    
    // store the matched peer into SQLite
    // schema id,date,like,matched_id(pk),user_name
    // date for SQLite should be "yyyy-MM-dd HH:mm:ss"
    func storePeerEntry(_ id: String, _ username: String, _ liked: Bool, _ matched_id: String) throws -> (){
        let insert = self.matchedIDs.insert(
            self.id <- id,
            self.date <- Date().datatypeValue,
            self.matched_id <- matched_id,
            self.user_name <- username,
            self.liked <- liked
        )
        let rowid = try self.db?.run(insert)
        print("new matched ID \(matched_id) inserted at \(rowid)")
    }
    
    
    func swipeLeft(_ recognizer1: UIGestureRecognizer) {
        let vc = MessageViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navController, animated: false, completion: nil)
        print("View Swiped")
    }
    
    func swipeRight(_ recognizer2: UIGestureRecognizer) {
//        let vc = PersonalViewController()
//        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        present(vc, animated: true, completion: nil)
//        print("View Swiped")
    }
    
    func like(){
        kolodaView.swipe(.right)
    }
    
    func dislike(){
        kolodaView.swipe(.left)
    }

    func signOut(){
        print("sign out")
        // [START signout]
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // [END signout]
    }
    
    /*
     switch to view peer info
     */
    func personClick() {
        // in case the user click before data fully loaded
        if self.dataSource.count < 1 {
            return
        }
        // nav to rokee's view
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PeerViewController") as? PeerViewController else { return }
        nextViewController.peerInfo = self.dataSource[self.kolodaView.currentCardIndex]
        self.present(nextViewController, animated:true, completion:nil)

        // nav to SS's view
//        let vc = ViewOtherProfileViewController()
//        let currentSuggestion = (dataSource[self.kolodaView.currentCardIndex]).uid
//        vc.selectedUserID = currentSuggestion
//        let navController = UINavigationController(rootViewController: vc)
//        navController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        present(navController, animated: true, completion: nil)

//        print("clicked")
//        self.present(vc, animated: true, completion: nil)
    }
    
    
    func kolodaShouldApplyAppearAnimation(koloda: KolodaView) -> Bool {
        return true
    }


}

//MARK: KolodaViewDelegate
extension MatchViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("no cards more")
//        dataSource.insert(UIImage(named: "Card_like_6")!, atIndex: kolodaView.currentCardIndex - 1)
//        let position = kolodaView.currentCardIndex
//        kolodaView.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        print("you click")
        personClick()
    }
    /*
     peer liked will be inserted with liked=1, otherwise liked=0
     */
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){
        print("swiped")
        let peerName = self.nameLabel.text
        if direction == .right {
            print("count \(koloda.countOfCards)")
            print("cur index \(koloda.currentCardIndex)")
            print("you swipe \(index) *RIGHT*")
            
            print((dataSource[Int(index)]).uid)
            // add uid to matched lis
            if let uid = FIRAuth.auth()!.currentUser?.uid {
                let peer_uid = (dataSource[Int(index)]).uid
                ref.child("users/\(uid)/matched/\(peer_uid)").setValue(Date().timeIntervalSince1970*1000)
                do{
                    try storePeerEntry(uid, peerName!, true, peer_uid)
                } catch {
                    print("error \(error)")
                }
            } else{
                print("can not get user")
            }

        } else {
            print("you swipe that biatch *LEFT*")
            if let uid = FIRAuth.auth()!.currentUser?.uid {
                let peer_uid = (dataSource[Int(index)]).uid
                ref.child("users/\(uid)/matched/\(peer_uid)").setValue(Date().timeIntervalSince1970*1000)
                do{
                    try storePeerEntry(uid, peerName!, false, peer_uid)
                } catch {
                    print("error \(error)")
                }
            } else{
                print("can not get user")
            }
        }
    }
    
}

//MARK: KolodaViewDataSource
extension MatchViewController: KolodaViewDataSource {
    public func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return DragSpeed.default
    }

    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return dataSource.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return dataSource[index]
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int){
        self.backgroundPic.image = self.backgroundPicArray[index]
        self.backgroundPic.setNeedsDisplay()
        dataSource[index].setAbilityBarAndDisplay()
        self.ref = FIRDatabase.database().reference()
        self.schoolLabel.text = self.dataSource[index].school
        self.nameLabel.text = self.dataSource[index].username
    }
    
}
