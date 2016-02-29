//
//  ColorPicker.swift
//  ReminderList
//
//  Created by Intern on 2/20/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import UIKit

class ColorPicker: UIView {

    let buttonSize = 16
    let buttonY = 24
    var currentValue = 0
    var colorButtons = Array<UIButton>()
    var colorTarget: UIView?
    let colorsArray = Array<UIColor>([.redColor(), .orangeColor(), .yellowColor(), .greenColor(), .cyanColor(), .blueColor(), .purpleColor(), .magentaColor()])


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Create color picker buttons
        for idx in 0..<8 {
            let newButton: UIButton = UIButton(frame:  CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            newButton.backgroundColor = colorsArray[idx]
            newButton.alpha = 0.3
            newButton.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchDown)
            colorButtons.append(newButton)
            addSubview(newButton)
        }
    }

    // Defines how the class should layout our color buttons
    override func layoutSubviews() {
        var buttonFrame: CGRect = CGRect(x: 0, y: buttonY, width:buttonSize, height: buttonSize)

        // Layout each button's location according to its index
        for (index, button) in colorButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (28) + 8)
            button.frame = buttonFrame
        }
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 256, height: 64)
    }

    func buttonTapped(button: UIButton) {
        guard let target = colorTarget else {
            NSLog("No coloring target assigned!")
            return
        }
        target.tintColor = button.backgroundColor
    }

    func setTarget(target: UIView) {
        self.colorTarget = target
    }

}
