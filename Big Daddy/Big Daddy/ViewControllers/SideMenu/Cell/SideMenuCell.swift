//
//  SideMenuCell.swift
//  Big Daddy
//
//  Created by Technomads on 16/02/21.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var symbolImageView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    }
    
}
