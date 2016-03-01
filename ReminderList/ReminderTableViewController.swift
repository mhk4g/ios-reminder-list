//
//  ReminderTableViewController.swift
//  ReminderList
//
//  Created by Intern on 2/20/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import UIKit

class ReminderTableViewController: UITableViewController {

    // MARK: Properties

    let iconAlpha: CGFloat = 0.3
    var reminders = Array<ReminderItem>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    // Only one section of rows
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Display number of rows equal to the number of reminders in the array
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ReminderTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell

        let reminder = reminders[indexPath.row]

        cell.titleLabel.text = reminder.title
        cell.descriptionLabel.text = reminder.description
        cell.iconImageView.image = reminder.image
        cell.iconImageView.tintColor = reminder.color
        cell.datestring.text = reminder.date
        cell.iconImageView.alpha = iconAlpha

        return cell
    }

    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {

        // If we just arrived at this VC from the "AddReminderViewController" and it has a current value set to its newReminderItem...
        if let sourceViewController = sender.sourceViewController as? AddReminderViewController, reminder = sourceViewController.newReminderItem {

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                reminders[selectedIndexPath.row] = reminder
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                //add a new reminder
                let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
                reminders.append(reminder)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }

            let timeInterval = floor(reminder.dateActual.timeIntervalSinceReferenceDate / 60.0) * 60.0
            let newDate = NSDate(timeIntervalSinceReferenceDate: timeInterval)

            // Register for local notification
            scheduleLocalNotification(reminder.title, description: reminder.description, reminderDate: newDate)

            reminders.sortInPlace({ $0.dateActual.compare($1.dateActual) == NSComparisonResult.OrderedAscending })

            self.tableView.reloadData()

            for a in reminders {
                NSLog(a.title)
            }

        }

    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            reminders.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let reminderDetailViewController = segue.destinationViewController as! AddReminderViewController
            if let selectedReminderCell = sender as? ReminderTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedReminderCell)!
                let selectedReminder = reminders[indexPath.row]
                reminderDetailViewController.newReminderItem = selectedReminder
            }
        }
            
        else if segue.identifier == "AddItem" {
            
            print("Adding new reminder.")
        
        }
    }
    

}
