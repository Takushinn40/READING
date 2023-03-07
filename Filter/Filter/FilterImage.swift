//
//  FilterImage.swift
//  Filter
//
//  Created by cmStudent on 2023/03/06.
//

import SwiftUI

struct FilterImage: View {
    enum FilterType: String {
    case pixellate = "モザイク"
    case sepiaTone = "セピア"
    case sharpenLuminance = "シャープ"
    case photoEffectMono = "モノクロ"
    case gaussianBlur = "ブラー"
    }
    @State private var image: Image?
    let filterType: FilterType
    @Binding var selectingFilter: FilterType?
    let uiimage: UIImage? = UIImage(named: "photo_icon")
    var body: some View {
        Button(action: {
            selectingFilter = filterType
        }) {
            VStack {
                image?
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
            }
        }
        .frame(width: 70, height: 80)
        .border(Color.white, width: selectingFilter == filterType ? 4 : 0)
        .onAppear(perform: loadImage)
    }

    func loadImage() {
       guard let inputImage = uiimage else { return }
        DispatchQueue.global(qos: .background).async {
            if let outimage =  self.filterType.filter(inputImage: inputImage) {
                
                DispatchQueue.main.async {
                    self.image = Image(uiImage: outimage)
                }
            }
        }
    }
}


struct FileterImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .pixellate, selectingFilter: .constant(nil))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("pixellate")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .sepiaTone, selectingFilter: .constant(nil))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("sepiaTone")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .sharpenLuminance, selectingFilter: .constant(nil))
                    .previewLayout(.fixed(width: 200, height: 200))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("sharpenLuminance")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .photoEffectMono, selectingFilter: .constant(nil))
                    .previewLayout(.fixed(width: 200, height: 200))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("photoEffectMono")
            HStack {
                Image("photo_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                FilterImage(filterType: .gaussianBlur, selectingFilter: .constant(nil))
                    .previewLayout(.fixed(width: 200, height: 200))
                
            }
            .previewLayout(.fixed(width: 200, height: 200))
            .previewDisplayName("gaussianBlur")
            
        }
    }
}
