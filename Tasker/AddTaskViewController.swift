//
//  AddTaskViewController.swift
//  Tasker
//
//  Created by Ron Crisostomo on 3/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

	@IBOutlet weak var priorityInputField: UITextField!
	@IBOutlet weak var timeInputField: UITextField!
	@IBOutlet weak var dateInputField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		// TODO: Add another input field for 'timeInputFieldEnd'
		timeInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.time, target: self); // TODO: Change to timeInputFieldStart
		
		dateInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.date, target: self);
		priorityInputField.inputView = SelectOptionInputField(options: ["Low", "Medium", "High"], textField: priorityInputField);
		
		// TODO: Give initial displayed values in timeInputField and dateInputField
		// TODO: Need to find a way to dismiss the date picker fields
    }
	
	/**
		This function is invoked everytime an instance of `DateTimeInputField` is modified. This is tied to instances of `DateTimeInputField`
		Parameter sender - The `UIDatePicker` instance that was changed to trigger this method
	*/
	@objc func dateTimePickerValueChanged(sender: UIDatePicker){
		if(sender.datePickerMode == UIDatePicker.Mode.time){
			setTimeOnInputField(datePicker: sender)
		}else if(sender.datePickerMode == UIDatePicker.Mode.date){
			setDateOnInputField(datePicker: sender)
		}
	}
	
	func setDateOnInputField(datePicker: UIDatePicker){
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd/MM/yyyy"
		let selectedDate = dateFormatter.string(from: datePicker.date)
		dateInputField.text = selectedDate
	}
	
	func setTimeOnInputField(datePicker: UIDatePicker){
		
		// Splitting datePicker.date into individual components to obtain the time selected in the datePicker
		let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
		
		// Setting timeInputField to display the selected time
		let selectedTime = "\(components.hour!):\(components.minute!)"
		timeInputField.text = selectedTime
	}

}
