//
//  Studet.swift
//  prototype
//
//  Created by Baxter, Preston L on 4/23/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import Foundation

struct Student{

    var classes: [SchoolClass]
    var username: String
    //TODO: password -> passwordhash
    var password: String

    init(){
        classes = []
        username = ""
        password = ""
    }
}
