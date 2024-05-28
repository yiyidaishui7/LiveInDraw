//
//  EmojiPaletteTableViewController.swift
//  LiveIndraw
//
//  Created by sun che on 2024-04-29.
//
//  Copyright © 2024 AcroMace. All rights reserved.
//

// 符号管理器面板
import UIKit

// 选了表情
protocol EmojiPaletteTableViewControllerDelegate: class {
    func didSelectEmoji(emoji: String)
}

class EmojiPaletteTableViewController: UITableViewController {

    let emojiPalette = EmojiPalette()
    var delegate: EmojiPaletteTableViewControllerDelegate?
    
    // 添加新的表情符号
    @IBAction func didPressAddEmojiButton(_ sender: Any) {
        // 提示用户输入新的表情符号
        let alert = UIAlertController(title: "Add emoji", message: nil, preferredStyle: .alert)
        // okey 和 cancel
        //okey：
        let okay = UIAlertAction(title: "OK", style: .default) { _ in
            guard let alertTextField = alert.textFields?.first else { return }//获取文本框里的符号
            guard let emoji = alertTextField.text else { return }
            self.emojiPalette.addEmojiToPalette(emoji: emoji) //添加到emojiPalette中
            self.tableView.reloadData() //刷新
        }
        //cancel：不进行任何操作
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addTextField { textField in
            textField.placeholder = "Enter emoji here"
        }
        alert.addAction(okay)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - Table view data source

extension EmojiPaletteTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiPalette.count() //
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrawingEmojiTableViewCell.reuseIdentifier) as? DrawingEmojiTableViewCell else {
            print("ERROR: Failed to dequeue DrawingEmojiTableViewCell")
            return DrawingEmojiTableViewCell()
        }

        guard indexPath.row < emojiPalette.count() else {
            print("ERROR: Tried to dequeue out of range emoji")
            return DrawingEmojiTableViewCell()
        }

        cell.config(emoji: emojiPalette.getEmoji(index: indexPath.row), isSelected: emojiPalette.isSelectedEmoji(index: indexPath.row))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        emojiPalette.selectEmoji(index: indexPath.row)
        tableView.reloadData()
        delegate?.didSelectEmoji(emoji: emojiPalette.getEmoji())
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojiPalette.deleteEmoji(index: indexPath.row)
            tableView.reloadData()
        }
    }

}
