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
	var field: String?
	init(mode: UIDatePicker.Mode, target: UIViewController, field: String?){
		self.mode = mode
		self.field = field
		super.init(frame: CGRect.zero)
		super.datePickerMode = mode
		self.addTarget(target, action: #selector(TaskDetailViewController.dateTimePickerValueChanged(sender:)), for: .valueChanged)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func getField() -> String? {
		return self.field
	}
}

/**
* This extension of UIToolBar allows for the creaiton of a custom tool bar for a `DateTimeInputField` instance.
* The tool bar features a single 'done' `UIBarButtonItem` to dismiss the `DateTimeInputField` instance the tool bar is attached to
*/
extension UIToolbar{
	
	/**
	* Creates a `UIToolBar` with a done button
	* Parameter selector: A selector for the function to be called when the done UIBarButtonItem is pressed
	* Returns: A `UIToolBar` instance with a 'done' `UIBarButtonItem`
	*/
	func createToolBar(selector: Selector) -> UIToolbar{
		let toolBar = UIToolbar()
		toolBar.barStyle = .default
		toolBar.isTranslucent = true
		toolBar.tintColor = self.tintColor // Default system blue color
		toolBar.sizeToFit()
		let doneButton  = UIBarButtonItem(title: "Done", style: .done, target: self, action: selector);
		toolBar.setItems([doneButton], animated: true)
		return toolBar
	}
}
