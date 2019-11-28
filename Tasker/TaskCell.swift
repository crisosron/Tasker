//
//  TaskCell.swift
//  Tasker
//
//  Created by Ron Crisostomo on 28/11/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
	
	// Sub views within this cell
	@IBOutlet weak var taskTitleLabel: UILabel!
	@IBOutlet weak var taskTimeLabel: UILabel!
	@IBOutlet weak var taskPriorityLabel: UILabel!
	@IBOutlet weak var taskPriorityIndicator: UIButton!
	
	func setTask(task: Task){
		taskTitleLabel.text = task.taskTitle;
		taskTimeLabel.text = task.taskTime;
		taskPriorityLabel.text = task.taskPriority;
	}
	
}
