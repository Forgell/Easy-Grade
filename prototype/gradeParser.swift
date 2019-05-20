//
//  gradeParser.swift
//  prototype
//
//  Created by Baxter, Preston L on 5/16/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import Foundation

class gradeParser{
    
    var classes: [String]
    var student: Student
    
    init(classes: [String]){
        self.classes = classes
        self.student = Student()
    }
    
    func parse(){
        for section in classes {
            var lineItems = section.split(separator: "\n")
            let classLine = String(lineItems.remove(at: 0))
            lineItems.remove(at: 0)
            
            let classNameStart = classLine.firstIndex(of: "-")!
            let classNameEnd = classLine.firstIndex(of: "(")!
            let range = classNameStart..<classNameEnd
            
            let className = classLine[range]
            
            let index = classLine.index(classLine.endIndex, offsetBy: -6)
            let grade = classLine.suffix(from: index)
            
            var assignments: [Assignment] = []
            for line in lineItems{
                var items = line.split(separator: "\t")
                if items.count == 6 {
                assignments.append(Assignment(score: String(items[4]), maxPoints: String(items[5]), type: String(items[3]), dueDate: String(items[0]), dateAssigned: String(items[1]), name: String(items[2])))
                }else{
                    assignments.append(Assignment(score: "0.0", maxPoints: String(items[4]), type: String(items[3]), dueDate: String(items[0]), dateAssigned: String(items[1]), name: String(items[2])))
                }
            }
            
            student.sections.append(Section(name: String(className), grade: String(grade), assignments: assignments))
            
        }
    }
    
}
