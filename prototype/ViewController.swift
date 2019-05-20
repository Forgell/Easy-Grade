//
//  ViewController.swift
//  prototype
//
//  Created by Qualan Bradford on 9/18/18.
//  Copyright © 2018 Qualan Bradford. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class ViewController: UIViewController , WKNavigationDelegate{
    
    var webView: WKWebView?
    var pageNumber = 0
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = webView {
            //loadClasses(view: view)
            getName(view: view)
        } else {
            self.performSegue(withIdentifier: "Login", sender: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getName(view: WKWebView) {
        view.evaluateJavaScript("document.getElementsByClassName(\"sg-menu-element-identity\")[0].innerText") { (innerText, error) in
            let hacName = innerText as? String
            if let name = hacName {
                self.nameLabel.text = name
            } else {
                self.nameLabel.text = "User"
            }
        }
    }

}
