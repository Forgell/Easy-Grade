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
            loadClasses(view: view)
            getName(view: view)
        } else {
            self.performSegue(withIdentifier: "Login", sender: nil)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadClasses(view: WKWebView){
        view.evaluateJavaScript("function getClassesText(){ var frame = document.getElementsByClassName(\"sg-legacy-iframe\")[0].contentDocument.getElementsByClassName(\"AssignmentClass\"); var obj = {}; for(var i = 0; i < frame.length; i++){ var className = frame[i].getElementsByClassName(\"sg-header-heading\")[0].innerText; obj[className] = []; var assignments = frame[i].getElementsByClassName(\"sg-asp-table-data-row\"); for (var x = 0; x < assignments.length; x++) { let assignmentTable = assignments[x].getElementsByTagName(\"TD\"); let assignment = { \"Due\": assignmentTable[0].innerText, \"Name\": assignmentTable[2].innerText, \"Category\": assignmentTable[3].innerText, \"Score\": assignmentTable[4].innerText, \"TotalPossible\": assignmentTable[5].innerText, }; if(assignment.Due !== \"Daily\" && assignment.Due !== \"Minor Grades\" && assignment.Due !== \"Major Grades\") { obj[className].push(assignment); } } } return obj; } getClassesText()") { (innerText, error) in
            let classTable = innerText as? [String: [AnyObject]]
                if let classes = classTable {
                    for (className, assignments) in classes {
                        print("Class Name: \(className)")
                        print("Assignments amount: \(assignments.count)")
                        
                        for assignment in assignments {
                            print(assignment)
                        }
                    }
                } else {
                    self.performSegue(withIdentifier: "Login", sender: nil)
                }
            }
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
