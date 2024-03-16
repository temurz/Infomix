//
//  ImageCache.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import SwiftUI

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
