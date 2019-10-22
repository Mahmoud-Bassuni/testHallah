//
//  InputVC.swift
//  hallah
//
//  Created by Nada Gamal on 10/22/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import UIKit
class InputVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotificationCenter()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeNotificationCenter()
    }
    func addNotificationCenter()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:Notification.Name.UIKeyboardWillHide, object: nil);
    }
    func removeNotificationCenter()
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = -1 * 100
            self.view.layoutIfNeeded()
        })
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = 0
            self.view.layoutIfNeeded()
        })
    }
}
