//
//  ImageLoadingViewModel.swift
//  DownloadImageSelfClone
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    let manager = PhotoCacheSaveManager.instance
    
    let urlString : String
    let imageKey : String
    
    init(url : String, key : String) {
        imageKey = key
        urlString = url
        getImage()
    }
    
    func getImage() {
        
        if let saveImage = manager.get(key: imageKey) {
            image = saveImage
            print("Getting saved Image")
        } else {
            downloadImages()
            print("Downloading Images")
        }
    }
    
    func downloadImages() {
        print("Donwnloading Images!")
        isLoading = true
        
        guard let url = URL(string: urlString)
        else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main) // 메인스레드로 부른다.
            .sink  { [weak self] (_) in
                self?.isLoading =  false
            } receiveValue: { [weak self ] (returnedImage) in
                guard let self = self,
                      let image = returnedImage else {return}
                self.image = returnedImage
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
    
}
