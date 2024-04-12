//
//  WallpaperWindowManager.swift
//  WallpaperManager
//
//  Created by Enzo Fleche on 09/04/2024.
//

import Foundation
import SwiftUI

class WallpaperWindowManager: ObservableObject {
    private var currentlyPressedModifiers: Set<CGKeyCode> = []
    private var flagsChangedEventMonitor: EventMonitor?
    private var keyDownEventMonitor: EventMonitor?
    private let wallpaperWindowController = WallpaperWindowController()
    private var panelIsOpen = false
    
    func startObservingKeys() {
        self.flagsChangedEventMonitor = NSEventMonitor(
            scope: .global,
            eventMask: .flagsChanged,
            handler: processModifiers(_:)
        )
        
        self.keyDownEventMonitor = NSEventMonitor(
            scope: .global,
            eventMask: .keyDown,
            handler: handleWallpaperKeypress(_:)
        )
        
        self.flagsChangedEventMonitor!.start()
        self.keyDownEventMonitor!.start()
    }
    
    func handleWallpaperKeypress(_ event: NSEvent) {
        if event.keyCode == 14 {
            if !panelIsOpen {
                self.wallpaperWindowController.open()
            }
            
            self.panelIsOpen = true
        }
    }
    
    private func processModifiers(_ event: NSEvent) {
        if self.currentlyPressedModifiers.contains(event.keyCode) {
            self.currentlyPressedModifiers.remove(event.keyCode)
        } else if event.modifierFlags.rawValue == 256 {
            self.currentlyPressedModifiers = []
        } else {
            self.currentlyPressedModifiers.insert(event.keyCode)
        }

        print("Current modifiers: \(currentlyPressedModifiers)")
    }
}
