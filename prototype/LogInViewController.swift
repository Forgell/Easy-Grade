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
    @IBOutlet weak var LoginButton: UIButton!
    
    var webView: WKWebView!
    var didLoadLoginPage = false
    var shouldLoginOnLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.loadingIndicator(false)
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
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        LoginButton.loadingIndicator(true)
        if didLoadLoginPage {
            login()
        } else {
            shouldLoginOnLoad = true
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
                loadClasses()
                loginButton.isEnabled = true
                self.performSegue(withIdentifier: "MainView", sender: self)
            }else {
                notificationLabel.textColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(255))
                notificationLabel.text = "There was an error logging in."
                print("Error logging in")
                loginButton.isEnabled = true
            }
        case 2:
            self.performSegue(withIdentifier: "MainView", sender: nil)
        default:
            print("Hello")
        }
        pageNumber = pageNumber + 1
    }
    
    func login() {
        webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_UserName\").value = \"" + Username.text! + "\"", completionHandler: nil)
        webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_Password\").value = \"" + Password.text! + "\"", completionHandler: nil)
        
        webView.evaluateJavaScript("document.getElementsByClassName(\"sg-button sg-logon-button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\")[0].click()", completionHandler: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainView") {
            let vc = segue.destination as! ViewController
            vc.viewFromLogin = webView
        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
