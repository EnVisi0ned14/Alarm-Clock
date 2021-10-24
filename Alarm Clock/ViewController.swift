//
//  ViewController.swift
//  Alarm Clock
//
//  Created by Michael Abrams on 10/23/21.
//

import UIKit
import UserNotifications


protocol DataDelegate {
    func saveData(date : Date)
}


class ViewController: UIViewController, DataDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var timeData = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(UINib(nibName: "TimeTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeTableViewCell")
        
        
        
        view.backgroundColor = .black
        title = "Alarm"
        navigationController?.navigationBar.barTintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonDidPress))
        
        
        
    }
    
    func saveData(date: Date) {

        self.timeData.append(date)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                self.timeData.append(date)
//
//                //self.scheduleAlarm(date: date)
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            } else if let error = error {
//                print("error occured: \(error)")
//            }
//        }
    }
    
//    func scheduleAlarm(date : Date) {
//        let content = UNMutableNotificationContent()
//        content.title = "Alarm Clock"
//        content.sound = .some(UNNotificationSound(named: UNNotificationSoundName(rawValue: "CauseYouHadABadDay.aiff")))
//        content.body = "Are you having a bad day?"
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute, .second], from: date), repeats: false)
//
//        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if error != nil {
//                print("Something went wrong")
//            }
//        }
//    }
    
    
    @objc private func buttonDidPress() {
        

        
        let rootVC = self.storyboard!.instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        rootVC.delegate = self
        let navController = UINavigationController(rootViewController: rootVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.present(navController, animated:true, completion: nil)
        
        
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(timeData.count == 0) {
            return 0
        }
        
        return timeData.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(timeData.count == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = "Hello World"
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell", for: indexPath) as! TimeTableViewCell
        
        cell.configure(date: timeData[indexPath.row])
        
        return cell
    }
    
    
    
    
}

