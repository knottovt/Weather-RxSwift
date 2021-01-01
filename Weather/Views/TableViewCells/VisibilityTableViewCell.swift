//
//  VisibilityTableViewCell.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

class VisibilityTableViewCell: UITableViewCell {

    @IBOutlet weak var visibilityLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(weather:Weather?) {
        if let visibility = weather?.visibility {
            self.visibilityLabel.text = String(format: "%.1f", visibility / 1000.0) + " km"
        }else{
            self.visibilityLabel.text = "-- km"
        }
    }
    
}
