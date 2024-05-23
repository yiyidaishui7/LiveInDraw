//
//  DrawingEmojiTableViewCell.swift
//  LiveIndraw
//
//  Created by sun che on 2024-04-29.
//
//  Copyright © 2024 AcroMace. All rights reserved.
//

import UIKit

class DrawingEmojiTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DrawingEmojiTableViewCell"
    private static let selectedColor = UIColor.init(hue: 0, saturation: 0, brightness: 0, alpha: 0.05)
    private static let deselectedColor = UIColor.white

    @IBOutlet weak var emojiLabel: UILabel!

    func config(emoji: String, isSelected: Bool) {
        emojiLabel.text = emoji
        backgroundColor = isSelected ? DrawingEmojiTableViewCell.selectedColor : DrawingEmojiTableViewCell.deselectedColor
    }

}
