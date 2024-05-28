//
//  DrawingModel.swift
//  LiveIndraw
//
//  Created by sun che on 2024-04-29.
//
//  Copyright © 2024 AcroMace. All rights reserved.
//

import UIKit

// Represents one emoji point
//储存每个表情点的位置 大小 符号
struct DrawingPoint {
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let emoji: String
}

// The model used to describe everything needed to draw the emojis
// 管理和存储所有需要绘制的表情符号点的模型
class DrawingModel {
    private(set) var points: [DrawingPoint]
    private var undoStack:[[DrawingPoint]]
    private var redoStack:[[DrawingPoint]]
    let canvasSize: CGSize
    
    //初始化
    init(canvasSize: CGSize) {
        self.canvasSize = canvasSize
        points = []
        undoStack = []
        redoStack = []
    }
    
    //添加点
    func addPoint(point: DrawingPoint) {
        //保存到undoStack
        undoStack.append(points)
        points.append(point)
        //清空redoStack
        redoStack.removeAll()
        
    }
    
    //清空点
    func clearPoints() {
        undoStack.append(points)
        points = []
        redoStack.removeAll()
    }
    
    //
    func undo(){
        guard let lastState = undoStack.popLast() else { return }
        redoStack.append(points)
        points = lastState
    }
    
    func redo(){
        guard let lastUndoneState = redoStack.popLast() else {return}
        undoStack.append(points)
        points = lastUndoneState
    }
    
    func reset(){
        points = []
        undoStack.removeAll()
        redoStack.removeAll()
    }
}
