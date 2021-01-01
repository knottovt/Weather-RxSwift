//
//  WeatherTableHeaderView.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

class WeatherTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
    }

    func configure(weather:Weather?) {
        self.tempLabel.text = String(format: "%.1f", weather?.temperature?.temp ?? 0) + "°C"
        self.maxTempLabel.text = "H: " + String(format: "%.1f", weather?.temperature?.tempMax ?? 0) + "°C"
        self.minTempLabel.text = "L: " + String(format: "%.1f", weather?.temperature?.tempMin ?? 0) + "°C"
        
        if let conditionName = weather?.conditionName {
            if #available(iOS 13.0, *) {
                self.imageView.image = UIImage(systemName: conditionName)
            }else{
                self.imageView.image = UIImage(named: conditionName)
            }
        }else{
            self.imageView.image = nil
        }
    }
    
}
