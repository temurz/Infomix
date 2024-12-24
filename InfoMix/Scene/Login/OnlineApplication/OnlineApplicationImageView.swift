//
//  OnlineApplicationImageView.swift
//  InfoMix
//
//  Created by Temur A. Zaitov on 23/12/24.
//  Copyright © 2024 InfoMix. All rights reserved.
//
import Foundation
import SwiftUI

struct OnlineApplicationImageView: View{
    @ObservedObject var output: OnlineApplicationViewModel.Output
    @State var title : String
    @Binding var selectedImage : Data
    @State private var showImagePicker = false

    var body: some View {
            VStack {

                HStack{
                    Text(title)
                    Spacer()
                    Menu{
                        Button("Clear".localized(), action: {
                            selectedImage = Data()
                        })
                    }label: {
                        Image(systemName: "ellipsis")
                            .padding(10)
                    }
                }
                .padding([.horizontal,.top])

                if !selectedImage.isEmpty {
                    Image(uiImage: UIImage(data: selectedImage)!)
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

                                output.imageChooserType = .camera
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
                                output.imageChooserType = .library
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
                ImagePicker1(sourceType: output.imageChooserType == .library ? .photoLibrary : .camera, selectedImage: $selectedImage)
                    .ignoresSafeArea()
            }

    }

}

struct ImagePicker1: UIViewControllerRepresentable {


    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: Data
    @Environment(\.presentationMode) private var presentationMode
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker1>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker1>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker1
        init(_ parent: ImagePicker1) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
                if let res = resizedImage{
                    parent.selectedImage = res.jpegData(compressionQuality: 0.5) ?? Data()
                }

            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
