//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Alex da Silva Ribeiro on 18/06/17.
//  Copyright © 2017 AlexSilR. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var libraryBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // MARK: View Life Cicle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes: [String: Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -1,
        ]
        
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.topTextField.textAlignment = .center
        self.topTextField.text = "TOP"
        self.topTextField.delegate = self
        
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.textAlignment = .center
        self.bottomTextField.text = "BOTTOM"
        self.bottomTextField.delegate = self
        
        self.cameraBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.libraryBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        self.shareBarButton.isEnabled = false
    }

    // MARK: IBActions
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func takeAnPhoto(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        let memeImage = self.generateMemedImage()
        let imageToShare = [memeImage]
        
        let activityViewController = UIActivityViewController(activityItems: imageToShare,applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: Notification
    func keyboardWillShow(_ notification: Notification) {
        if let firstResponder = self.view.findFirstResponder() as? UITextField {
            if firstResponder.tag == 2 {
                self.view.frame.origin.y = 0 - self.getKeyboardHight(notification)
            }
        } else {
            self.view.frame.origin.y = 0 - self.getKeyboardHight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Private
    private func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.shareView.frame.size)
        self.shareView.drawHierarchy(in: self.shareView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
}

