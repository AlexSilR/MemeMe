//
//  MemeViewController+.swift
//  MemeMe
//
//  Created by Alex da Silva Ribeiro on 26/06/17.
//  Copyright © 2017 AlexSilR. All rights reserved.
//

import UIKit

// MARK: - UIImagePickerControllerDelegate
extension MemeViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
        self.shareBarButton.isEnabled = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension MemeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
}

// MARK: - UINavigationControllerDelegate
extension MemeViewController: UINavigationControllerDelegate { }
