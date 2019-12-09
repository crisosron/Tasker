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
	@IBOutlet weak var taskTitleInputField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		// Configuring the input fields to be custom input fields
		startTimeInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.time, target: self, field: "startTime");
		endTimeInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.time, target: self, field:"endTime");
		dateInputField.inputView = DateTimeInputField(mode: UIDatePicker.Mode.date, target: self, field: "date");
		priorityInputField.inputView = SelectOptionInputField(options: ["None", "Low", "Medium", "High"], textField: priorityInputField);
		
		// Setting up the tool bar for the input fields
		let toolBar = UIToolbar().createToolBar(selector: #selector(doneButtonOnDatePickerPressed(sender:)))
		startTimeInputField.inputAccessoryView = toolBar
		endTimeInputField.inputAccessoryView = toolBar
		dateInputField.inputAccessoryView = toolBar
		
		// Setting up default values inside the input fields
		let date = Date()
		startTimeInputField.text = DateFormatter.twelveHourString(with: date)
		
		// Setting up default date on dateInputField
		let dateFormatter = DateFormatter();
		dateFormatter.dateFormat = "dd/MM/yyyy"
		dateInputField.text = dateFormatter.string(from: date)
		
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
		
		// Setting timeInputField to display the selected time
		let selectedTime = DateFormatter.twelveHourString(with: datePicker.date)
		
		if let fieldToModify = datePicker.field{
			if(fieldToModify == "startTime"){
				startTimeInputField.text = selectedTime
			}else{
				
				// TODO: Need to make sure that the selected time is after the start time!
				endTimeInputField.text = selectedTime
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "addTaskToTodayTasks"){
			self.dismiss(animated: true) {

				let todayTasksVC = segue.destination as! TodayTasksViewController
				
				// TODO: Verify that there is a task title before creating the new Task object (do a guard check here!)
				let title = self.taskTitleInputField.text
				let startingTime = self.startTimeInputField.text
				let endingTime = self.endTimeInputField.text
				let priority = self.priorityInputField.text
				
				let newTask = Task(taskTitle: title!, startingAt: startingTime!, endingAt: endingTime, withPriority: priority)
				todayTasksVC.addTask(task: newTask)
			}
		}
	}
	
	//MARK: IBActions
	@IBAction func addTaskPressed(_ sender: UIButton) {
		performSegue(withIdentifier: "addTaskToTodayTasks", sender: sender)
		
	}
	
}

extension DateFormatter{
	static func twelveHourString(with time: Date) -> String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm a"
		let formattedTime = dateFormatter.string(from: time)
		return formattedTime
	}
}
