//
//  ChatViewController.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/11/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class ChatViewController: JSQMessagesViewController {
    //var messages = [JSQMessage]()
    
    var conversation: Conversation?
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    let partner = ShareData.sharedInstance
    var messages = [JSQMessage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(handleBack))
        self.title = partner.partnerName
        //print(self.partner.partnerID)
        //print(self.partner.partnerName)
        
        
        self.inputToolbar?.contentView?.leftBarButtonItem = nil
        
        
        // This is how you remove Avatars from the messagesView
        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        
        // This is a beta feature that mostly works but to make things more stable I have diabled it.
        collectionView?.collectionViewLayout.springinessEnabled = false
        
        //Set the SenderId  to the current User
        // For this Demo we will use Woz's ID
        // Anywhere that AvatarIDWoz is used you should replace with you currentUserVariable
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        senderId = userID
        senderDisplayName = conversation?.firstName ?? conversation?.preferredName ?? conversation?.lastName ?? ""
        automaticallyScrollsToMostRecentMessage = true
        
//        if (conversation?.smsNumber) != nil {
//            self.messages = makeConversation()
//            
//            self.collectionView?.reloadData()
//            self.collectionView?.layoutIfNeeded()
//        }
        
        //self.messages = makeConversation()
        makeConversation()
        print("11111111111")
        print(self.messages)
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ChatViewController.swipeRight(_:)))
        recognizer.direction = .Right
        self.view.addGestureRecognizer(recognizer)
        
        
    }
    
    override func didPressSendButton(button: UIButton?, withMessageText text: String?, senderId: String?, senderDisplayName: String?, date: NSDate?) {

        let userID = FIRAuth.auth()?.currentUser?.uid
        
        // This is where you would impliment your method for saving the message to your backend.
        //
        // For this Demo I will just add it to the messages list localy
        //
        
        
        
        
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        //is it there best thing to include the name inside of the message node
        let values = ["text": text, "fromID": userID, "toID": self.partner.partnerID]
        childRef.updateChildValues(values)
        self.messages.append(JSQMessage(senderId: userID, displayName: "", text: text))
        self.finishSendingMessageAnimated(true)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData? {
        
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource? {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        return messages[indexPath.item].senderId == userID ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource? {
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        switch message.senderId {
        case userID!:
            return nil
        default:
            guard let senderDisplayName = message.senderDisplayName else {
                assertionFailure()
                return nil
            }
            return NSAttributedString(string: senderDisplayName)
            
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout?, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        return messages[indexPath.item].senderId == userID ? 0 : kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    func swipeRight(recognizer: UIGestureRecognizer) {
        let vc = MatchViewController()
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(vc, animated: false, completion: nil)
        print("Swiped")
    }
    
    func handleBack() {
        let vc = MessageViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(navController, animated: false, completion: nil)
        
    }
    
    
    func makeConversation(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        
        ref.child("messages").observeEventType(.Value, withBlock: { snapshot in
            self.messages = [JSQMessage]()
            for child in snapshot.children {
                //print(userID!)
                
                if String(child.value["fromID"]!!) == userID! && String(child.value["toID"]!!) == self.partner.partnerID {
                    
                    //print("11111111111111111")
                    let tempmessage = JSQMessage(senderId: String(child.value["fromID"]!!), displayName: "", text: String(child.value["text"]!!))
                    //print(conversation)
                    self.messages.append(tempmessage)
                }
            }
            self.collectionView?.reloadData()
        })
        //self.collectionView?.reloadData()
        //return messages
    }

    
    
    
}