//
//  Alerter.swift
//  Tasker
//
//  Created by Ron Crisostomo on 16/12/19.
//  Copyright © 2019 Ron Crisostomo. All rights reserved.
//

import UIKit

class Alerter{
	static func showBasicAlert(withTitle title: String){
		let alertController = UIAlertController(title: "foo", message: "bar", preferredStyle: .alert);
		let okButton = UIAlertAction(title: "OK", style: .default){(action) in /*Code to execute when ok button pressed*/};
		alertController.addAction(okButton);
		self.present(alertController, animated:true, completion: nil);
	}
}
