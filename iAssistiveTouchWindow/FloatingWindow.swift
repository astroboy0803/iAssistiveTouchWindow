//
//  FloatingWindow.swift
//  iAssistiveTouchWindow
//
//  Created by i9400506 on 2021/10/5.
//

import UIKit

internal final class FloatingWindow: UIWindow {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var button: UIButton?

    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .clear
    }

    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let button = button else { return false }
        let buttonPoint = convert(point, to: button)
        return button.point(inside: buttonPoint, with: event)
    }
}
