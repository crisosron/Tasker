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
	var taskPriorityColor: UIColor?;
	
	init(taskTitle: String, timeOfTask taskTime: String, taskPriority: String?){
		self.taskTitle = taskTitle;
		self.taskTime = taskTime;
		self.taskPriority = taskPriority;
		
		// Determines the color of the task
		if let priority = taskPriority{ // If there is a priority value....
			if priority == "Low"{
				taskPriorityColor = UIColor.yellow;
			}else if priority == "Medium"{
				taskPriorityColor = UIColor.orange;
			}else{
				taskPriorityColor = UIColor.red;
			}
		}
	}
}
