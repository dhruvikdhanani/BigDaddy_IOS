//
//  ParcelDetailCell.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class ParcelDetailCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var txtTotalKG: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        txtTotalKG.dropShadowed(cornerRadius: 5, borderColor: .clear, borderWidth: 0, shadowColor: .lightGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
