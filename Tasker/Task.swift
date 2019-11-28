//
//  Task.swift
//  Tasker
//
//  Created by Ron Crisostomo on 28/11/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import Foundation;
import UIKit;

class Task{
	var taskTitle: String;
	var taskTime: String;
	var taskPriority: String?;
	var taskPriorityIndicatorImage: UIImage?;
	
	enum PRIORITY {
		case HIGH
		case MEDIUM
		case LOW
	}
	
	init(taskTitle: String, timeOfTask taskTime: String, taskPriority: String?){
		self.taskTitle = taskTitle;
		self.taskTime = taskTime;
		self.taskPriority = taskPriority;
	}
}
