//
//  ParcelHeaderView.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class ParcelHeaderView: UIView {

    @IBOutlet weak var btnUpload: UIControl!

    override func layoutSubviews() {
        super.layoutSubviews()
        btnUpload.drawDottedLine(.themeColor)
    }
}
