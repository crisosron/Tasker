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
	var taskCellDelegate: TaskCellProtocol?
	var indexPath: IndexPath?
	
	func setTask(task: Task){
		taskTitleLabel.text = task.taskTitle;
		taskTimeLabel.text = task.taskTime;
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
	
	@IBAction func checkButtonPressed(_ sender: CheckButton) {
		sender.togglePress();
		taskCellDelegate?.checkOnTaskPressed(indexPath: self.indexPath!);
	}
	
	
	
}
