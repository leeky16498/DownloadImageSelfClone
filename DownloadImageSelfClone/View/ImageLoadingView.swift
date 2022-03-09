//
//  ImageLoadingView.swift
//  DownloadImageSelfClone
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import SwiftUI

struct ImageLoadingView: View {
    
    @State var isLoading : Bool = true
    @StateObject var loader : ImageLoadingViewModel
    
    init(url : String, key : String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}
