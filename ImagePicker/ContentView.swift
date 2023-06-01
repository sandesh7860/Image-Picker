//
//  ContentView.swift
//  ImagePicker
//
//  Created by San Dy on 01/08/2022.
//
import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var selectItems: [PhotosPickerItem] = []
    @State var data: Data?
    var body: some View {
        VStack {
            if let data = data, let uiimage = UIImage(data: data) {
                Image(uiImage: uiimage)
                    .resizable()
                    .ignoresSafeArea()
                
            }
            Spacer()
            PhotosPicker(
                selection: $selectItems,
                maxSelectionCount: 1,
                matching: .images
            ){
                Text("Pick Image")
            }
            .onChange(of: selectItems) { newValue in
                guard let item = selectItems.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self.data = data
                        } else {
                            print("Data is nil")
                        }
                    case .failure(let error):
                        fatalError("\(error)")
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

