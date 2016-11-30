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
    
    init(w:CGFloat,h:CGFloat){
        super.init(frame:CGRect(x: 0, y: 0, width: w, height: h))
        image = UIImageView(image: UIImage(named: "logo")!)
        ability = [1,1,1,1]
        var shapelayerArray: Array<CAShapeLayer> = []
        for index in 0..<4{
            let layer = CAShapeLayer()
            layer.strokeColor = UIColor.getWustlGreenColor(UIColor())().CGColor
            layer.fillColor = UIColor.getCustomColor(UIColor())(Int(index)).CGColor
            layer.lineWidth = 10
            layer.lineCap = kCALineCapRound
            layer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 100+Int(index)*20, height: 100+Int(index)*20)).CGPath
            shapelayerArray.append(layer)
            image.layer.addSublayer(shapelayerArray[index])
            self.addSubview(image)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
//    func animateStroke() {
//        
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        for index in 0..<4{
//            animation.delegate = self
//            animation.duration = 1
//            animation.fromValue = 0
//            animation.toValue = 0.8
//            shapelayerArray[index].strokeEnd = 0.8
//            shapelayerArray[index].addAnimation(animation, forKey: nil)
//
//        }
//        
//    }
    
}