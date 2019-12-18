//
//  TaskDetailViewController.swift
//  Tasker
//
//  Created by Ron Crisostomo on 3/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

	@IBOutlet weak var priorityInputField: UITextField!
	@IBOutlet weak var startTimeInputField: UITextField!
	@IBOutlet weak var endTimeInputField: UITextField!
	@IBOutlet weak var dateInputField: UITextField!
	@IBOutlet weak var taskTitleInputField: UITextField!
	@IBOutlet weak var operationButton: UIButton!
	
	enum Mode {
		case ADD_TASK
		case UPDATE_TASK
	}
	
	enum TaskDetailException: Error{
		case invalidTaskTitle
	}
	
	var task: Task?
	var mode: Mode!
	
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
		
		
		if task != nil{
			loadTask()
			operationButton.setTitle("Update Task", for: .normal)
			mode = Mode.UPDATE_TASK
			
		}else{
			loadDefaults()
			operationButton.setTitle("Add Task", for: .normal);
			mode = Mode.ADD_TASK
		}
		
    }
	
	func loadTask(){
		taskTitleInputField.text = task?.taskTitle
		startTimeInputField.text = task?.startTime
		endTimeInputField.text = task?.endTime
		priorityInputField.text = task?.taskPriority
	}
	
	func loadDefaults(){
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
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if(identifier == "unwindSegueFromTaskDetailToTodayTasks"){
			if(taskTitleInputField.text == ""){
				showAlert(withTitle: "Task Title", withMessage: "Please enter a task title to perform the operation")
				return false
			}
		}
		
		return true
	}
	
	//MARK: IBActions
	@IBAction func operationButtonPressed(_ sender: Any) {
		// Handling precondition that the task title must not be empty
		if(taskTitleInputField.text == ""){
			return; // Note that the handling of this occurs in shouldPerformSegue method (shows an alert)
		}
		
		if(mode == Mode.ADD_TASK){
			do { try addTask() }
			catch {
				print("Invalid title input, aborting the addition of the new task")
				return
			}
			
		}else{
			do { try updateTask() }
			catch {
				print("Unable to update task, aborting")
				return
			}
		}
	}
	
	func addTask() throws {
		
		// Enforcing precondition that taskTitle is not empty
		guard let taskTitle = taskTitleInputField.text else{
			throw TaskDetailException.invalidTaskTitle
		}
		if(taskTitle == ""){
			throw TaskDetailException.invalidTaskTitle
		}
		
		// Obtaining entered task detailts and adding a new task
		let taskStartTime = startTimeInputField.text
		let taskEndTime = endTimeInputField.text
		let priority = priorityInputField.text
		let task = Task(taskTitle: taskTitle, startingAt: taskStartTime!, endingAt: taskEndTime, withPriority: priority)
		TaskController.addTask(task)
	}
	
	func updateTask() throws{
		
		// Enforcing precondition that taskTitle is not empty
		guard let taskTitle = taskTitleInputField.text else{
			throw TaskDetailException.invalidTaskTitle
		}
		if(taskTitle == ""){
			throw TaskDetailException.invalidTaskTitle
		}
		
		// Obtaining task details and updating the task
		let taskStartTime = startTimeInputField.text
		let taskEndTime = endTimeInputField.text
		let priority = priorityInputField.text
		
		do{
			let taskToModify = try TaskController.getTask(self.task!)
			taskToModify.taskTitle = taskTitle
			taskToModify.startTime = taskStartTime
			taskToModify.endTime = taskEndTime
			taskToModify.taskPriority = priority
		}catch {
			print("Task not found")
		}
		
	}
	
	func showAlert(withTitle title: String, withMessage message: String){
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert);
		let okButton = UIAlertAction(title: "OK", style: .default){(action) in /*Code to execute when ok button pressed*/};
		alertController.addAction(okButton);
		self.present(alertController, animated:true, completion: nil);
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
