//
//  ParcelFooterView.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class ParcelFooterView: UIView {

    @IBOutlet weak var btnAddMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAddMore.setHyperLink()
    }

}
