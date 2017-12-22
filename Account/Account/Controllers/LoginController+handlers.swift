//
//  LoginController+handlers.swift
//  Account
//
//  Created by George Alexandru Tomache on 12/14/17.
//  Copyright © 2017 George Alexandru Tomache. All rights reserved.
//

import UIKit
import Firebase

extension LoginController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func registerUserButton() {
        profileImageView.isUserInteractionEnabled = true
        // Function for Register Button
        guard let name = nameTextField.text, let password = passwordTextField.text, let email = emailTextField.text else {
            print("Form is not valid")
            return
        }
        // Authentification
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user : Firebase.User?, error) in
            if (error != nil) {
                print(error!)
                return
            }
            // Success create user
            guard let userID = user?.uid else {
                return
            }
            
            // Reference to Storage Firebase
            let storageRef = Storage.storage().reference()
            let storageRefWithChild = storageRef.child("images.png")
            if let updateData = UIImagePNGRepresentation(self.profileImageView.image!) {
                storageRefWithChild.putData(updateData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    print("Image saved in Storage!")
                })
            }
            
            // Add info to Database
            // Reference to database Firebase
            let ref = Database.database().reference(fromURL: "https://chatios-f419d.firebaseio.com/")
            
            let values = ["name" : name, "email" : email]
            let refUser = ref.child("Users").child(userID)
            refUser.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if (err != nil) {
                    print(err!)
                    return
                }
                // Dismiss the ViewController
                self.dismiss(animated: true, completion: nil)
                print("User has been added to database!")
            })
            
        })
    }
    
    @objc func handleImageViewSelection() {
        // To access the pictures from Iphone
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var imageFromPicker : UIImage?
        
        
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageFromPicker = originalImage
        }
        if let image = imageFromPicker {
            self.profileImageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
