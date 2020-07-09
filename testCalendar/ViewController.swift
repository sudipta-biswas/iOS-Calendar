//
//  ViewController.swift
//  testCalendar
//
//  Created by Sudipta Biswas on 08/07/20.
//  Copyright © 2020 Sudipta Biswas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableCalendar: UITableView!
    private var isCurrentMonthLoad = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableCalendar.register(UINib.init(nibName: "CalendarTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "calendarCellIdentifier")

        self.tableCalendar.delegate = self
        self.tableCalendar.dataSource = self
        self.tableCalendar.reloadData()
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 400.0
        } else {
            return 70.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCellIdentifier") as! CalendarTableViewCell
            cell.selectionStyle = .none
            if self.isCurrentMonthLoad == false {
                self.isCurrentMonthLoad = true
                cell.prepareCurrentMonthAndReload()
            }
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDateTimeContentIdentifier")
            return cell!
        }
    }
}

extension ViewController : calendarProtocol {
    func didSelectCalendar(objCalendarUnit: calendarUnit) {
        print("Selected Calendar Item : \(objCalendarUnit.day) - \(objCalendarUnit.month) - \(objCalendarUnit.year) - \(objCalendarUnit.dayName)")
        print("Date value : \(objCalendarUnit.dateString)")
    }
}

