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
    
    var username: String?
    var password: String?

    @IBOutlet var webView: WKWebView!
    var pageNumber = 0
    //var classes: [SchoolClass] = []
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
        webView.navigationDelegate = self
        pageNumber = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://hac.friscoisd.org/HomeAccess/Account/LogOn?ReturnUrl=%2fhomeaccess")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded \(pageNumber)")
        switch(pageNumber){
        case 0:
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_UserName\").value = \"" + username! + "\"", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_Password\").value = \"" + password! + "\"", completionHandler: nil)
            
            webView.evaluateJavaScript("document.getElementsByClassName(\"sg-button sg-logon-button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\")[0].click()", completionHandler: nil)
            break
        case 1:
            if webView.url! == URL(string: "https://hac.friscoisd.org/HomeAccess/Home/WeekView")! {
                webView.evaluateJavaScript("window.location = \"https://hac.friscoisd.org/HomeAccess/Content/Student/Assignments.aspx\"", completionHandler: nil)
            }else {
                print("Error logging in")
                self.performSegue(withIdentifier: "Login", sender: nil)
            }
            
        case 2:
            loadClasses()

        default:
            print("opps default line 63")
        }
        
        pageNumber += 1
        
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
