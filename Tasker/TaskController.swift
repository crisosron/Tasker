//
//  TaskController.swift
//  Tasker
//
//  Created by Ron Crisostomo on 12/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import Foundation

class TaskController{
	enum TaskControllerException: Error{
		case taskNotFound
	}
	static var tasksPendingCompletion: [Task] = [];
	
	static func addTask(_ task: Task){
		tasksPendingCompletion.append(task);
	}
	
	static func getTask(_ taskToGet: Task) throws -> Task{
		for task in tasksPendingCompletion{
			if task === taskToGet{
				return task
			}
		}
		
		throw TaskControllerException.taskNotFound
	}

}
