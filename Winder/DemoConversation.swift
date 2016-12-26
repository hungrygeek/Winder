//
//  DemoConversation.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/11/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import JSQMessagesViewController
import Firebase

// Create Names to display
let DisplayNameSquires = "Jesse Squires"
let DisplayNameLeonard = "Dan Leonard"
let DisplayNameCook = "Tim Cook"
let DisplayNameJobs = "Steve Jobs"
let DisplayNameWoz = "Steve Wazniak"

// Create Unique IDs for avatars
let AvatarIDLeonard = "053496-4509-288"
let AvatarIDSquires = "053496-4509-289"
let AvatarIdCook = "468-768355-23123"
let AvatarIdJobs = "707-8956784-57"
let AvatarIdWoz = "309-41802-93823"

// INFO: Creating Static Demo Data. This is only for the exsample project to show the framework at work.
var conversationsList = [Conversation]()

var convo = Conversation(firstName: "Steave", lastName: "Jobs", preferredName:  "Stevie", smsNumber: "(987)987-9879", id: "33", latestMessage: "Holy Guacamole, JSQ in swift", isRead: false)

var conversation = [JSQMessage]()

let message = JSQMessage(senderId: AvatarIdCook, displayName: DisplayNameCook, text: "How about let's set a time for some CSE438 tutoring?")
let message2 = JSQMessage(senderId: AvatarIDSquires, displayName: DisplayNameSquires, text: "Sure that sounds like a great idea")
let message3 = JSQMessage(senderId: AvatarIdWoz, displayName: DisplayNameWoz, text: "How about Monday 11:45 am?")
let message4 = JSQMessage(senderId: AvatarIdJobs, displayName: DisplayNameJobs, text: "Sure thats for me")
let message5 = JSQMessage(senderId: AvatarIDLeonard, displayName: DisplayNameLeonard, text: "Oh wait but that will be Winder demo time")

//let partner = ShareData()
//
//func makeConversation()->[JSQMessage]{
//    var ref: FIRDatabaseReference!
//    ref = FIRDatabase.database().reference()
//    let userID = FIRAuth.auth()?.currentUser?.uid
//    
//    conversation = []
//    ref.child("messages").observe(.value, with: { snapshot in
//        for child in snapshot.children {
//            //print(userID!)
//            
//            if String(describing: (child as! [String: Any])["fromID"]!) == userID! && String(describing: (child as! [String: Any])["toID"]!) == partner.partnerID {
//
//                print("11111111111111111")
//                let tempmessage = JSQMessage(senderId: String(describing: (child as! [String: Any])["fromID"]!), displayName: "", text: String(describing: (child as! [String: Any])["text"]!))
//                //print(conversation)
//                conversation.append(tempmessage!)
//            }
//        }
//        
//    })
//    return conversation
//}

func getConversation()->[Conversation]{
    return [convo]
}
