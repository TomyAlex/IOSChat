//
//  ViewController.swift
//  Account
//
//  Created by George Alexandru Tomache on 12/11/17.
//  Copyright © 2017 George Alexandru Tomache. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    //MARK: Reference
    var refDatabase = Database.database().reference(fromURL: "https://chatios-f419d.firebaseio.com/")
    var refDatabaseChildUser = Database.database().reference(fromURL: "https://chatios-f419d.firebaseio.com/").child("Users")
    var refDatabeseChild : DatabaseReference!
    var userName : String?
    var arrayUsers = [User]()
    var cellID = "cellID"
    var segueID = "segueID"
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        // Register a custom Cell for TableView
        tableView.register(UserCell.self, forCellReuseIdentifier: self.cellID)

        
        if (Auth.auth().currentUser?.uid == nil) {
            // Presents loginViewController after waitUntilDone
            performSelector(onMainThread: #selector(handleLogOut), with: nil, waitUntilDone: false)
        }
        fetchUser()
    }
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
            if (Auth.auth().currentUser?.uid != nil) {
            self.refDatabeseChild = self.refDatabaseChildUser.child(Auth.auth().currentUser!.uid)

            self.refDatabeseChild.observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user that is login name and puts it at title
                let value = snapshot.value as? NSDictionary
                self.userName = value?["name"] as? String ?? ""
                self.navigationItem.title = self.userName
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //MAKR: ViewWillDissappear
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
    
    @objc func handleLogOut() {
        
        do {
            try Auth.auth().signOut()
        } catch let errorLogOut {
            print(errorLogOut)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    //MARK: 2 needed function
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID)
        
        let user = arrayUsers[indexPath.row]
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.email
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = UINavigationController(rootViewController: MessagesViewController())
       
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: Updata list of users and reload Data
    func fetchUser() {
        self.refDatabaseChildUser.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.arrayUsers.append(user)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
   
}

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
