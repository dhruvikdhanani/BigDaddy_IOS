//
//  FileCell.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class FileCell: UITableViewCell {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var fileTypeImageView: UIImageView!
    @IBOutlet weak var lblFileName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
    
}
