//
//  AddTaskViewController.swift
//  Tasker
//
//  Created by Ron Crisostomo on 3/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

	@IBOutlet weak var priorityInputField: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()
		priorityInputField.inputView = SelectOptionInputField(options: ["Low", "Medium", "High"], textField: priorityInputField);
    }

}
