//
//  ReminderItem.swift
//  ReminderList
//
//  Created by Intern on 2/20/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import Foundation
import UIKit

public class ReminderItem {

    let image: UIImage
    let color: UIColor
    let title: String
    let description: String
    var active: Bool = true
    let date: String
    let dateActual: NSDate

    init?(image: UIImage, color: UIColor, title: String, description: String, date: String, dateActual: NSDate) {

        self.image = image
        self.color = color
        self.title = title
        self.description = description
        self.date = date
        self.dateActual = dateActual
        // Fail if either string is empty
        if self.title.isEmpty || self.description.isEmpty {
            return nil
        }
    
   
        
    }
    
}