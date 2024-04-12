//
//  WallpaperWindowView.swift
//  WallpaperManager
//
//  Created by Enzo Fleche on 10/04/2024.
//

import SwiftUI

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
}

struct WallpaperWindowView: View {
    private struct WallpaperImage: Identifiable {
        var id: String
    }

    private let fileManager = FileManager()
    private var wallpaperDir: String
    @State private var images: [WallpaperImage]
    
    init() {
        self.wallpaperDir = fileManager.homeDirectoryForCurrentUser.appending(path: "wallpaper/").path()
        self.images = try! self
            .fileManager
            .contentsOfDirectory(atPath: self.wallpaperDir)
            .filter({ $0.hasSuffix(".png") || $0.hasSuffix(".jpg") })
            .map({ WallpaperImage(id: $0) })
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                Image(nsImage: NSImage(contentsOfFile: self.wallpaperDir + images[0].id) ?? NSImage())
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .addBorder(
            Color(red: 0.29, green: 0.29, blue: 0.452),
            width: 2,
            cornerRadius: 16
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}

let screen = NSScreen.main?.frame.size
let width = screen?.width ?? 1
let height = screen?.height ?? 1

#Preview("Defaults", traits: .fixedLayout(width: width / 3, height: height / 4)) {
    WallpaperWindowView()
}
