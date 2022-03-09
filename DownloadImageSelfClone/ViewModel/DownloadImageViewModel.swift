//
//  DownloadImageViewModel.swift
//  DownloadImageSelfClone
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import Foundation
import Combine

class DownloadImageViewModel : ObservableObject {
    
    @Published var dataArray : [PhotoModel] = []
    
    let dataService = PhotoModelDataService.instance // 싱글톤 선언
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        dataService.$photos //싱글톤의 포토모델의 배열을 가져온다
            .sink { [weak self] (returnedPhotos) in
                DispatchQueue.main.async {
                    self?.dataArray = returnedPhotos // 네트워킹 작업과 관련되어 있으므로 비동기 처리
                }
            }
            .store(in: &cancellables)
    }
}
