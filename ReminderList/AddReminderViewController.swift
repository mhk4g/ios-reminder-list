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
    @IBOutlet weak var colorPicker: ColorPicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var datePicker: UIDatePicker!


    var newReminderItem: ReminderItem?

    let imageNames: Array<String> = ["alarm-clock", "announce", "book", "briefcase", "date", "group", "home", "picture", "shopping-bag", "star", "addon"]
    var imageSet: Array<UIImage> = Array<UIImage>()
    var currentImageIndex = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Resets default image to clock icon
        currentImageIndex = 0

        // Disables save button by default
        saveButton.enabled = false

        // Assign the view controller as the delegate for both text fields
        itemTitle.delegate = self
        itemDescription.delegate = self
        if let reminder = newReminderItem {
            itemTitle.text = reminder.title
            itemDescription.text   = reminder.description
            iconView.image = reminder.image

        }

        // Load the images for image selector
        loadImagesIntoArray()

        // Load the initial image from the
        iconView.image = imageSet[currentImageIndex]

        // Sets the icon as the target of the color picker
        colorPicker.setTarget(iconView)
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
        validateUserInput()
    }

    // Prevents the user from saving when typing
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
  //DISPLAYING DATE
    @IBAction func displayDate() {
        // First we need to create a new instance of the NSDateFormatter
        let dateFormatter = NSDateFormatter()
        // Now we specify the display format, e.g. "27-08-2015
        dateFormatter.dateFormat = "dd-MM-YYYY"
        // Now we get the date from the UIDatePicker and convert it to a string
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        // Finally we set the text of the label to our new string with the date
        print(strDate);
    }

    func validateUserInput() {
        // Disable the Save button if the text field is empty.
        let title = itemTitle.text ?? "", description = itemDescription.text ?? ""
        saveButton.enabled = !(title.isEmpty || description.isEmpty)
    }


    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === saveButton {
            let title = itemTitle.text ?? "Reminder"
            let description = itemDescription.text ?? "Whatever it is, you'd better do it"
            let color = iconView.tintColor ?? UIColor.grayColor()
            let icon = iconView.image ?? UIImage(named: "alarm-clock")!

            newReminderItem = ReminderItem(image: icon, color: color, title: title, description: description)

        }
    }

    

    // MARK: Actions

    // Dismisses the current view controller when cancel is pressed
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddReminderMode = presentingViewController is UINavigationController
        if isPresentingInAddReminderMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func getNextIcon(sender: UITapGestureRecognizer) {

        // Make sure keyboard is hidden
        itemTitle.resignFirstResponder()
        itemDescription.resignFirstResponder()

        if currentImageIndex >= imageSet.count - 1 {
            currentImageIndex = 0
        } else {
            currentImageIndex++
        }

        iconView.image = imageSet[currentImageIndex]
    }

    @IBAction func createButtonClicked(sender: UIButton) {
        // Code will go here
    }


    // MARK: Image loader

    func loadImagesIntoArray() {

        for imageName in imageNames {
            if let image = UIImage(named: imageName) {
                imageSet.append(image)
                NSLog("Image loaded: \(imageName)")
            } else {
                NSLog("Image not found: \(imageName)")
            }
        }
    }


}

