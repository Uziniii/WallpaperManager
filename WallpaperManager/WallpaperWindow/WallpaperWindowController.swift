//
//  WallpaperWindowController.swift
//  WallpaperManager
//
//  Created by Enzo Fleche on 10/04/2024.
//

import SwiftUI
import Foundation

class WallpaperWindowController {
    private var panel: NSPanel?
    private var contentView: WallpaperWindowView?
    
    func open() {
        let panel = NSPanel(
            contentRect: .zero,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: true,
            screen: .main
        )
        
        self.contentView = WallpaperWindowView()
        
        panel.level = .screenSaver
        panel.contentView = NSHostingView(
            rootView: contentView
        )

        let screen = NSScreen.main?.frame.size
        let screenWidth = screen?.width ?? 1
        let screenHeight = screen?.height ?? 1
        let width = screenWidth / 3
        let height = screenHeight / 3
        
        panel.setContentSize(NSSize.init(width: width, height: height))
        panel.setFrame(
            CGRect(
                x: screenWidth / 2 - width / 2,
                y: screenHeight / 2 - height / 2,
                width: width,
                height: height
            ),
            display: true
        )
        panel.orderFrontRegardless()
        panel.backgroundColor = .clear
        panel.isOpaque = false
        
        self.panel = panel
    }
    
    func close() {
        if let view = self.contentView {
            try! NSWorkspace.shared.setDesktopImageURL(
                URL.init(filePath: view.wallpaperDir + view.images[view.selectedWallpaper.number].id),
                for: NSScreen.main!
            )

            self.panel?.close()
            self.panel = nil
            self.contentView = nil
        }
    }
    
    func nextWallpaper() {
        self.contentView?.nextWallpaper()
    }
    
    func previousWallpaper() {
        self.contentView?.previousWallpaper()
    }
}
