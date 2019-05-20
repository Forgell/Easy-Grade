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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func loadClasses( using classes: [SchoolClass] ) {
        tableView.classes = classes
    }
}
