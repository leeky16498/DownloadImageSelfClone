//
//  PhotoModelFileManager.swift
//  DownloadImageSelfClone
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import Foundation
import SwiftUI

class PhotoFileManager {
    
    static let instance = PhotoFileManager()
    let folderName : String = "download_cache_imagefiles"
    
    private init() {
        createFoldersIfNeeded()
    }
    
    func makeFolderPath() -> URL? {
        
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    } // 캐시 자료로 저장될 폴더의 주소를 생성해준다.
    
    func createFoldersIfNeeded() {
        guard let url = makeFolderPath() else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error{
                print("Error creating folders")
            }
        }
    } // 폴더를 생성해준다.
    
    func makeImagePath(key : String) -> URL? {
        guard let folder = makeFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key + ".png")
    } // 이미지의 저장경로와 형태를 생성한다. 이미지를 키를 통해서 구분하고 뒤에 확장자를 다음과 같이 붙여서 저장해 줄 것이다.
    
    func addImage(key: String, value : UIImage) {
        guard let data = value.pngData(),
              let url = makeImagePath(key: key) else {return}
        do {
            try data.write(to: url)
        } catch {
            print("Error to save the file")
        }
    }
    
    func getImage(key : String) -> UIImage? {
        guard let url = makeImagePath(key: key),
              FileManager
                .default
                .fileExists(atPath: url.path) else {
                    return nil
                }
        return UIImage(contentsOfFile: url.path)
    }
}
