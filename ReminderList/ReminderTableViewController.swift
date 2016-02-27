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
//        loadSampleReminders()

    }

    func loadSampleReminders() {
        let icon1 = UIImage(named: "alarm-clock")!
        let item1 = ReminderItem(image: icon1, color: UIColor.redColor(), title: "Buy a clock", description: "Go to the store and buy yourself a damn clock")!

        let icon2 = UIImage(named: "book")!
        let item2 = ReminderItem(image: icon2, color: UIColor.orangeColor(), title: "Read book", description: "War and Peace isn't going to read itself")!

        let icon3 = UIImage(named: "group")!
        let item3: ReminderItem = ReminderItem(image: icon3, color: UIColor.magentaColor(), title: "Make a friend", description: "Too much computers. Go make some friends for chrissake")!

        reminders.append(item1)
        reminders.append(item2)
        reminders.append(item3)
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
            
            /*
            // Get ready to add the new reminder to array
            let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)

            // Add the new reminder to the array
            reminders.append(reminder)

            // Add the new row at the newly calculated index
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)

            */
        }

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
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
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
