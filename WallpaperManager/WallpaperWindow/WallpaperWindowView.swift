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

class SelectedWallpaper: ObservableObject {
    @Published var number = 0
}

struct WallpaperWindowView: View {
    public struct WallpaperImage: Identifiable {
        var id: String
    }

    private let fileManager = FileManager()
    public var wallpaperDir: String
    @ObservedObject public var selectedWallpaper = SelectedWallpaper()
    @State public var images: [WallpaperImage]
    
    init() {
        self.wallpaperDir = fileManager.homeDirectoryForCurrentUser.appending(path: "wallpaper/").path()
        self.images = try! self
            .fileManager
            .contentsOfDirectory(atPath: self.wallpaperDir)
            .filter({ $0.hasSuffix(".png") || $0.hasSuffix(".jpg") })
            .map({ WallpaperImage(id: $0) })
    }
    
    mutating func nextWallpaper() {
        if self.selectedWallpaper.number + 1 > self.images.count - 1 {
            self.selectedWallpaper.number = 0
            return
        }
        
        self.selectedWallpaper.number += 1
    }
    
    mutating func previousWallpaper() {
        if self.selectedWallpaper.number - 1 < 0 {
            self.selectedWallpaper.number = self.images.count - 1
            return
        }
        
        self.selectedWallpaper.number -= 1
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                Image(nsImage: NSImage(contentsOfFile: self.wallpaperDir + self.images[self.selectedWallpaper.number].id) ?? NSImage())
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
