//
//  MatchViewController.swift
//  Winder
//
//  Created by Rokee on 11/12/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit
import Koloda
import Firebase

private var numberOfCards: UInt = 2
private var matchListLenLimit: UInt = 10

class MatchViewController:UIViewController{
    
    var ref: FIRDatabaseReference!
    
//    var kolodaView: KolodaView = {
//        var kv: KolodaView = KolodaView(frame: CGRect(x:0,y: 0,width:250,height:250))
//        kv.countOfVisibleCards = 2
//        return kv
//    }()
    var kolodaView: KolodaView!
    
//    var dataSource: Array<UIView> = {
//        
//        var array = Array<UIView>()
//        
//        for index in 0...1{
//            var userTemp = PersonalInfo(w: 270, h: 270, uid: String(index))
//            array.append(userTemp)
//            userTemp.setAbilityBar([1,1,1,1])
//        }
//        return array
//    }()
    var dataSource = Array<UIView>()
    
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
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(25, weight: UIFontWeightLight)
        label.frame = CGRect(x:0,y:0,width: 200,height: 50)
        return label
    }()
    
    var schoolLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        label.frame = CGRect(x:0,y:0,width: 200,height: 50)
        return label
    }()
    var likeButton: UIButton = {
        let checkImg = UIImage(named:"Thumb Up")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 75,height: 75)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    var dislikeButton: UIButton = {
        let checkImg = UIImage(named:"Thumbs Down")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 75,height: 75)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    var personButton: UIButton = {
        let checkImg = UIImage(named:"person")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 45,height: 45)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    var backgroundPic = UIImageView()
    let blurEffect1 = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)


    override func viewDidAppear(animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            print("login success")
            print("uid: \(FIRAuth.auth()!.currentUser!.uid)")
            print("login in with \(FIRAuth.auth()!.currentUser!.email)")
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundPic.frame = self.view.frame
        self.backgroundPic.center = self.view.center
        self.backgroundPic.alpha = 0.4
        
        ref = FIRDatabase.database().reference()

        view.addSubview(backgroundPic)

        let blurEffectView = UIVisualEffectView(effect: blurEffect1)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        blurEffectView.alpha = 0.8
        view.addSubview(blurEffectView)

        
        likeButton.center = CGPoint(x: view.frame.width-likeButton.frame.width-10, y: view.frame.height-likeButton.frame.height-25)
        likeButton.addTarget(self, action: #selector(self.like), forControlEvents:UIControlEvents.TouchUpInside)
        view.addSubview(likeButton)
        
        dislikeButton.addTarget(self, action: #selector(self.dislike), forControlEvents:UIControlEvents.TouchUpInside)
        dislikeButton.center = CGPoint(x: likeButton.frame.width+10, y: view.frame.height-likeButton.frame.height-15)
        view.addSubview(dislikeButton)
        
        
        personButton.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height-25)
        personButton.addTarget(self, action: #selector(MatchViewController.personClick), forControlEvents:UIControlEvents.TouchUpInside)
        view.addSubview(personButton)
        
        nameLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.6)
        view.addSubview(nameLabel)
        
        schoolLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.2)
        view.addSubview(schoolLabel)
        
        // use call back to get the data
        
        getMatchList(){
            () in
            self.kolodaView = KolodaView(frame: CGRect(x:0,y: 0,width:270,height:270))
            self.kolodaView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY-80)
            self.kolodaView.dataSource = self
            self.kolodaView.delegate = self
            self.view.addSubview(self.kolodaView)
//            let total = Double(matchListLenLimit)*2
            (self.dataSource[0] as! PersonalInfo).setAbilityBar([21,1,89,53])
            print("Now i have \(self.backgroundPicArray.count) images")
            self.backgroundPic.image = self.backgroundPicArray[0]
            self.backgroundPic.setNeedsDisplay()
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            let userTemp = self.dataSource[self.kolodaView.currentCardIndex] as! PersonalInfo
            ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                let personNamef = snapshot.value![userTemp.uid]!!["username"]!
                let schoolNamef = snapshot.value![userTemp.uid]!!["school"]!
                self.schoolLabel.text = String(schoolNamef!)
                self.nameLabel.text = String(personNamef!)
            })
        }
        

        view.backgroundColor = UIColor.whiteColor()
        
        let recognizer1: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(MatchViewController.swipeLeft(_:)))
        recognizer1.direction = .Left
        self.view.addGestureRecognizer(recognizer1)
        
        let recognizer2: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(MatchViewController.swipeRight(_:)))
        recognizer2.direction = .Right
        self.view.addGestureRecognizer(recognizer2)
    }
    
    func getMatchList(matchCount:UInt=5, onCompletion: ()->Void){
        print("retrieving match list")
        ref = FIRDatabase.database().reference()
        if self.dataSource.count>0{
            self.kolodaView.reloadData()
            return
        }
        ref.child("users").queryLimitedToFirst(matchCount).observeSingleEventOfType(.Value, withBlock: {
            (snapshot) in
            if let users = snapshot.value as? NSDictionary {
                for (index, key) in (users.allKeys as! [String]).enumerate(){
                    if key==FIRAuth.auth()?.currentUser?.uid{
                        continue
                    }
                    let randomIndex = Int(arc4random_uniform(UInt32(self.picArray.count)))
                    let tempImage = self.picArray[randomIndex]
                    let pi = PersonalInfo(w: 270, h: 270, uid: key, userDict: users[key] as! NSDictionary)
                    self.backgroundPicArray.append(tempImage)
                    self.dataSource.append(pi)
                    print("got \((users[key] as! NSDictionary)["username"])")
                }
                onCompletion()
            } else {
                print("load match list wrong")
            }
            
        })
    }
    
    func swipeLeft(recognizer1: UIGestureRecognizer) {
        let vc = MessageViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(navController, animated: false, completion: nil)
        print("Swiped")
    }
    func swipeRight(recognizer2: UIGestureRecognizer) {
        let vc = PersonalViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(vc, animated: true, completion: nil)
        print("Swiped")
    }
    
    func like(){
        kolodaView.swipe(.Right)
    }
    
    func dislike(){
        kolodaView.swipe(.Left)
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
    

}

