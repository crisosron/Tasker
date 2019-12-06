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
	@IBOutlet weak var startTimeInputField: UITextField!
	@IBOutlet weak var endTimeInputField: UITextField!
	@IBOutlet weak var dateInputField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		startTimeInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.time, target: self, field: "startTime");
		endTimeInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.time, target: self, field:"endTime");
		dateInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.date, target: self, field: "date");
		priorityInputField.inputView = SelectOptionInputField(options: ["None", "Low", "Medium", "High"], textField: priorityInputField);
		
		let toolBar = UIToolbar().createToolBar(selector: #selector(doneButtonOnDatePickerPressed(sender:)))
		startTimeInputField.inputAccessoryView = toolBar
		endTimeInputField.inputAccessoryView = toolBar
		dateInputField.inputAccessoryView = toolBar
		
		// TODO: Give initial displayed values in timeInputField and dateInputField
		// TODO: Need to find a way to dismiss the date picker fields
    }
	
	//MARK: Selector functions
	/**
	* This function is invoked everytime an instance of `DateTimeInputField` is modified. This is tied to instances of `DateTimeInputField`
	* Parameter sender: The `UIDatePicker` instance that was changed to trigger this method
	*/
	@objc func dateTimePickerValueChanged(sender: DateTimeInputField){
		if(sender.datePickerMode == UIDatePicker.Mode.time){
			setTimeOnInputField(datePicker: sender)
		}else if(sender.datePickerMode == UIDatePicker.Mode.date){
			setDateOnInputField(datePicker: sender)
		}
	}
	
	/**
	* This function is invoked when the 'done' button on a `UIToolBar` of a `DateTimeInputField` instance is pressed.
	* The function dismisses the `DateTimeInputField` instances
	* Parameter sender: The `UIToolBar` instance whose 'done' button was pressed to trigger this function
	*/
	@objc func doneButtonOnDatePickerPressed(sender: UIToolbar){
		startTimeInputField.endEditing(true)
		endTimeInputField.endEditing(true)
		dateInputField.endEditing(true)
	}
	
	func setDateOnInputField(datePicker: UIDatePicker){
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd/MM/yyyy"
		let selectedDate = dateFormatter.string(from: datePicker.date)
		dateInputField.text = selectedDate
	}
	
	func setTimeOnInputField(datePicker: DateTimeInputField){
		
		// Splitting datePicker.date into individual components to obtain the time selected in the datePicker
		let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
		
		// Setting timeInputField to display the selected time
		let selectedTime = "\(components.hour!):\(components.minute!)"
		
		if let fieldToModify = datePicker.field{
			if(fieldToModify == "startTime"){
				startTimeInputField.text = selectedTime
			}else{
				
				// TODO: Need to make sure that the selected time is after the start time!
				endTimeInputField.text = selectedTime
			}
		}
	}
	
	//MARK: IBActions
	@IBAction func addTaskPressed(_ sender: UIButton) {
		print("Add Task Pressed")
		// TODO: Perform segue back to TodayTasksViewController
	}
	
}
