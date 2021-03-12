//
//  WalletCell.swift
//  Big Daddy
//
//  Created by Technomads on 22/02/21.
//

import UIKit

class WalletCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var statusIndicatorImageView: UIImageView!
    @IBOutlet weak var btnViewMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        btnViewMore.setHyperLink()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
}
