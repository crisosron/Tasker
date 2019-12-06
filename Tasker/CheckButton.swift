//
//  CheckButton.swift
//  Tasker
//
//  Created by Ron Crisostomo on 1/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

/**
* Represents a toggling button within a TaskCell object. This serves the purpose of indicating that a task has been completed
*/
class CheckButton: UIButton {
	var toggledOn = false;
	override func awakeFromNib() {
		super.awakeFromNib();
		
		// This will make it so that no matter the scaling of the screen, border width will only be 1 pixel
		layer.borderWidth = 1/UIScreen.main.nativeScale;
		
		// Sets the color of the border
		layer.borderColor = UIColor.blue.cgColor;
		
		layer.cornerRadius = frame.height/5;
		
	}
	
	/**
	* Toggles the button on or off, changing the background of the button in accordance to the new state of this CheckButton
	*/
	func togglePress(){
		toggledOn = !toggledOn;
		if(toggledOn){
			layer.backgroundColor = UIColor.blue.cgColor;
		}else{
			layer.backgroundColor = nil;
		}
		
	}

}
