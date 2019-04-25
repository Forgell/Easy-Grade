//
//  ViewController.swift
//  prototype
//
//  Created by Qualan Bradford on 9/18/18.
//  Copyright © 2018 Qualan Bradford. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController , WKNavigationDelegate{

    @IBOutlet var webView: WKWebView!
    var pageNumber = 0
    var rawHtml = ""
    var classes: [SchoolClass] = []
    var classLength = -1
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        //webView.uiDelegate = self
        view = webView
        webView.navigationDelegate = self
        pageNumber = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://hac.friscoisd.org/HomeAccess/Account/LogOn?ReturnUrl=%2fhomeaccess")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //var completionHandler: (() -> Void)? { get set }.
        /*while(webView.isLoading){
            sleep(1)
            print("yo")
        }*/
        
        /*if(!webView.isLoading){
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_UserName\").value = \"Bradford.Q.T\"", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_Password\").value = \"famoustrumpet1\"", completionHandler: nil)
                print("\n\nmade it \n\n")
        }*/
        
        
        
    
        
        // webVeiw.
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded \(pageNumber)")
        switch(pageNumber){
        case 0:
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_UserName\").value = \"Bradford.Q.T\"", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementById(\"LogOnDetails_Password\").value = \"famoustrumpet1\"", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementsByClassName(\"sg-button sg-logon-button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\")[0].click()" , completionHandler: nil)
            break
        case 1:
            webView.evaluateJavaScript("window.location = \"https://hac.friscoisd.org/HomeAccess/Content/Student/Assignments.aspx\"", completionHandler: nil)
        case 2:
            scrapeHTML()
            loadClasses()

        default:
            print("opps default line 63")
        }
        
        pageNumber += 1
        
        
        
        //print("\n\nmade it \n\n")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrapeHTML(){
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, error: Error?) in
                                    //print(html)
                                    self.rawHtml = html as! String
                                    //print(self.rawHtml)
        })
    }
    
    func loadClasses(){
        webView.evaluateJavaScript("document.getElementsByClassName(\"AssignmentClass\").length") { (innerText, error) in
            //let classTable = innerText as? String
            print(innerText!)
        }
        
        
    }


}

    


