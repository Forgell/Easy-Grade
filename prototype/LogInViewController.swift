//
//  LogInViewController.swift
//  prototype
//
//  Created by Harp, Garret C on 5/2/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    //@IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "MainView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainView") {
            let vc = segue.destination as! ViewController
            vc.username = Username.text!
            vc.password = Password.text!
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
