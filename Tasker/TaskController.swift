//
//  TaskController.swift
//  Tasker
//
//  Created by Ron Crisostomo on 12/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import Foundation

class TaskController{
	static var tasksPendingCompletion: [Task] = [];
	
	static func addTask(_ task: Task){
		tasksPendingCompletion.append(task);
	}

}