//MARK: KolodaViewDelegate
extension MatchViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        print("no cards more")
//        dataSource.insert(UIImage(named: "Card_like_6")!, atIndex: kolodaView.currentCardIndex - 1)
//        let position = kolodaView.currentCardIndex
//        kolodaView.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
//        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
        print("you click")
    }
    func koloda(koloda: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection){
        if direction == .Right {
            print("count \(koloda.countOfCards)")
            print("cur index \(koloda.currentCardIndex)")
            print("you swipe that biatch *RIGHT*")
            print("you swipe \(index) *RIGHT*")
            
            print((dataSource[Int(index)] as! PersonalInfo).uid)
            
            // add uid to matched lis
            if let uid = FIRAuth.auth()!.currentUser?.uid, peer_uid = (dataSource[Int(index)] as? PersonalInfo)?.uid{
                ref.child("users/\(uid)/matched/\(peer_uid)").setValue(NSDate().timeIntervalSince1970*1000)
            } else{
                print("can not get user")
            }

        } else {
            print("you swipe that biatch *LEFT*")
            
        }
    
    }
    
}

//MARK: KolodaViewDataSource
extension MatchViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return UInt(dataSource.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        

        return dataSource[Int(index)]
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {

        let ov = NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                   owner: self, options: nil)[0] as? OverlayView
        print(OverlayView())
        return ov
    }
    
    func koloda(koloda: KolodaView, didShowCardAtIndex index: UInt){
        
        let userTemp = dataSource[Int(index)] as! PersonalInfo
//        let ab = Double(index)
//        let matchCount = Double(matchListLenLimit)*2
        
        self.backgroundPic.image = self.backgroundPicArray[Int(index)]
        self.backgroundPic.setNeedsDisplay()
        userTemp.setAbilityBar([73,64,52,78])
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            let personNamef = snapshot.value![userTemp.uid]!!["username"]!
            let schoolNamef = snapshot.value![userTemp.uid]!!["school"]!
            self.schoolLabel.text = String(schoolNamef!)
            self.nameLabel.text = String(personNamef!)
        })
     
    }
    
    
    func personClick() {
        let vc = ViewOtherProfileViewController()
        let currentSuggestion = (dataSource[self.kolodaView.currentCardIndex] as! PersonalInfo).uid
//        vc.selectedUserID = "YoLazoj0J0cNFLMvoTsjXy7gzmK2"
        vc.selectedUserID = currentSuggestion
//        print(vc.selectedUserID)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(navController, animated: true, completion: nil)
        print("clicked")
        
    }
    
//
//    func kolodaShouldApplyAppearAnimation(koloda: KolodaView) -> Bool {
//        return true
//    }
}
