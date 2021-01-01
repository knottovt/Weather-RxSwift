//
//  SunRiseSunSetTableViewCell.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

class SunRiseSunSetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sunRiseLabel:UILabel!
    @IBOutlet weak var sunSetLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(weather:Weather?) {
        self.sunRiseLabel.text = weather?.sys?.sunRise?.toString(withFormat: "HH:mm") ?? "--:--"
        self.sunSetLabel.text = weather?.sys?.sunSet?.toString(withFormat: "HH:mm") ?? "--:--"
    }
    
}
