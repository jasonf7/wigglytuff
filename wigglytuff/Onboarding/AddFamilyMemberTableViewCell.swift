//
//  AddFamilyMemberTableViewCell.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class AddFamilyMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var birthDateField: UITextField!
    @IBOutlet weak var memberIdField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstNameField.setupWithCustomStyle()
        lastNameField.setupWithCustomStyle()
        birthDateField.setupWithCustomStyle()
        memberIdField.setupWithCustomStyle()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
