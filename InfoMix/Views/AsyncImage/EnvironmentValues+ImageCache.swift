//
//  EnvironmentValues+ImageCache.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 14/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
