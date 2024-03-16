//
//  SwiftUIView.swift
//  CleanArchitecture
//
//  Created by Temur on 20/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import URLImage


struct EventRow: View {
    let viewModel: EventItemViewModel
    let dateFormatter = DateFormatter()
    
    var body: some View {
        let url = URL(string:viewModel.imageUrl)
        VStack (spacing: 0) {
            ZStack{
                if let url = url {
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .centerCropped()
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        
                        AsyncImageEarly(
                            url: url,
                            placeholder: { ProgressView() },
                            image: { (Image(uiImage: $0)
                                .resizable()
                                )
                            }
                        )
                    }
                }
            }.frame(height: 200)
            
               
            HStack{
                VStack{
                    
                    if let date = viewModel.createDate{
                        Text(date.toShortFormat())
                            .foregroundColor(Color.gray)
                            .font(.caption2)
                    }
                    if let date = viewModel.endEventDate{
                        Text(date.toShortFormat())
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    Text("AKSIYA".localized())
                        .font(.caption2)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(4)
                        .background(Color.gray)
                        .cornerRadius(.infinity)
                }
                Divider()
                VStack (alignment: .leading, spacing: 0){
                    Text(viewModel.title)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .bold()
                    
                    Text(viewModel.shortDescription)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
            }.padding(6)
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(1)
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        let event = Event(id: 1, title: "Akfa", shortDescription: "iPhone", content: "", imageUrl: "car", endEventDate: Date(timeIntervalSince1970: 1640678898.0), createDate: Date(timeIntervalSince1970: 1640678898.0), type: EventType(id: 1, name: "Akfaa"), ads: false)
        return EventRow(viewModel: EventItemViewModel(event: event))
    }
}

