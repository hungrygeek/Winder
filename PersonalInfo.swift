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
    var ability = Array<Double>()
    var layerArray = Array<CAShapeLayer>()
    var userDict: NSDictionary
    var uid: String

    init(w:CGFloat,h:CGFloat, uid:String, userDict: NSDictionary){
        self.uid = uid
        self.userDict = userDict
        super.init(frame:CGRect(x: 0, y: 0, width: w, height: h))
        loadImageUsingCacheWithUrlString(userDict["image"] as! String)
//        image = UIImage(named:userDict["image"])
                self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func loadImageUsingCacheWithUrlString(_ urlString: String) {
        if urlString == "" || self.image.image != nil {
            print("we got profile image or the url is null")
            
        } else {
//            print("got \(urlString)")
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                //download hit an error so lets return out
                if error != nil {
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
                        self.image.setNeedsDisplay()
                    }
                })
            }).resume()
        }
    }

    func setAbilityBar2(){
        let keys = (self.userDict["skill"]! as AnyObject).allKeys as! [String]
        let centerPoint = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let c = min(keys.count, 4)
        for index:Int in 0..<c{
            let skill = UILabel()
            skill.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
            skill.center = CGPoint(x: self.frame.midX-20, y: self.frame.midY-CGFloat(index+8)*15)
            skill.text = keys[index]
            skill.font = skill.font.withSize(10)
            let layer = CAShapeLayer()
            layer.backgroundColor = UIColor.clear.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = UIColor.getCustomColor(UIColor())(Int(index)).cgColor
            layer.lineWidth = 15
            layer.lineCap = kCALineCapRound
            let startAngle = CGFloat(M_PI_2*3)
//            print("ability \((self.userDict["skill"] as AnyObject).value(forKey: keys[index]))")
            let abilityLevel = ((self.userDict["skill"] as AnyObject).value(forKey: keys[index])) as! Int
//            let skillValue = abilityLevel as! Double
            let endAngle = CGFloat(M_PI_2*3 + M_PI*Double(abilityLevel)*0.0175)
            layer.path = UIBezierPath(arcCenter:centerPoint, radius: CGFloat(index+8)*15, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
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
    
    func setAbilityBar(_ abilityLevel:Array<Double>){
//        var ability = ability
        print(abilityLevel)
        let courseArray = ["Math","Physics","English","Painting"]
        let centerPoint = CGPoint(x: self.frame.midX, y: self.frame.midY)
        for index:Int in 0..<4 {
            let skill = UILabel()
            skill.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
            skill.center = CGPoint(x: self.frame.midX-20, y: self.frame.midY-CGFloat(index+8)*15)
            skill.text = courseArray[index]
            skill.font = skill.font.withSize(12)
            let layer = CAShapeLayer()
            layer.backgroundColor = UIColor.clear.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = UIColor.getCustomColor(UIColor())(index).cgColor
            layer.lineWidth = 15
            layer.lineCap = kCALineCapRound
            let startAngle = CGFloat(M_PI_2*3)
            let endAngle = CGFloat(M_PI_2*3 + M_PI*abilityLevel[index]*0.0175)
            layer.path = UIBezierPath(arcCenter:centerPoint, radius: CGFloat(index+8)*15, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
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
