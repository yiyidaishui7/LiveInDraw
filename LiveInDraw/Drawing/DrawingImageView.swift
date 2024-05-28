//
//  DrawingImageView.swift
//  LiveIndraw
//
//  Created by sun che on 2024-04-29.
//
//  Copyright © 2024 AcroMace. All rights reserved.
//

import UIKit

//在用户触摸屏幕时检测触摸位置和力度

//指定了 位置 大小
protocol DrawingImageViewDelegate: class {
    func drewEmoji(at point: CGPoint, with size: CGFloat)
}

class DrawingImageView: UIImageView {
    weak var delegate: DrawingImageViewDelegate?

    //触摸开始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        respondToTouches(touches)
    }
    
    //触摸移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        respondToTouches(touches)
    }

    //处理触摸
    private func respondToTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }   //获取第一个触摸对象
        let location = touch.location(in: self)           //触摸位置
        let size = touch.force > 0 ? touch.force : 1      //触摸力度
        delegate?.drewEmoji(at: location, with: size)     //传递位置、大小
    }
}
