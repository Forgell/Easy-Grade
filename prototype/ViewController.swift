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
    
    var viewFromLogin: WKWebView?

    @IBOutlet var webView: WKWebView!
    var pageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = viewFromLogin
        loadClasses()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadClasses(){
        webView.evaluateJavaScript("function getClassesText(){var length = document.getElementsByClassName(\"AssignmentClass\").length; var arr = []; for(var i = 0; i < length; i++){arr.push(document.getElementsByClassName(\"AssignmentClass\")[i].innerText);} return arr;} getClassesText()") { (innerText, error) in
                let classTable = innerText as? [String]
                if let classTable = classTable {
                    classTable.forEach({ (ClassItem) in
                        print(ClassItem)
                    })
                }
            }
    }

}
