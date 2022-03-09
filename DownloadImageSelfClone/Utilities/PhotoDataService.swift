//
//  PhotoDataService.swift
//  DownloadImageSelfClone
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import Foundation
import SwiftUI
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    
    @Published var photos : [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {fatalError()}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading Data")
                }
            } receiveValue: { [weak self] (returnedData) in
                print(returnedData)
                self?.photos = returnedData
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output : URLSession.DataTaskPublisher.Output) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw URLError(.badServerResponse)
              }
        return output.data
        
        
    }
    
}
