//
//  CalendarTableViewCell.swift
//  testCalendar
//
//  Created by Sudipta Biswas on 08/07/20.
//  Copyright © 2020 Sudipta Biswas. All rights reserved.
//

import UIKit

protocol calendarProtocol {
    func didSelectCalendar(objCalendarUnit:calendarUnit)
}
class CalendarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var calenarCollectionView: UICollectionView!
    @IBOutlet weak var lblTopHeader: UILabel!
    private let calendarCellIdentifier = "calendarItemIdentifier"
    private let cellNibName = "CalendarCell"
    var delegate:calendarProtocol?
    
    enum WeekDay:String {
        case sun = "sun"
        case mon = "mon"
        case tuesday = "tue"
        case wednesday = "wed"
        case thursday = "thu"
        case friday = "fri"
        case saturday = "sat"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        calenarCollectionView.register(UINib.init(nibName: cellNibName, bundle: Bundle.main), forCellWithReuseIdentifier: calendarCellIdentifier)
        self.calenarCollectionView.delegate = self
        self.calenarCollectionView.dataSource = self
        self.calenarCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func prepareCurrentMonthAndReload() {
        if(CalendarSource.shared.prepareCurrentMonth().count > 0) {
            self.updateCalendar()
        }
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        if(CalendarSource.shared.preparePreviousMonth().count > 0) {
            self.updateCalendar()
        }
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        if(CalendarSource.shared.prepareNextMonth().count > 0) {
            self.updateCalendar()
        }
    }
    
    // MARK:- Update Calendar UI with Month data
    @objc private func updateCalendar() {
        let objMonthitem = CalendarSource.shared.monthData.first!
        self.lblTopHeader.text = "\(objMonthitem.month) \(objMonthitem.year)"
        self.prepareMonthDatatoLoadInCalendar()
    }
    
    private func prepareMonthDatatoLoadInCalendar() {
        let objMonthitem = CalendarSource.shared.monthData.first!
        if objMonthitem.dayName.lowercased() == WeekDay.sun.rawValue  {
            
        } else if objMonthitem.dayName.lowercased() == WeekDay.mon.rawValue {
            let objcalendarUnit = calendarUnit()
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
        } else if objMonthitem.dayName.lowercased() == WeekDay.tuesday.rawValue {
            let objcalendarUnit = calendarUnit()
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
        } else if objMonthitem.dayName.lowercased() == WeekDay.wednesday.rawValue {
            let objcalendarUnit = calendarUnit()
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
        } else if objMonthitem.dayName.lowercased() == WeekDay.thursday.rawValue {
            let objcalendarUnit = calendarUnit()
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
        } else if objMonthitem.dayName.lowercased() == WeekDay.friday.rawValue {
            let objcalendarUnit = calendarUnit()
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
        } else if objMonthitem.dayName.lowercased() == WeekDay.saturday.rawValue {
            //let objcalendarUnit = calendarUnit()
            /*CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)
            CalendarSource.shared.monthData.insert(objcalendarUnit, at: 0)*/
        }
        self.calenarCollectionView.reloadData()
    }
    
}

extension CalendarTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarSource.shared.monthData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calendarCellIdentifier, for: indexPath) as! CalendarCell
        cell.day.text = CalendarSource.shared.monthData[indexPath.item].day
        cell.day.textAlignment = .center
        if CalendarSource.shared.monthData[indexPath.item].day == "" {
            cell.lblAppointment.isHidden = true
        } else {
            cell.lblAppointment.isHidden = false
        }
        
        if let _selectedItem = CalendarSource.shared.selectedCalendarUnit {
            if _selectedItem === CalendarSource.shared.monthData[indexPath.item] {
                cell.day.layer.cornerRadius =  cell.day.frame.size.width / 2
                cell.day.layer.masksToBounds = true
                cell.day.backgroundColor = UIColor.red
                cell.day.textColor = UIColor.white
            } else {
                cell.day.layer.cornerRadius =  cell.day.frame.size.width / 2
                cell.day.layer.masksToBounds = true
                cell.day.backgroundColor = UIColor.clear
                cell.day.textColor = UIColor.black
            }
        } else {
            cell.day.layer.cornerRadius =  cell.day.frame.size.width / 2
            cell.day.layer.masksToBounds = true
            cell.day.backgroundColor = UIColor.clear
            cell.day.textColor = UIColor.black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objSelectedItem = CalendarSource.shared.monthData[indexPath.item]
        CalendarSource.shared.selectedCalendarUnit = objSelectedItem
        self.calenarCollectionView.reloadData()
        self.delegate?.didSelectCalendar(objCalendarUnit: objSelectedItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/8, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
