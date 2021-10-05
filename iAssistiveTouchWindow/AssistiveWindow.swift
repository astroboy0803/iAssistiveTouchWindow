//
//  AssistiveWindow.swift
//  iAssistiveTouchWindow
//
//  Created by i9400506 on 2021/10/5.
//
// Reference
// https://medium.com/@jerrywang0420/uiwindow-教學-swift-3-ios-85c2c90093f8
// https://github.com/Jerry0420/AssistiveTouchExample/blob/master/AssistiveTouchExample/AssistiveTouchExample/CustomUIWindow.swift

import UIKit

internal final class AssistiveWindow: UIWindow {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.contents = UIImage(named: "ball1")?.cgImage
        windowLevel = .alert + 1
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(pan:)))
        pan.delaysTouchesBegan = true
        addGestureRecognizer(pan)
    }
    
    @objc
    private func handlePanGesture(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: UIApplication.shared.keyWindow)
        let originalCenter = center
        center = CGPoint(x:originalCenter.x + translation.x, y:originalCenter.y + translation.y)
        pan.setTranslation(CGPoint.zero, in: UIApplication.shared.keyWindow)
    }
}
