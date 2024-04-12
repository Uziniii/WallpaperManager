//
//  AppDelegate.swift
//  WallpaperManager
//
//  Created by Enzo Fleche on 09/04/2024.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private let wallpaperWindowManager = WallpaperWindowManager()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
//        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: false]
//        let status = AXIsProcessTrustedWithOptions(options)
//        
//        if status {
//            let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
//            let _ = AXIsProcessTrustedWithOptions(options)
//        }
        
        _ = AXIsProcessTrustedWithOptions(
                    [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)
//        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
//        let _ = AXIsProcessTrustedWithOptions(options)
        
        wallpaperWindowManager.startObservingKeys()
    }
}
