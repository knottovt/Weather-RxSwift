//
//  PressureTableViewCell.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

class PressureTableViewCell: UITableViewCell {

    @IBOutlet weak var precipitationLabel:UILabel!
    @IBOutlet weak var pressureLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(weather:Weather?) {
        if let precipitation = weather?.precipitation {
            self.precipitationLabel.text = String(precipitation) + " mm"
        }else{
            self.precipitationLabel.text = "-- mm"
        }
        
        if let pressure = weather?.temperature?.pressure {
            self.pressureLabel.text = String(pressure) + " hPa"
        }else{
            self.pressureLabel.text = "-- hPa"
        }
    }
    
}
