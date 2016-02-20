//
//  ViewController.swift
//  ReminderList
//
//  Created by Intern on 2/20/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var exampleLabel: UILabel!
    var timesClicked: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign the view controller as the delegate for both text fields
        itemTitle.delegate = self
        itemDescription.delegate = self
    }

    // MARK: UITextFieldDelegate

    // Called first: hide the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // Called second: process the input
    func textFieldDidEndEditing(textField: UITextField) {
        NSLog("The user entered input.")
    }


    // MARK: Actions

    @IBAction func createButtonClicked(sender: UIButton) {
        timesClicked++
        exampleLabel.text = "Button clicked: \(timesClicked)"
    }


}

