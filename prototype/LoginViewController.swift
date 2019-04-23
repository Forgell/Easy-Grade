//
//  LoginViewController.swift
//  prototype
//
//  Created by Baxter, Preston L on 4/23/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var student = Student()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if let uname = usernameTextField.text{
            if let pass = passwordTextField.text{
                student.username = uname
                student.password = pass
            }
        }
        
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
}
