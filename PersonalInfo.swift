//
//  PersonalInfo.swift
//  
//
//  Created by Yugui Chen on 16/11/23.
//
//

import UIKit

class PersonalInfo:UIView, CAAnimationDelegate {
    
    var image = UIImageView()
    var layerArray = Array<CAShapeLayer>()
    public let userDict: NSDictionary
    public let uid: String
    public let skills: NSDictionary
    public let username: String
    public let school: String
    public let email: String
    

    init(w:CGFloat,h:CGFloat, uid:String, userDict: NSDictionary){
        let na = "N/A"
        self.uid = uid
        self.userDict = userDict
        self.skills = userDict["skill"] as? NSDictionary ?? [:]
        self.username = userDict["username"] as? String ?? na
        self.school = userDict["school"] as? String ?? na
        self.email = userDict["email"] as? String ?? na
        super.init(frame:CGRect(x: 0, y: 0, width: w, height: h))
        loadImageUsingCacheWithUrlString(userDict["image"] as! String)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func loadImageUsingCacheWithUrlString(_ urlString: String) {
        // TODO: shall we use NSCache here?
        // how to reload if we use NSCache?
        // should I cache the image or all PersonalInfo object in the array?
        // 20170324: Let's not worry about cache right now
        if urlString == "" {
             print("the url is null")
        }
        else if self.image.image != nil {
            print("we got profile image already")
        } else {
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                
                //download hit an error so lets return out
                if (error != nil) {
                    print(error)
                    return
                }

                DispatchQueue.main.async(execute: {
                    if let downloadedImage = UIImage(data: data!) {
                        self.image = UIImageView(image: downloadedImage)
                        self.image.frame = CGRect(x: 0, y: 0, width: 240, height: 240)
                        self.image.layer.cornerRadius = 120
                        self.image.clipsToBounds = true
                        self.image.layer.backgroundColor = UIColor.white.cgColor
                        self.image.center = CGPoint(x: self.frame.midX, y: self.frame.midY)
                        self.addSubview(self.image)
//                        self.image.setNeedsDisplay() //no necessary when using dispatch
                    }
                })
            }).resume()
            // After you create the task, you must start it by calling its resume() method.
            // from https://developer.apple.com/reference/foundation/urlsession/1407613-datatask
        }
    }

    func setAbilityBarAndDisplay(){
        // display the top 4 skills of that person
        let keys = self.skills.allKeys as! [String]
        let centerPoint = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let c = min(keys.count, 4)
        for index:Int in 0..<c{
            let skill = UILabel()
            skill.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
            let hOffset = self.frame.height/2+CGFloat(index)*15
            skill.center = CGPoint(x: self.frame.midX-20, y: self.frame.midY-hOffset)
            skill.text = keys[index]
            skill.font = skill.font.withSize(10)
            let layer = CAShapeLayer()
            layer.backgroundColor = UIColor.clear.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = UIColor.getCustomColor(UIColor())(Int(index)).cgColor
            layer.lineWidth = 15
            layer.lineCap = kCALineCapRound
            let startAngle = CGFloat(M_PI_2*3)
            let abilityLevel = self.skills[keys[index]] as! Int
            let endAngle = CGFloat(M_PI_2*3 + M_PI*Double(abilityLevel)*0.0175)
            layer.path = UIBezierPath(arcCenter:centerPoint, radius: hOffset, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.delegate = self
            animation.duration = 1
            animation.fromValue = 0
            animation.toValue = 1
            layer.strokeEnd = 1
            layer.add(animation, forKey: nil)
            layerArray.append(layer)
            self.backgroundColor = UIColor.clear
            
            self.layer.addSublayer(layer)
            self.addSubview(skill)
        }
    }
    
//    private var shapelayerArray: Array<CAShapeLayer> = {
//        var shapelayerArray: Array<CAShapeLayer> = []
//        for index in 0..<4{
//            let layer = CAShapeLayer()
//            layer.strokeColor = UIColor.getWustlGreenColor(UIColor())().CGColor
//            layer.fillColor = UIColor.getCustomColor(UIColor())(Int(index)).CGColor
//            layer.lineWidth = 10
//            layer.lineCap = kCALineCapRound
//            layer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 100+Int(index)*20, height: 100+Int(index)*20)).CGPath
//            shapelayerArray.append(layer)
//        }
//        return shapelayerArray
//    }()
    
//    private var abilityValArray: Array<CGFloat> = {
//        var abilityValArray : Array<CGFloat> = []
//        var abilityVal: CGFloat
//        for index in 0..<4{
//            abilityVal = 0.8-CGFloat(index)*0.1
//            abilityValArray.append(abilityVal)
//        }
//        return abilityValArray
//    }()
    
//    func imageFinished(image:UIImageView,shapelayerArray:Array<CAShapeLayer>){
//        let image = UIImageView()
//        var shapeLayerArray = Array<CAShapeLayer>()
//        for index in 0..<4{
//            image.layer.addSublayer(shapeLayerArray[index])
//            self.addSubview(image)
//        }
//    }
    
//    func setAbilityStrokeEnd(abilityValArray:Array<CGFloat>){
//        
//        for index in 0..<4{
//            shapelayerArray[index].strokeEnd = abilityValArray[index]
//        }
//    }
//    
//
//    }
    
}
