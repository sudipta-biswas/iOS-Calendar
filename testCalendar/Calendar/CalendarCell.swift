//
//  CalendarCell.swift
//  testCalendar
//
//  Created by Sudipta Biswas on 08/07/20.
//  Copyright © 2020 Sudipta Biswas. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var lblAppointment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblAppointment.layer.cornerRadius = self.lblAppointment.frame.width / 2.0
        self.lblAppointment.layer.masksToBounds = true
    }
}
