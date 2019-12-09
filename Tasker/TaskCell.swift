//
//  TaskCell.swift
//  Tasker
//
//  Created by Ron Crisostomo on 28/11/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit
protocol TaskCellProtocol{
	func checkOnTaskPressed(indexPath: IndexPath);
}
class TaskCell: UITableViewCell {
	
	// Sub views within this cell
	@IBOutlet weak var taskTitleLabel: UILabel!
	@IBOutlet weak var taskTimeLabel: UILabel!
	@IBOutlet weak var taskPriorityLabel: UILabel!
	@IBOutlet weak var taskPriorityIndicator: UIButton!
	@IBOutlet weak var checkButton: CheckButton!
	
	// Used for TaskCellProtocol
	var taskCellDelegate: TaskCellProtocol?
	var indexPath: IndexPath?
	
	/**
	* Sets the `Task` object associated with this `TaskCell`
	* Parameter task - The` Task` objected to be associated with this `TaskCell`
	*/
	func setTask(task: Task){
		taskTitleLabel.text = task.taskTitle;
		taskTimeLabel.text = task.taskTime;
		
		// Displaying priority indication and text (if a priority value for the task has been set)
		if let priorityValue = task.taskPriority{
			taskPriorityLabel.text = "Priority: \(priorityValue)";
		}else{
			taskPriorityLabel.text = "";
		}
		
		if let priorityColor = task.taskPriorityColor{
			taskPriorityIndicator.backgroundColor = priorityColor;
		}else{
			taskPriorityIndicator.backgroundColor = UIColor.systemBackground;
		}
	}
	
	/**
	Invokes the `checkOnTaskPressed` function declared `TaskCellProtocol`
	*/
	@IBAction func checkButtonPressed(_ sender: CheckButton) {
		sender.togglePress();
		taskCellDelegate?.checkOnTaskPressed(indexPath: self.indexPath!);
	}
}
