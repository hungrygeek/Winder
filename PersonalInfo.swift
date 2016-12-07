//
//  PersonalInfo.swift
//  
//
//  Created by Yugui Chen on 16/11/23.
//
//

import UIKit

class PersonalInfo:UIView {
    
    var image = UIImageView()
    var ability = Array<Double>()
    var layerArray = Array<CAShapeLayer>()
    
    //hardcoded info
    var uid: String
//    var id: Int
    //hardcoded info ends
    
    init(w:CGFloat,h:CGFloat, uid:String, userDict: NSDictionary){
        self.uid = uid
        super.init(frame:CGRect(x: 0, y: 0, width: w, height: h))
        loadImageUsingCacheWithUrlString(userDict["image"] as! String)
//        image = UIImage(named:userDict["image"])
                self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImageUsingCacheWithUrlString(urlString: String) {
        if urlString == "" || self.image.image != nil {
            print("we got profile image or the url is null")
            
        } else {
            print("got \(urlString)")
            let url = NSURL(string: urlString)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                
                //download hit an error so lets return out
                if error != nil {
                    print(error)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if let downloadedImage = UIImage(data: data!) {
                        
                        self.image = UIImageView(image: downloadedImage)
                        self.image.frame = CGRectMake(0, 0, 240, 240)
                        self.image.layer.cornerRadius = 120
                        self.image.clipsToBounds = true
                        self.image.layer.backgroundColor = UIColor.whiteColor().CGColor
                        self.image.center = CGPointMake(self.frame.midX, self.frame.midY)
                        self.addSubview(self.image)
                        self.image.setNeedsDisplay()
                    }
                    
                })
                
            }).resume()
        }
        
    }
    
    func setAbilityBar(abilityLevel:Array<Double>){
//        var ability = ability
        print(abilityLevel)
        let courseArray = ["Math","Physics","English","Painting"]
        let centerPoint = CGPointMake(self.frame.midX, self.frame.midY)
        for index:Int in 0..<4 {
            let skill = UILabel()
            skill.frame = CGRectMake(0, 0, 100, 15)
            skill.center = CGPointMake(self.frame.midX-20, self.frame.midY-CGFloat(index+8)*15)
            skill.text = courseArray[index]
            skill.font = skill.font.fontWithSize(12)
            let layer = CAShapeLayer()
            layer.backgroundColor = UIColor.clearColor().CGColor
            layer.fillColor = UIColor.clearColor().CGColor
            layer.strokeColor = UIColor.getCustomColor(UIColor())(Int(index)).CGColor
            layer.lineWidth = 15
            layer.lineCap = kCALineCapRound
            let startAngle = CGFloat(M_PI_2*3)
            let endAngle = CGFloat(M_PI_2*3 + M_PI*abilityLevel[index]*0.0175)
            layer.path = UIBezierPath(arcCenter:centerPoint, radius: CGFloat(index+8)*15, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.delegate = self
            animation.duration = 1
            animation.fromValue = 0
            animation.toValue = 1
            layer.strokeEnd = 1
            layer.addAnimation(animation, forKey: nil)
            layerArray.append(layer)
            self.backgroundColor = UIColor.clearColor()

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