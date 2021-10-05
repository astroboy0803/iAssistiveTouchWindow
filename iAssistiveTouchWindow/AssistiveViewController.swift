//
//  AssistiveViewController.swift
//  iAssistiveTouchWindow
//
//  Created by i9400506 on 2021/10/5.
//

import UIKit

internal final class AssistiveViewController: UIViewController {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let textField: UITextField
    
    private let lButton: UIButton
    
    private let rButton: UIButton
    
    private let ballWindow : AssistiveWindow
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init() {
        lButton = .init()
        rButton = .init()
        textField = .init()
        ballWindow = .init(frame: .init(x: 0, y: 65, width: 65, height: 65))
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidBecomeVisible(_:)), name: UIWindow.didBecomeVisibleNotification, object: nil)
        
        textField.delegate = self
        self.setupView()
        self.setupEvent()
    }
    
    @objc
    private func windowDidBecomeVisible(_ notification:Notification){
        
        let window = notification.object as! UIWindow
        let windows = UIApplication.shared.windows
        windows.forEach {
            debugPrint($0.windowLevel)
        }
        
        print("\nwindow目前總數：\(windows.count)")
        print("Become Visible資訊：\(window)")
        print("windowLevel數值：\(window.windowLevel)\n")
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemTeal
        
        textField.backgroundColor = .white
        textField.smartInsertDeleteType = .no
        textField.clearButtonMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10
        textField.font = .systemFont(ofSize: 18)
        
        lButton.setTitle("Sheet", for: .normal)
        rButton.setTitle("Alert", for: .normal)
        
        [lButton, rButton]
            .forEach {
                $0.backgroundColor = .systemGreen
                $0.setTitleColor(.white, for: .normal)
                $0.setTitleColor(.systemGray, for: .highlighted)
                $0.layer.cornerRadius = 8
                $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            }
        
        self.setupLayout()
    }
    
    private func setupLayout() {
        [textField, lButton, rButton]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview($0)
            }
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            lButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            lButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            lButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            lButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -10),
            
            rButton.widthAnchor.constraint(equalTo: lButton.widthAnchor),
            rButton.heightAnchor.constraint(equalTo: lButton.heightAnchor),
            rButton.centerYAnchor.constraint(equalTo: lButton.centerYAnchor),
            rButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10)
        ])
    }
    
    private func setupEvent() {
        lButton.addTarget(self, action: #selector(self.showActionSheet(_:)), for: .touchUpInside)
        rButton.addTarget(self, action: #selector(self.showAlert(_:)), for: .touchUpInside)
    }

    @objc
    private func showActionSheet(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "ActionSheet", message: "TestTest", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc
    private func showAlert(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Alert", message: "TestTest", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(action)

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ballWindow.isHidden = false
    }
}

extension AssistiveViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
