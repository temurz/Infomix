//
//  UrlImage+.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation
import URLImage

enum URLImageStore{
    static var memory: URLImageInMemoryStore {
        return URLImageInMemoryStore()
    }
}
