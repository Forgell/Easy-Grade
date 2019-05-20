//
//  ClassTableViewCell.swift
//  prototype
//
//  Created by Hardy, Justin E on 5/6/19.
//  Copyright © 2019 Qualan Bradford. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    func update( with _class: SchoolClass ) {
        // Code to fill labels with class information
    }
}
