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
        let loadURL = URL(string: "https://hac.friscoisd.org/HomeAccess/Account/LogOn?ReturnUrl=%2fHomeAccess%2fClasses%2fClasswork")
        webView.load(URLRequest(url: loadURL!))
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        LoginButton.loadingIndicator(true)
        notificationLabel.textColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(255), blue: CGFloat(0), alpha: CGFloat(255))
        notificationLabel.isHidden = false
        notificationLabel.text = "Establishing connection..."
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
            if shouldLoginOnLoad {
                login()
            } else {
                didLoadLoginPage = true
            }
            break
        case 1:
            if webView.url! == URL(string: "https://hac.friscoisd.org/HomeAccess/Classes/Classwork")! {
                notificationLabel.textColor = UIColor(displayP3Red: CGFloat(0), green: CGFloat(255), blue: CGFloat(0), alpha: CGFloat(255))
                notificationLabel.text = "Login Successful!"
                print("Login Success!")
                
                self.performSegue(withIdentifier: "MainView", sender: self)
            }else {
                notificationLabel.textColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(255))
                notificationLabel.text = "There was an error logging in."
                print("Error logging in")
                LoginButton.loadingIndicator(false)
                pageNumber = 1
            }
        default:
            print("Hello")
        }
        pageNumber = pageNumber + 1
    }
    
    func login() {
        notificationLabel.textColor = UIColor(displayP3Red: CGFloat(255), green: CGFloat(255), blue: CGFloat(0), alpha: CGFloat(255))
        notificationLabel.text = "Attempting Login..."
        webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_UserName\").value = \"" + Username.text! + "\"", completionHandler: nil)
        webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_Password\").value = \"" + Password.text! + "\"", completionHandler: nil)
        
        webView.evaluateJavaScript("document.getElementsByClassName(\"sg-button sg-logon-button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\")[0].click()", completionHandler: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainView") {
            let vc = segue.destination as! ViewController
            vc.webView = webView
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
