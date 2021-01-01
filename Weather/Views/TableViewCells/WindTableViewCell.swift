//
//  WindTableViewCell.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

class WindTableViewCell: UITableViewCell {

    @IBOutlet weak var windSpeedLabel:UILabel!
    @IBOutlet weak var windDegreeLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(weather:Weather?) {
        if let speed = weather?.wind?.speed {
            self.windSpeedLabel.text = String(speed) + " km/hr"
        }else{
            self.windSpeedLabel.text = "-- km/hr"
        }
        
        if let degree = weather?.wind?.degree {
            self.windDegreeLabel.text = String(degree) + "°"
        }else{
            self.windDegreeLabel.text = "--°"
        }
        
    }
    
}
