//
//  FeelsLikeTableViewCell.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

class FeelsLikeTableViewCell: UITableViewCell {

    @IBOutlet weak var feelsLikeLabel:UILabel!
    @IBOutlet weak var humidityLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(weather:Weather?) {
        self.feelsLikeLabel.text = String(format: "%.1f", weather?.temperature?.feelsLike ?? 0) + "°C"
        self.humidityLabel.text = String(weather?.temperature?.humidity ?? 0) + "%"
    }
    
}
