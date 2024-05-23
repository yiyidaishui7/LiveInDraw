//
//  EmojiPalettePopover.swift
//  LiveIndraw
//
//  Created by sun che on 2024-04-29.
//
//  Copyright © 2024 AcroMace. All rights reserved.
//

import UIKit

protocol EmojiPalettePopoverDelegate: class {
    func didSelectEmoji(emoji: String)
}

// Wrapper for the emoji popover view controller
class EmojiPalettePopover {

    static let storyboard = "EmojiPaletteTableViewController"

    // View controllers
    private var navigationController: UINavigationController?
    private var tableViewController: EmojiPaletteTableViewController?

    // Delegate to be notified when an emoji is selected
    var delegate: EmojiPalettePopoverDelegate?

    // The emoji that was selected to be drawn with
    var selectedEmoji: String? {
        return getTableViewController()?.emojiPalette.getEmoji()
    }

    // The view controller to display in the popup
    var viewController: UIViewController? {
        return getNavigationController()
    }

    // MARK: - Private methods

    private func getNavigationController() -> UINavigationController? {
        if navigationController != nil {
            return navigationController
        }

        let navigationControllerStoryboard = UIStoryboard(
            name: EmojiPalettePopover.storyboard,
            bundle: Bundle(for: EmojiPaletteTableViewController.self))
        navigationController = navigationControllerStoryboard.instantiateInitialViewController() as? UINavigationController
        navigationController?.modalPresentationStyle = .popover
        return navigationController
    }

    private func getTableViewController() -> EmojiPaletteTableViewController? {
        if tableViewController != nil {
            return tableViewController
        }

        tableViewController = getNavigationController()?.topViewController as? EmojiPaletteTableViewController
        tableViewController?.delegate = self
        return tableViewController
    }

}

// MARK: - EmojiPaletteTableViewControllerDelegate

extension EmojiPalettePopover: EmojiPaletteTableViewControllerDelegate {

    func didSelectEmoji(emoji: String) {
        delegate?.didSelectEmoji(emoji: emoji)
    }

}
