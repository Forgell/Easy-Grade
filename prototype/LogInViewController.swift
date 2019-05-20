//
//  LogInViewController.swift
//  prototype
//
//  Created by Harp, Garret C on 5/2/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import UIKit
import WebKit

class LogInViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    //@IBOutlet weak var LoginButton: UIButton!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        notificationLabel.isHidden = true
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        pageNumber = 0
        loginButton.isEnabled = false
        notificationLabel.textColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(255), blue: CGFloat(0), alpha: CGFloat(255))
        notificationLabel.isHidden = false
        notificationLabel.text = "Establishing connection..."
        let myURL = URL(string:"https://hac.friscoisd.org/HomeAccess/Account/LogOn?ReturnUrl=%2fhomeaccess")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "MainView" ){
            let vc = segue.destination as? MainViewController
            vc?.loadClasses(using: loadClasses())
            webView = nil
        }
    }
    
    var pageNumber = 0
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded page \(pageNumber)")
        switch(pageNumber){
        case 0:
            notificationLabel.textColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(255), blue: CGFloat(0), alpha: CGFloat(255))
            notificationLabel.text = "Attempting Login..."
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_UserName\").value = \"" + Username.text! + "\"", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_Password\").value = \"" + Password.text! + "\"", completionHandler: nil)
            
            webView.evaluateJavaScript("document.getElementsByClassName(\"sg-button sg-logon-button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\")[0].click()", completionHandler: nil)
            break
        case 1:
            if webView.url! == URL(string: "https://hac.friscoisd.org/HomeAccess/Home/WeekView")! {
                notificationLabel.textColor = UIColor(displayP3Red: CGFloat(0), green: CGFloat(255), blue: CGFloat(0), alpha: CGFloat(255))
                notificationLabel.text = "Login Successful!"
                print("Login Success!")
                webView.evaluateJavaScript("window.location = \"https://hac.friscoisd.org/HomeAccess/Content/Student/Assignments.aspx\"", completionHandler: nil)
                loginButton.isEnabled = true
                self.performSegue(withIdentifier: "MainView", sender: self)
                break
            }else {
                notificationLabel.textColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(255))
                notificationLabel.text = "There was an error logging in."
                print("Error logging in")
                loginButton.isEnabled = true
            }
        default:
            print("Hello")
        }
        pageNumber = pageNumber + 1
    }
    
    func loadClasses() -> [SchoolClass] {
        webView.evaluateJavaScript("function getClassesText(){var length = document.getElementsByClassName(\"AssignmentClass\").length; var arr = []; for(var i = 0; i < length; i++){arr.push(document.getElementsByClassName(\"AssignmentClass\")[i].innerText);} return arr;} getClassesText()") { (innerText, error) in
            let classTable = innerText as? [String]
            if let classTable = classTable {
                classTable.forEach({ (ClassItem) in
                    print(ClassItem)
                })
            }
        }
        return []
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
