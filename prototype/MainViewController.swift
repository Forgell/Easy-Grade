//
//  MainViewController.swift
//  prototype
//
//  Created by Hardy, Justin E on 5/16/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: ClassTableView!
    @IBOutlet weak var nameLabel: UILabel!
    var student: Student? = nil
    var studentName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = studentName
        if let student = student {
            tableView.student = student
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "MainView" ) {
            let vc = segue.source as? LogInViewController
            studentName = (vc?.studentName)!
            print("Name set")
        }
    }
}
