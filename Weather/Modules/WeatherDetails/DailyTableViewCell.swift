//
//  DailyTableViewCell.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var dayDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        pressure.text = ""
        temp.text = ""
        dayDate.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
