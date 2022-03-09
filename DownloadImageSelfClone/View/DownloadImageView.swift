//
//  DownloadImageView.swift
//  DownloadImageSelfClone
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import SwiftUI

struct DownloadImageView: View {
    
    @StateObject var vm = DownloadImageViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { photo in
                    DownloadImageRowView(photo: photo)
                }
            }
            
            .navigationTitle("Download_Images")
        }
    }
}

struct DownloadImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageView()
    }
}
