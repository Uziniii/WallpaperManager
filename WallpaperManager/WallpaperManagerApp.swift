//
//  WallpaperManagerApp.swift
//  WallpaperManager
//
//  Created by Enzo Fleche on 09/04/2024.
//

import SwiftUI

@main
struct WallpaperManagerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {}
    }
}
