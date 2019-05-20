//
//  ClassTableView.swift
//  prototype
//
//  Created by Hardy, Justin E on 5/6/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import UIKit

class ClassTableView: UITableView {
    var student: Student = Student()
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        let cell = dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ClassTableViewCell
        
        // Configure cell
        let _class = student.sections[indexPath.row]
        cell.update(with: _class)
        cell.showsReorderControl = false
        
        return cell
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return numberOfRows(inSection: 0)
    }
    
}
