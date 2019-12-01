//
//  FirstViewController.swift
//  Tasker
//
//  Created by Ron Crisostomo on 28/11/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class TodayTasksViewController: UIViewController {
	var todayTasks: [Task] = [];
	var completedTasks: [Task] = [];
	@IBOutlet weak var todayTasksTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		todayTasks = createTasks();
		
		// Setting the delegate and dataSource to be used by the table view to be self (see extension)
		todayTasksTableView.delegate = self;
		todayTasksTableView.dataSource = self;
	}

	
	// MARK: A temporary task generator function
	func createTasks() -> [Task]{
		var generatedTasks:[Task] = [];
		let priorityValues: [String] = ["Low", "Medium", "High"];
		for i in 0...9{
			let generatedTaskTitle = "Task " + String(i);
			let randomIndex = Int.random(in: 0...3);
			let randomPriorityValue = randomIndex != 3 ? priorityValues[randomIndex] : nil;
			let task = Task(taskTitle: generatedTaskTitle, timeOfTask: "00:00am - 00:00pm", taskPriority: randomPriorityValue);
			generatedTasks.append(task)
		}
		
		return generatedTasks;
	}
}

// This VC delegates to todayTasksTableView
extension TodayTasksViewController: UITableViewDataSource, UITableViewDelegate{
	
	// This VC only has 1 section
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2;
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == 0 ? todayTasks.count : completedTasks.count;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = todayTasks[indexPath.row];
		let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell;
		taskCell.taskCellDelegate = self; // Makes use of custom TaskCellProtocol protocol
		taskCell.indexPath = indexPath;
		taskCell.setTask(task: task);
		return taskCell;
	}
	
	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		section == 0 ? "Today's Tasks" : "Completed Tasks"
	}
}

/**
	This extension handles the implementation of the methods inside `TaskCellProtocol`
*/
extension TodayTasksViewController: TaskCellProtocol{
	
	/**
		Handles the event in which the `CheckButton` associated with a `TaskCell` is tapped. The TaskCell at `indexPath.row` is moved to `completedTasks`
		Parameter indexPath - IndexPath of the `TaskCell` that corresponds with the tapped `CheckButton`
	*/
	func checkOnTaskPressed(indexPath: IndexPath) {
		let completedTask = todayTasks[indexPath.row];
		completedTasks.append(completedTask);
		todayTasks.remove(at: indexPath.row);
		todayTasksTableView.reloadData();
	}
	
}

