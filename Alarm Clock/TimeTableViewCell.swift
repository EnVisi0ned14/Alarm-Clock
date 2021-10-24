//
//  TimeTableViewCell.swift
//  Alarm Clock
//
//  Created by Michael Abrams on 10/23/21.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var pmAmTextLabel: UILabel!
    
    var date : Date?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure (date : Date) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        self.date = date
        
        let time = formatter.string(from: date)
        
        var timeList = time.components(separatedBy: " ")
        
        timeList.removeFirst()
        
        timeTextLabel.text = timeList[0]
        pmAmTextLabel.text = timeList[1]
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                if let safeDate = self.date {
                        self.scheduleAlarm(date: safeDate)
                }
            } else if let error = error {
                print("error occured: \(error)")
            }
        }
        
    }
    
    @IBAction func switchDidPress(_ sender: UISwitch) {

        if(sender.isOn) {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    if let safeDate = self.date {
                            self.scheduleAlarm(date: safeDate)
                    }
                } else if let error = error {
                    print("error occured: \(error)")
                }
            }
        } else if (!sender.isOn) {
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
        }
    }
    
    func scheduleAlarm(date : Date) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm Clock"
        content.sound = .some(UNNotificationSound(named: UNNotificationSoundName(rawValue: "CauseYouHadABadDay.aiff")))
        content.body = "Are you having a bad day?"

        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute, .second], from: date), repeats: false)

        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("Something went wrong")
            }
        }
    }
    
}
