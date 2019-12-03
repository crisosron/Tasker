//
//  DateTimeInputField.swift
//  Tasker
//
//  Created by Ron Crisostomo on 3/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class DateTimeInputField: UIDatePicker {
	var mode: UIDatePicker.Mode
	init(mode: UIDatePicker.Mode, target: UIViewController){
		self.mode = mode
		super.init(frame: CGRect.zero)
		super.datePickerMode = mode;
		self.addTarget(target, action: #selector(AddTaskViewController.dateTimePickerValueChanged(sender:)), for: .valueChanged)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
