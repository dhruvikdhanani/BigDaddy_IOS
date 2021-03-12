//
//  OrderListCell.swift
//  Big Daddy
//
//  Created by Technomads on 17/02/21.
//

import UIKit

class OrderListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.bounds.inset(by: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
        contentView.cornerRadius = 8
        contentView.backgroundColor = UIColor.init(hexString: "f7f7f7")
    }
}
