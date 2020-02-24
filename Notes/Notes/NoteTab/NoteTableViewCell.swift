//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Денис Домашевич on 2/23/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var colorView: ColorSquareView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
}
