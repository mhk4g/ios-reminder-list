//
//  ColorPicker.swift
//  ReminderList
//
//  Created by Intern on 2/20/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import UIKit

class ColorPicker: UIView {

    var currentValue = 0
    var colorButtons = Array<UIButton>()
    let colorsArray = Array<UIColor>([.redColor(), .orangeColor(), .yellowColor(), .greenColor(), .cyanColor(), .blueColor(), .purpleColor(), .magentaColor()])

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Create color picker buttons
        for idx in 0..<8 {
            let button: UIButton = UIButton(frame:  CGRect(x: 0, y: 0, width: 16, height: 16))
            button.backgroundColor = colorsArray[idx]
            button.alpha = 0.3
            button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchDown)
            colorButtons.append(button)
            addSubview(button)
        }
    }

    // Defines how the class should layout our color buttons
    override func layoutSubviews() {
        var buttonFrame: CGRect = CGRect(x: 0, y: 24, width:16, height: 16)

        // Layout each button's location according to its index
        for (index, button) in colorButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (32) + 8)
            button.frame = buttonFrame
        }
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 256, height: 64)
    }

    func buttonTapped(button: UIButton) {
        NSLog("Button pressed!")
    }

}
