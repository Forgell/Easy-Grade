//
//  SchoolClass.swift
//  prototype
//
//  Created by Qualan Bradford on 9/19/18.
//  Copyright © 2018 Qualan Bradford. All rights reserved.
//

import Foundation

class Student{
    var sections: [Section]
    
    init(){
        sections = []
    }
}

class Section{
    var name: String
    var grade: Double
    var assignments: [Assignment]
    
    init(){
        name = ""
        grade = 0.0
        assignments = []
    }
    
    init(name: String, grade: Double, assignments: [Assignment]){
        self.name = name
        self.grade = grade
        self.assignments = assignments
    }
}

class Assignment{
    var score: Double
    var maxPoints: Double
    var type: String
    var dueDate: String
    var dateAssigned: String
    var name: String
    
    init(score: Double, maxPoints:Double, type:String, dueDate:String, dateAssigned:String, name:String){
        self.score = score
        self.maxPoints = maxPoints
        self.type = type
        self.dueDate = dueDate
        self.dateAssigned = dateAssigned
        self.name = name
    }
    
    init(){
        self.score = 0.0
        self.maxPoints = 0.0
        self.type = ""
        self.dueDate = ""
        self.dateAssigned = ""
        self.name = ""
        
    }
}
