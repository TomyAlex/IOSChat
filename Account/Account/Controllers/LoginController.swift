//
//  LoginController.swift
//  Account
//
//  Created by George Alexandru Tomache on 12/11/17.
//  Copyright © 2017 George Alexandru Tomache. All rights reserved.
//

import UIKit
import Firebase

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

class LoginController: UIViewController {
    
    var ref : DatabaseReference!
    
    //MARK: Declaring new Elements
    lazy var profileImageView : UIImageView = {
        // ImageView profile avatar
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageViewSelection)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var segmentControlLoginRegister : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        sc.layer.cornerRadius = 5
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(changeToLoginMode), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let inputsContainerView : UIView = {
        // Create a new element
        // UIView element
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    let nameTextField : UITextField = {
        // Name cell for TableView
        let name = UITextField()
        name.placeholder = "Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let nameSeparatorTableView : UIView = {
        // A separator between name TextField and email TextField
        let separator = UIView()
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let emailTextField : UITextField = {
        // Email TextField
        let email = UITextField()
        email.placeholder = "Email"
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let emailSeparatorTableView : UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let passwordTextField : UITextField = {
        // Password TextField
        let password = UITextField()
        password.placeholder = "Password"
        password.translatesAutoresizingMaskIntoConstraints = false
        password.isSecureTextEntry = true
        return password
    }()
 
    lazy var registerButton : UIButton = {
        // Register button
        let button = UIButton(type : .system)
        button.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    //MARK: Views
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor  = UIColor(r: 61, g: 155, b: 151)
        // Add the element as subView
       
        view.addSubview(profileImageView)
        view.addSubview(segmentControlLoginRegister)
        view.addSubview(inputsContainerView)
        view.addSubview(registerButton)

        // Setup constraint for each element
        setupConstraintsImageView()
        setupConstraintsSegmentControl()
        setupConstraintsView()
        setupConstraintsRegisterButton()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // Status Bar color elements
        return .lightContent
    }
    
    //MARK: Constraints
    func setupConstraintsImageView() {
        // ImageView profile avatar -> Constraint
        NSLayoutConstraint.activate([profileImageView.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor)])
        NSLayoutConstraint.activate([profileImageView.bottomAnchor.constraint(equalTo: segmentControlLoginRegister.topAnchor, constant: -36)])
        NSLayoutConstraint.activate([profileImageView.widthAnchor.constraint(equalToConstant: 100)])
        NSLayoutConstraint.activate([profileImageView.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    func setupConstraintsSegmentControl() {
        //  Segment Control -> Login/Register Constraints
        NSLayoutConstraint.activate([segmentControlLoginRegister.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor)])
        NSLayoutConstraint.activate([segmentControlLoginRegister.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8)])
        NSLayoutConstraint.activate([segmentControlLoginRegister.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor)])
        NSLayoutConstraint.activate([segmentControlLoginRegister.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -16)])
    }
    //MARK: Constraint that will be changed depending of witch segmentControl is selected
    var constraintViewHeightAnchor : NSLayoutConstraint?
    var nameTextFieldMultiplierAnchor : NSLayoutConstraint?
    var separatorNameEmailConstantAnchor : NSLayoutConstraint?
    var emailTextFieldMultiplierAnchor : NSLayoutConstraint?
    var passwordTextFieldMultiplierAnchor : NSLayoutConstraint?
    func setupConstraintsView() {
        // Add constraint to the new element
        // UIView  -> Constraint
        NSLayoutConstraint.activate([inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        NSLayoutConstraint.activate([inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        NSLayoutConstraint.activate([inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)])
        constraintViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([constraintViewHeightAnchor!])
  
        
        // Setup cell in TableView -> Constraints
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorTableView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorTableView)
        inputsContainerView.addSubview(passwordTextField)
        
        // Name Cell
        NSLayoutConstraint.activate([nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor)])
        NSLayoutConstraint.activate([nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12)])
        NSLayoutConstraint.activate([nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor)])
        nameTextFieldMultiplierAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        NSLayoutConstraint.activate([nameTextFieldMultiplierAnchor!])
        
        // A separator between name TextField and email TextField
        NSLayoutConstraint.activate([nameSeparatorTableView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor)])
        NSLayoutConstraint.activate([nameSeparatorTableView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor)])
        NSLayoutConstraint.activate([nameSeparatorTableView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor)])
        separatorNameEmailConstantAnchor = nameSeparatorTableView.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([separatorNameEmailConstantAnchor!])
        
        // Email Cell
        NSLayoutConstraint.activate([emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor)])
        NSLayoutConstraint.activate([emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12)])
        NSLayoutConstraint.activate([emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor)])
        emailTextFieldMultiplierAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        NSLayoutConstraint.activate([emailTextFieldMultiplierAnchor!])
        
        // A separator between email TextField and password TextField
        NSLayoutConstraint.activate([emailSeparatorTableView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor)])
        NSLayoutConstraint.activate([emailSeparatorTableView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor)])
        NSLayoutConstraint.activate([emailSeparatorTableView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor)])
        NSLayoutConstraint.activate([emailSeparatorTableView.heightAnchor.constraint(equalToConstant: 1)])
        
        // Password Cell
        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: emailSeparatorTableView.bottomAnchor)])
        NSLayoutConstraint.activate([passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12)])
        NSLayoutConstraint.activate([passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor)])
        passwordTextFieldMultiplierAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        NSLayoutConstraint.activate([passwordTextFieldMultiplierAnchor!])
    }
    
    func setupConstraintsRegisterButton() {
        // Register Button -> Constraint
        NSLayoutConstraint.activate([registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        NSLayoutConstraint.activate([registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 16)])
        NSLayoutConstraint.activate([registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor)])
        NSLayoutConstraint.activate([registerButton.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    //MARK: LogIn and Register transition
    @objc func handleLoginRegister() {
        if (segmentControlLoginRegister.selectedSegmentIndex == 0) {
            loginButton()
        } else {
            registerUserButton()
        }
    }
    
    @objc func loginButton() {
        guard let password = passwordTextField.text, let email = emailTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error != nil) {
                print(error!)
                return
            }
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    // Change Elements Constraints depending on witch segment is selected
    @objc func changeToLoginMode() {
        // Function for Segment Control, swich elements from screen
        let logInButton = segmentControlLoginRegister.titleForSegment(at: segmentControlLoginRegister.selectedSegmentIndex)
        registerButton.setTitle(logInButton, for: .normal)
        
        // Change UIView height using tertiar function
        constraintViewHeightAnchor?.constant = segmentControlLoginRegister.selectedSegmentIndex == 0 ? 100 : 150
        
        /* Erase name Text Field or add it to UIView depending wich button from
         SegmentControl is selected*/
        NSLayoutConstraint.deactivate([nameTextFieldMultiplierAnchor!])
        nameTextFieldMultiplierAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: segmentControlLoginRegister.selectedSegmentIndex == 0 ? 0 : 1/3)
        NSLayoutConstraint.activate([nameTextFieldMultiplierAnchor!])
        
        // Resize email, password  TextFields and the separator between name TextField and email TextField on Login Mode
        // Separator between name TextField and email TextField
        NSLayoutConstraint.deactivate([separatorNameEmailConstantAnchor!])
        separatorNameEmailConstantAnchor = nameSeparatorTableView.heightAnchor.constraint(equalToConstant: segmentControlLoginRegister.selectedSegmentIndex == 0 ? 0 : 1)
        NSLayoutConstraint.activate([separatorNameEmailConstantAnchor!])
        
        // Email
        NSLayoutConstraint.deactivate([emailTextFieldMultiplierAnchor!])
        emailTextFieldMultiplierAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: segmentControlLoginRegister.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        NSLayoutConstraint.activate([emailTextFieldMultiplierAnchor!])
        
        // Password
        NSLayoutConstraint.deactivate([passwordTextFieldMultiplierAnchor!])
        passwordTextFieldMultiplierAnchor =  passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: segmentControlLoginRegister.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        
        profileImageView.isUserInteractionEnabled = segmentControlLoginRegister.selectedSegmentIndex == 0 ? false : true
    }
}
