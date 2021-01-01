//
//  WeatherTableFooterView.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

class WeatherTableFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var timeLabel:UILabel!
    
    func configure(weather:Weather?) {
        self.timeLabel.text = "Time of data: " + (weather?.dataTime?.toString(withFormat: "HH:mm") ?? "--:--")
    }
    
}
