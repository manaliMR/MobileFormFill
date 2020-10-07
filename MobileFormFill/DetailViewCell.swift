//
//  DetailViewCell.swift
//  MobileFormFill
//
//  Created by Manali Rami on 2020-10-06.
//  Copyright © 2020 Manali Rami. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var skillSetText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
