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
    let title: String
    let description: String

    init(image: UIImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }

}