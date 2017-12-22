//
//  MessagesViewController.swift
//  Account
//
//  Created by George Alexandru Tomache on 12/19/17.
//  Copyright © 2017 George Alexandru Tomache. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController {
   
    // Properties
    var databaseReference = Database.database().reference(fromURL: "https://chatios-f419d.firebaseio.com/")
    
    // Elements
    let textViewForMessage : UITextView = {
        let txt = UITextView()
        txt.backgroundColor = UIColor.blue
        txt.textColor = UIColor.white
        txt.layer.cornerRadius = 10
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    // the sec ideea for for messages
    let imageView : UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "ChatForMe.png")
        return i
    }()
    
    
    let footerUIView : UIView = {
        let footer = UIView()
        footer.backgroundColor = UIColor.white
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
    }()
    
    let viewTextMessage : UITextField = {
        // Create a new element
        // UIView element
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Text message!"
        textField.textColor = UIColor.black
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let separatorForTextField : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        navigationItem.title = "User Name"
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(textViewForMessage)
        view.addSubview(footerUIView)
        view.addSubview(separatorForTextField)
       
        footerConstraints()
        messagesContraints()
    }

    func messagesContraints() {
        NSLayoutConstraint.activate([textViewForMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)])
        NSLayoutConstraint.activate([textViewForMessage.rightAnchor.constraint(equalTo: view.rightAnchor)])
        NSLayoutConstraint.activate([textViewForMessage.heightAnchor.constraint(equalToConstant: 50)])
        NSLayoutConstraint.activate([textViewForMessage.widthAnchor.constraint(equalToConstant: 100)])
    }
    // Constraints
    func footerConstraints()  {
        
        // Separator
        NSLayoutConstraint.activate([separatorForTextField.bottomAnchor.constraint(equalTo: footerUIView.topAnchor)])
        NSLayoutConstraint.activate([separatorForTextField.widthAnchor.constraint(equalTo: view.widthAnchor)])
        NSLayoutConstraint.activate([separatorForTextField.heightAnchor.constraint(equalToConstant: 2)])
        
        // FooterView
        NSLayoutConstraint.activate([footerUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        NSLayoutConstraint.activate([footerUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        NSLayoutConstraint.activate([footerUIView.heightAnchor.constraint(equalToConstant: 50)])
        NSLayoutConstraint.activate([footerUIView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        
        // Add Subview for footer
        footerUIView.addSubview(viewTextMessage)
        footerUIView.addSubview(sendButton)
        
        // TextField
        NSLayoutConstraint.activate([viewTextMessage.centerXAnchor.constraint(equalTo: footerUIView.centerXAnchor)])
        NSLayoutConstraint.activate([viewTextMessage.centerYAnchor.constraint(equalTo: footerUIView.centerYAnchor)])
        NSLayoutConstraint.activate([viewTextMessage.leftAnchor.constraint(equalTo: footerUIView.leftAnchor)])
        NSLayoutConstraint.activate([viewTextMessage.widthAnchor.constraint(equalTo: footerUIView.widthAnchor, multiplier: 0.8)])
        NSLayoutConstraint.activate([viewTextMessage.heightAnchor.constraint(equalTo: footerUIView.heightAnchor)])
        
        // Send Button
        NSLayoutConstraint.activate([sendButton.centerYAnchor.constraint(equalTo: footerUIView.centerYAnchor)])
        NSLayoutConstraint.activate([sendButton.rightAnchor.constraint(equalTo: footerUIView.rightAnchor)])
        NSLayoutConstraint.activate([sendButton.leftAnchor.constraint(equalTo: viewTextMessage.rightAnchor)])
        NSLayoutConstraint.activate([sendButton.heightAnchor.constraint(equalTo: footerUIView.heightAnchor)])
 
    }
    
    @objc func backButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
