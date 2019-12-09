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
	var startTime: String;
	var endTime: String?
	var taskPriority: String?;
	var taskPriorityColor: UIColor?;
	
	init(taskTitle: String, startingAt startTime: String, endingAt endTime: String?, withPriority priority: String?){
		self.taskTitle = taskTitle
		self.startTime = startTime
		self.endTime = endTime
		self.taskPriority = priority
		
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
