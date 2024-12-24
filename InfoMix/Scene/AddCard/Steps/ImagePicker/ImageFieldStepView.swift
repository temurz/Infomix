//
//  ImageFieldStepView.swift
//  Viessmann
//
//  Created by Temur on 10/04/22.
//  Copyright © 2022 Viessmann. All rights reserved.
//

import SwiftUI

struct ImageFieldStepView: AbstractStepView {
    @Binding var cardStepItem: AddCardStepItem
    @State var imageData: Data? = nil
    @State private var showImagePicker = false
    @State var imageChooserType: PickerImage.Source = .library
    var onDelete: ((AddCardStepItem) -> Void)?

    var body: some View {
            VStack {

                HStack{
                    Text(cardStepItem.titleLocalization())
                    Spacer()
                    Menu{
                        Button("Clear".localized(), action: {
                            cardStepItem.imageValue = nil
                            imageData = nil
                        })
                    }label: {
                        Image(systemName: "ellipsis")
                            .padding(10)
                    }
                }
                .padding([.horizontal,.top])

                if imageData != nil, let image = imageData {
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)

                } else {
                    ZStack{
                        Color.black.opacity(0.6).ignoresSafeArea(.all)
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.3)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.horizontal)
                        HStack(spacing: 0){
                            Spacer()
                            Button {
                                if !PickerImage.checkPermissions() {
                                    print("There is no camera on this device")
                                    return
                                }

                                imageChooserType = .camera
                                showImagePicker = true
                            } label: {
                                VStack(alignment: .center, spacing: 8){
                                   Image(systemName: "camera.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color.white)
                                    Text("Use camera".localized())
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                }
                            }
                            Spacer()
                            HStack{
                                Color.red
                            }.frame(width: 1)
                            Spacer()
                            Button {
                                imageChooserType = .library
                                showImagePicker = true
                            } label: {
                                VStack(alignment: .center, spacing: 8){
                                   Image(systemName: "folder.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color.white)
                                    Text("Use gallery".localized())
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                }
                            }
                            Spacer()
                        }
                    }

                }

            }
        .frame(maxWidth: .infinity,maxHeight: 200, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: self.imageChooserType == .library ? .photoLibrary : .camera, selectedImage: $cardStepItem.imageValue, bindedImage: $imageData)
                    .ignoresSafeArea()
            }

    }


}

struct ImageFieldStepView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFieldStepView(cardStepItem: .constant(AddCardStepItem(id: "", titleRu: "", value: "", remoteName: "", type: .CHOOSE_PHOTO, minLength: 0, maxLength: 0, cardStepId: 0, hasValidationError: true, titleUz: "", skip: true, productionCode: "", limit: 0, editable: true, valueString: "", originaltemId: "")))
    }
}
