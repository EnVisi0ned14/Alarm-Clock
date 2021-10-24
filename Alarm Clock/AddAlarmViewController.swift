//
//  AddAlarmViewController.swift
//  Alarm Clock
//
//  Created by Michael Abrams on 10/23/21.
//

import UIKit

class AddAlarmViewController: UIViewController {

    var delegate : DataDelegate?
    
    let datePicker : UIDatePicker = {
        
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .inline
        datePicker.timeZone = TimeZone(abbreviation: "EST")
        
        return datePicker
    }()
    
    let timeLabel : UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = .white
        timeLabel.backgroundColor = .clear
        timeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        return timeLabel
    }()
    
    let datePickerView : UIView = {
        
        let datePickerView = UIView()
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.backgroundColor = #colorLiteral(red: 0.1304865842, green: 0.1244513565, blue: 0.1299529305, alpha: 1)
        
        return datePickerView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1254901961, blue: 0.1294117647, alpha: 1)
        view.addSubview(datePickerView)
        datePickerView.addSubview(datePicker)
        datePickerView.addSubview(timeLabel)
        
        timeLabel.text = "Time"
        
        datePickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        datePickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        datePickerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        datePickerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        timeLabel.leadingAnchor.constraint(equalTo: datePickerView.leadingAnchor, constant: 20).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: datePickerView.centerYAnchor).isActive = true
        
        
        
        datePicker.trailingAnchor.constraint(equalTo: datePickerView.trailingAnchor, constant: -10).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: datePickerView.centerYAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 10).isActive = true
        
        
        title = "Add Alarm"
        
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.view.tintColor = .orange
        
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonDidPress))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonDidPress))
        
        
    }
    
    @objc private func saveButtonDidPress() {
        
        
        let timeSaved = datePicker.date
        
        print(timeSaved)
        
        
        
        delegate?.saveData(date: timeSaved)
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @objc private func cancelButtonDidPress() {
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
