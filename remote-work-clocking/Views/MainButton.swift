//
//  MainButton.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import SwiftUI
import AppKit

struct MainButton: NSViewRepresentable {
    typealias NSViewType = NSButton
    
    let title: String
    let longPressAction: () -> Void
    let tapAction: () -> Void
    
    func makeNSView(context: Context) -> NSButton {
        let button = NSButton(title: title, target: context.coordinator, action: #selector(Coordinator.handleTap))
        
        // Add gesture recognizer for long press
        let longPressRecognizer = NSPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress))
        longPressRecognizer.minimumPressDuration = 5.0
        button.addGestureRecognizer(longPressRecognizer)
        
        return button
    }
    
    func updateNSView(_ nsView: NSButton, context: Context) {
        nsView.title = title
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        let parent: MainButton
        
        init(_ parent: MainButton) {
            self.parent = parent
        }
        
        @objc func handleTap(sender: NSButton) {
            parent.tapAction()
        }
        
        @objc func handleLongPress(sender: NSPressGestureRecognizer) {
            if sender.state == .ended {
                parent.longPressAction()
            }
        }
    }
}
