//
//  SelectOptionInputField.swift
//  Tasker
//
//  Created by Ron Crisostomo on 3/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class SelectOptionInputField: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	var options: [String]!;
	var textField: UITextField!;

	init(options: [String], textField: UITextField){
		super.init(frame: CGRect.zero)
		self.options = options
		self.textField = textField
		self.delegate = self
		self.dataSource = self
		self.textField.text = options[0]
		self.textField.isEnabled = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1 // Only 1 row inside this UIPickerView
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return options.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return options[row];
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		textField.text = options[row]
		textField.resignFirstResponder() // Dismisses this UIPickerView on touch up
	}
}
