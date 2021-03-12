//
//  ParcelHeaderView.swift
//  Big Daddy
//
//  Created by Technomads on 23/02/21.
//

import UIKit

class ParcelHeaderView: UIView {

    @IBOutlet weak var btnUpload: UIControl!

    override func layoutSubviews() {
        super.layoutSubviews()
        btnUpload.drawDottedLine(.themeColor)
    }
}
