//
//  MatchViewController.swift
//  Winder
//
//  Created by Rokee on 11/12/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit
import Koloda

var numberOfCards: UInt = 5

class MatchViewController:UIViewController{
    
//    var profileButton
//    @IBOutlet weak var kv: KolodaView!
    
    var kolodaView2: KolodaView = {
        var kv: KolodaView = KolodaView(frame: CGRect(x:0,y: 0,width:250,height:250))
        kv.countOfVisibleCards = 1
        return kv
    }()
    
    var dataSource: Array<UIView> = {
        var array = Array<UIView>()
        for index in 0...1{
            var userTemp = PersonalInfo(w: 270, h: 270)
            array.append(userTemp)
            userTemp.setAbilityBar([1,1,1,1])
        }
        return array
    }()
    
    
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
    
    override func viewDidAppear(animated: Bool) {
        print("here")
//        print(view.backgroundColor)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        kolodaView.dataSource = self
//        kolodaView.delegate = self
        
        kolodaView2.dataSource = self
        kolodaView2.delegate = self
        
        likeButton.center = CGPoint(x: view.frame.width-likeButton.frame.width-10, y: view.frame.height-likeButton.frame.height-40)
        view.addSubview(likeButton)
        
        dislikeButton.center = CGPoint(x: likeButton.frame.width+10, y: view.frame.height-likeButton.frame.height-20)
        view.addSubview(dislikeButton)
        
        
        personButton.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height)
        view.addSubview(personButton)
        
        nameLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.4)
        view.addSubview(nameLabel)
        
        schoolLabel.center = CGPoint(x: view.frame.midX, y: view.frame.height-likeButton.frame.height*2.0)
        view.addSubview(schoolLabel)
        
        kolodaView2.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        view.addSubview(kolodaView2)
        view.backgroundColor = UIColor.whiteColor()
        let recognizer1: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(MatchViewController.swipeLeft(_:)))
        recognizer1.direction = .Left
        self.view.addGestureRecognizer(recognizer1)
        
        let recognizer2: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(MatchViewController.swipeRight(_:)))
        recognizer2.direction = .Right
        self.view.addGestureRecognizer(recognizer2)
        
        
        }
    
    
    func swipeLeft(recognizer1: UIGestureRecognizer) {
        let vc = ChatViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: false, completion: nil)
        print("Swiped")
    }
    func swipeRight(recognizer2: UIGestureRecognizer) {
        let vc = PersonalViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: false, completion: nil)
        print("Swiped")
    }
    
}

//MARK: KolodaViewDelegate
extension MatchViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        print("no cards more")
//        dataSource.insert(UIImage(named: "Card_like_6")!, atIndex: kolodaView2.currentCardIndex - 1)
//        let position = kolodaView2.currentCardIndex
//        kolodaView2.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
//        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
        print("you click")
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
}
