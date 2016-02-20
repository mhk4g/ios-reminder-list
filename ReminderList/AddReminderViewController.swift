//
//  ViewController.swift
//  ReminderList
//
//  Created by Intern on 2/20/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    // MARK: Properties

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var iconView: UIImageView!

    let imageNames: Array<String> = ["alarm-clock", "announce", "book", "briefcase", "date", "group", "home", "picture", "shopping-bag", "star", "addon"]
    var imageSet: Array<UIImage> = Array<UIImage>()
    var currentImageIndex = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign the view controller as the delegate for both text fields
        itemTitle.delegate = self
        itemDescription.delegate = self

        loadImagesIntoArray()

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



    // MARK: UIImagePickerControllerDelegate


    // MARK: Actions

    @IBAction func getNextIcon(sender: UITapGestureRecognizer) {
        // Make sure keyboard is hidden
        itemTitle.resignFirstResponder()
        itemDescription.resignFirstResponder()
    }

    @IBAction func createButtonClicked(sender: UIButton) {
        // Code will go here
    }


    // MARK: Image loader

    func loadImagesIntoArray() -> Bool {

        let paths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Assets")

        NSLog("Starting")

        for path in paths {
            NSLog("\(path)")

        }

        return true
    }


}

