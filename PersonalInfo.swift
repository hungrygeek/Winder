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
    var ability = Array<Int>()
    var layerArray = Array<CAShapeLayer>()
    
    init(w:CGFloat,h:CGFloat){
        super.init(frame:CGRect(x: 0, y: 0, width: w, height: h))
        image = UIImageView(image: UIImage(named: "avatar1")!)
        image.frame = CGRectMake(0, 0, 240, 240)
        image.layer.cornerRadius = 120
        image.clipsToBounds = true
//        image.layer.backgroundColor = UIColor.whiteColor().CGColor
        image.center = CGPointMake(self.frame.midX, self.frame.midY-100)
        ability = [1,1,1,1]
        self.addSubview(image)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAbilityBar(ability:Array<Int>){
        let abilityArray = ["Math","Physics","English","Painting"]
        let centerPoint = CGPointMake(self.frame.midX, self.frame.midY-100)
        for index:Int in 0..<4 {
            let ability = UILabel()
            ability.frame = CGRectMake(0, 0, 100, 15)
            ability.center = CGPointMake(self.frame.midX-20, self.frame.midY-100-CGFloat(index+8)*15)
            ability.text = abilityArray[index]
            ability.font = ability.font.fontWithSize(12)
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clearColor().CGColor
            layer.strokeColor = UIColor.getCustomColor(UIColor())(Int(index)).CGColor
            layer.lineWidth = 15
            layer.lineCap = kCALineCapRound
            let startAngle = CGFloat(M_PI_2*3)
            let endAngle = CGFloat(M_PI_2*3 + M_PI/Double(index+1))
            layer.path = UIBezierPath(arcCenter:centerPoint, radius: CGFloat(index+8)*15, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.delegate = self
            animation.duration = 3
            animation.fromValue = 0
            animation.toValue = 1
            layer.strokeEnd = 1
            layer.addAnimation(animation, forKey: nil)
            layerArray.append(layer)

            self.layer.addSublayer(layer)
            self.addSubview(ability)
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