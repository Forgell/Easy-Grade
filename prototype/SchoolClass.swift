//
//  SchoolClass.swift
//  prototype
//
//  Created by Qualan Bradford on 9/19/18.
//  Copyright © 2018 Qualan Bradford. All rights reserved.
//

import Foundation

class SchoolClass{
    public var grades : [Assignment] = []
    var length: Int
    
    init(length:Int){
        self.length = length
    }
    
    func setClass(index:Int , grade:Assignment){
        grades[index] = grade
    }
    
    
}

class Assignment{
    var score : Int
    var maxPoints: Int
    var type: String
    var dueDate: String
    var dateAssigned: String
    var name: String
    
    init(score:Int , maxPoints:Int , type:String , dueDate:String, dateAssigned:String , name:String){
        self.score = score
        self.maxPoints = maxPoints
        self.type = type
        self.dueDate = dueDate
        self.dateAssigned = dateAssigned
        self.name = name
    }
    
    init(){
        self.score = 0
        self.maxPoints = 0
        self.type = ""
        self.dueDate = ""
        self.dateAssigned = ""
        self.name = ""
        
    }
}
