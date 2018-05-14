//
//  Spinner.swift
//  ActivityButton
//
//  Created by Martin Otyeka on 2018-05-13.
//  Copyright © 2018 Dopeness Academy. All rights reserved.
//

import UIKit

class Spinner: UIView {
    
    enum SpinnerStyle : Int{
        case none = 0
        case light = 1
        case dark = 2
    }
    
    var Style : SpinnerStyle = .dark
    
    public var outerFillColor : UIColor = .clear
    public var outerStrokeColor : UIColor = .lightGray
    public var outerLineWidth : CGFloat = 1.8
    public var outerEndStroke : CGFloat = 0.5
    public var outerAnimationDuration : CGFloat = 2.5
    
    public var enableInnerLayer : Bool = true
    
    public var innerFillColor : UIColor  = .clear
    public var innerStrokeColor : UIColor = .lightGray
    public var innerLineWidth : CGFloat = 1.8
    public var innerEndStroke : CGFloat = 0.5
    public var innerAnimationDuration : CGFloat = 2.5
    
    var currentInnerRotation : CGFloat = 0
    var currentOuterRotation : CGFloat = 0
    
    var innerView : UIView = UIView()
    var outerView : UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.draw()
    }
    
    private func draw() {
        
        self.isHidden = true
        
        self.backgroundColor = .clear
        
        switch Style{
        case .dark:
            outerStrokeColor = .lightGray
            innerStrokeColor = .lightGray
        case .light:
            outerStrokeColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
            innerStrokeColor = UIColor ( red: 0.9333, green: 0.9333, blue: 0.9333, alpha: 1.0 )
        case .none:
            break
        }
        self.addSubview(outerView)
        outerView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        outerView.center = self.convert(self.center, from: self.superview)
        
        let outerLayer = CAShapeLayer()
        outerLayer.path = UIBezierPath(ovalIn: outerView.bounds).cgPath
        outerLayer.lineWidth = outerLineWidth
        outerLayer.strokeStart = 0.0
        outerLayer.strokeEnd = outerEndStroke
        outerLayer.lineCap = kCALineCapRound
        outerLayer.fillColor = outerFillColor.cgColor
        outerLayer.strokeColor = outerStrokeColor.cgColor
        outerView.layer.addSublayer(outerLayer)
        
        if enableInnerLayer {
            
            self.addSubview(innerView)
            innerView.frame = CGRect(x: 0 ,y: 0, width: self.bounds.width - 8, height: self.bounds.height - 8)
            innerView.center = self.convert(self.center, from: self.superview)
            let innerLayer = CAShapeLayer()
            innerLayer.path = UIBezierPath(ovalIn: innerView.bounds).cgPath
            innerLayer.lineWidth = innerLineWidth
            innerLayer.strokeStart = 0
            innerLayer.strokeEnd = innerEndStroke
            innerLayer.lineCap = kCALineCapRound
            innerLayer.fillColor = innerFillColor.cgColor
            innerLayer.strokeColor = innerStrokeColor.cgColor
            
            innerView.layer.addSublayer(innerLayer)
        }
    }
    
    func animateInnerRing(){
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0 * CGFloat(Double.pi/180)
        rotationAnimation.toValue = 360 * CGFloat(Double.pi/180)
        rotationAnimation.duration = Double(innerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        self.innerView.layer.add(rotationAnimation, forKey: "rotateInner")
    }
    func animateOuterRing(){
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 360 * CGFloat(Double.pi/180)
        rotationAnimation.toValue = 0 * CGFloat(Double.pi/180)
        rotationAnimation.duration = Double(outerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        self.outerView.layer.add(rotationAnimation, forKey: "rotateOuter")
    }
    
    func startAnimating(){
        self.isHidden = false
        self.animateOuterRing()
        self.animateInnerRing()
    }
    
    func stopAnimating(){
        self.isHidden = true
        self.outerView.layer.removeAllAnimations()
        self.innerView.layer.removeAllAnimations()
        
    }
}
