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

private var numberOfCards: UInt = 3
private var matchListLenLimit: UInt = 5

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

    var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Cat Wang"
        label.textColor = UIColor.redColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(25, weight: UIFontWeightLight)
        label.frame = CGRect(x:0,y:0,width: 200,height: 50)
        return label
    }()
    
    var schoolLabel:UILabel = {
        let label = UILabel()
        label.text = "Cashington University"
        label.textColor = UIColor.redColor()
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
        return button
    }()
    
    var dislikeButton: UIButton = {
        let checkImg = UIImage(named:"Thumbs Down")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 75,height: 75)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        return button
    }()
    
    var personButton: UIButton = {
        let checkImg = UIImage(named:"person")! as UIImage
        var button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 45,height: 45)
        button.setBackgroundImage(checkImg, forState: UIControlState.Normal)
        return button
    }()
    
    var backgroundPic = UIImageView()
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)

    
    override func viewDidAppear(animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            print("login success")
            print("uid: \(FIRAuth.auth()!.currentUser!.uid)")
            print("login in with \(FIRAuth.auth()!.currentUser!.email)")
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        likeButton.center = CGPoint(x: view.frame.width-likeButton.frame.width-10, y: view.frame.height-likeButton.frame.height-40)
        view.addSubview(likeButton)
        
        dislikeButton.addTarget(self, action: #selector(ViewController.signOut), forControlEvents:UIControlEvents.TouchUpInside)
        dislikeButton.center = CGPoint(x: likeButton.frame.width+10, y: view.frame.height-likeButton.frame.height-20)
        view.addSubview(dislikeButton)
        
        
        personButton.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height)
        personButton.addTarget(self, action: #selector(MatchViewController.personClick), forControlEvents:UIControlEvents.TouchUpInside)
        view.addSubview(personButton)
        
        nameLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.4)
        view.addSubview(nameLabel)
        
        schoolLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.0)
        view.addSubview(schoolLabel)
        
        // use call back to get the data
        
        getMatchList(){
            () in
            self.kolodaView = KolodaView(frame: CGRect(x:0,y: 0,width:250,height:250))
            self.kolodaView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
            self.kolodaView.dataSource = self
            self.kolodaView.delegate = self
            self.view.addSubview(self.kolodaView)
            let total = Double(matchListLenLimit)*2
            (self.dataSource[0] as! PersonalInfo).setAbilityBar([1/total,(1+1)/total,(1+2)/total,(1+3)/total])
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
        ref.child("users").queryLimitedToFirst(matchCount).observeSingleEventOfType(.Value, withBlock: {
            (snapshot) in
            if let users = snapshot.value as? NSDictionary {
                for (index, key) in (users.allKeys as! [String]).enumerate(){

                    let pi = PersonalInfo(w: 270, h: 270, uid: key, userImage: UIImageView(image:UIImage(named: "avatar\(index+1)")))
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
        navController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(navController, animated: false, completion: nil)
        print("Swiped")
    }
    func swipeRight(recognizer2: UIGestureRecognizer) {
        let vc = PersonalViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: true, completion: nil)
        print("Swiped")
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
        let ab = Double(index)
        let matchCount = Double(matchListLenLimit)*2
        userTemp.setAbilityBar([ab/matchCount,(ab+1)/matchCount,(ab+2)/matchCount,(ab+3)/matchCount])
//        userTemp.setAbilityBar([0.5,0.5,0.5,0.5])
//        backgroundPic.frame = self.view.frame
//        backgroundPic.image = UIImage(named: "avatar\(index+1)")
//        backgroundPic.clipsToBounds = true
//        backgroundPic.center = self.view.center
//        backgroundPic.alpha = 0.4
    }
    
    
    func personClick() {
        let vc = ViewOtherProfileViewController()
        let currentSuggestion = (dataSource[self.kolodaView.currentCardIndex] as! PersonalInfo).uid
        vc.selectedUserID = "YoLazoj0J0cNFLMvoTsjXy7gzmK2"
        vc.selectedUserID = currentSuggestion
        print(vc.selectedUserID)
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
