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
    
    init(name: String, grade: String, assignments: [Assignment]){
        self.name = name
        if let g = Double(grade){
            self.grade = g
        }else{
            self.grade = 0.0
        }
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
    
    init(score: String, maxPoints:String, type:String, dueDate:String, dateAssigned:String, name:String){
        if let temp_score = Double(score){
            self.score = temp_score
        }else{
            self.score = 0.0
        }
        if let temp_max = Double(maxPoints){
            self.maxPoints = temp_max
        }else{
            self.maxPoints = 0.0
        }
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
