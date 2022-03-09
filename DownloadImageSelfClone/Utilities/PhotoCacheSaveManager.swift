//
//  PhotoCacheSaveManager.swift
//  DownloadImageSelfClone
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import Foundation
import SwiftUI

class PhotoCacheSaveManager {
    
    static let instance = PhotoCacheSaveManager()
    
    private init() {
        
    }
    
    var photoCache : NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200 // 200개 이미지 캐시 저장
        cache.totalCostLimit = 1024*1024*200 // 200mb만큼의 용량을 캐시에 저장
        return cache
    }()
    
    func add(key : String, value : UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key : String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }

    
}
