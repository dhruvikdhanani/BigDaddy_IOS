//
//  ParcelFooterView.swift
//  Big Daddy
//
//  Created by Technomads on 23/02/21.
//

import UIKit

class ParcelFooterView: UIView {

    @IBOutlet weak var btnAddMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAddMore.setHyperLink()
    }

}
