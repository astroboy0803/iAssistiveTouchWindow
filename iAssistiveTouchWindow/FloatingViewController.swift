//
//  FloatingViewController.swift
//  iAssistiveTouchWindow
//
//  Created by i9400506 on 2021/10/5.
//

// Reference:
// https://stackoverflow.com/questions/34777558/in-ios-how-do-i-create-a-button-that-is-always-on-top-of-all-other-view-control
// https://gist.github.com/mayoff/ea37ee75a87efab5d7e8

import UIKit

internal final class FloatingViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    internal let button: UIButton
    
    private let window: FloatingWindow

    init() {
        button = .init(type: .custom)
        window = .init()
        super.init(nibName: nil, bundle: nil)
        
        window.windowLevel = .init(.greatestFiniteMagnitude)
        window.rootViewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(note:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    override func loadView() {
        button.frame = .init(x: 0, y: UIScreen.main.bounds.height/2, width: 100, height: 60)
        button.setTitle("Floating", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize.zero
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
        
        view = .init()
        view.addSubview(button)
        view.backgroundColor = .systemOrange
        
        window.button = button

        let panner = UIPanGestureRecognizer(target: self, action: #selector(self.panDidFire(panner:)))
        button.addGestureRecognizer(panner)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        snapButtonToSocket()
    }

    @objc
    private func panDidFire(panner: UIPanGestureRecognizer) {
        let offset = panner.translation(in: view)
        panner.setTranslation(.zero, in: view)
        var center = button.center
        center.x += offset.x
        center.y += offset.y
        button.center = center

        if panner.state == .ended || panner.state == .cancelled {
            UIView.animate(withDuration: 0.3) {
                self.snapButtonToSocket()
            }
        }
    }

    @objc
    private func keyboardDidShow(note: NSNotification) {
        window.windowLevel = .init(.zero)
        window.windowLevel = .init(.greatestFiniteMagnitude)
    }

    private func snapButtonToSocket() {
        var bestSocket = CGPoint.zero
        var distanceToBestSocket = CGFloat.infinity
        let center = button.center
        for socket in sockets {
            let distance = hypot(center.x - socket.x, center.y - socket.y)
            if distance < distanceToBestSocket {
                distanceToBestSocket = distance
                bestSocket = socket
            }
        }
        button.center = bestSocket
    }

    private var sockets: [CGPoint] {
        let buttonSize = button.bounds.size
        let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
        let sockets: [CGPoint] = [
            .init(x: rect.minX, y: rect.minY),
            .init(x: rect.minX, y: rect.maxY),
            .init(x: rect.maxX, y: rect.minY),
            .init(x: rect.maxX, y: rect.maxY),
            .init(x: rect.midX, y: rect.midY)
        ]
        return sockets
    }
}
