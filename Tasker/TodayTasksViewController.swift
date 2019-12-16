//
//  FirstViewController.swift
//  Tasker
//
//  Created by Ron Crisostomo on 28/11/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class TodayTasksViewController: UIViewController {
	var completedTasks: [Task] = [];
	var newestTask: Task?
	
	@IBOutlet weak var todayTasksTableView: UITableView!
	
	//MARK: Overridden functions
	override func viewDidLoad() {
		super.viewDidLoad();
		
		// Setting the delegate and dataSource to be used by the table view to be self (see extension)
		todayTasksTableView.delegate = self
		todayTasksTableView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		todayTasksTableView.reloadData()
	}
	
	@IBAction func unwindToTodayTasksVC(unwindSegue: UIStoryboardSegue){
		// Important Note: For some reason, todayTasksTableView is nil when it is accessed outside of methods
		// defined by UIViewController. Because of this, when the user unwinds from the AddTaskVC, we need to invoke
		// viewDidAppear on this VC so we can conduct operations on todayTasksTableView inside viewDidAppear
		self.viewDidAppear(true)
	}
	
	//MARK: Segue to AddTaskVC
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "todayTasksToAddTask"){
			let taskDetailVC = segue.destination as! TaskDetailViewController
			taskDetailVC.task = sender as? Task
		}
	}
}

// This VC delegates to todayTasksTableView
extension TodayTasksViewController: UITableViewDataSource, UITableViewDelegate{
	
	// This VC only has 1 section
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return TaskController.tasksPendingCompletion.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = TaskController.tasksPendingCompletion[indexPath.row];
		let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell;
		taskCell.taskCellDelegate = self; // Makes use of custom TaskCellProtocol protocol
		taskCell.indexPath = indexPath;
		taskCell.setTask(task: task);
		return taskCell;
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Today's Tasks"
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedTask = TaskController.tasksPendingCompletion[indexPath.row]
		performSegue(withIdentifier: "todayTasksToAddTask", sender: selectedTask)
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
		print("Completed task at \(indexPath)");
		print("Completed task title: \(TaskController.tasksPendingCompletion[indexPath.row].taskTitle)");

	}
	
}

