//
//  PopUpServices.swift
//  InfoMix
//
//  Created by Temur on 29/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI

struct PopUpServices: View {
    @Binding var configs: [CardConfig]
    @Binding var show : Bool
    var action : (_ chosenConfig: CardConfig) -> Void
    var body: some View {
        ZStack{
            if show{
                Color.black.opacity(0.3).ignoresSafeArea(.all)

                VStack(alignment: .leading, spacing: 0){
                    VStack(alignment: .leading){
                        HStack{

                            Text("Choose a service".localized())
                                .padding(.horizontal)
                            Spacer()
                            Button{
                                show = false
                            }label: {
                                Image(systemName: "multiply.circle")
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .frame(width: 340, height: 40)
                    .background(Color.white)
                    .padding([.horizontal,.top])
                    VStack(alignment: .leading){
                        ForEach(configs.indices){
                            config in
                            Button {
                                show = false
                                action(configs[config])
                            } label: {
                                if let title = configs[config].title, configs[config].titleTranslations?.count ?? 0 < 1 {
                                    HStack{
                                        Text(title)
                                            .foregroundColor(.black)
                                            .padding()
                                        Spacer()
                                    }
                                }else {
                                    switch UserDefaults.standard.object(forKey: "LCLCurrentLanguageKey") as?     String {
                                    case "ru":
                                        var title: String?
                                        if let translations = configs[config].titleTranslations {
                                            let _ = translations.forEach { translation in
                                                if translation.locale == "ru" {
                                                    title = translation.value
                                                }
                                            }
                                            if let title = title {
                                                HStack{
                                                    Text(title)
                                                        .foregroundColor(.black)
                                                        .padding()
                                                    Spacer()
                                                }
                                            }
                                        }
                                    case "uz":
                                        var title: String?
                                        if let translations = configs[config].titleTranslations {
                                            let _ = translations.forEach { translation in
                                                if translation.locale == "uz" {
                                                    title = translation.value
                                                }
                                            }
                                            if let title = title {
                                                HStack{
                                                    Text(title)
                                                        .foregroundColor(.black)
                                                        .padding()
                                                    Spacer()
                                                }
                                            }
                                        }
                                    default:
                                        var title: String?
                                        if let translations = configs[config].titleTranslations {
                                            let _ = translations.forEach { translation in
                                                if translation.locale == "en" {
                                                    title = translation.value
                                                }
                                            }
                                        }
                                        HStack {
                                            Text(title ?? "")
                                                .foregroundColor(.black)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                }
                            }

                        }
                    }
                    .frame(width: 340)
                    .background(Color(.systemGray6))
                    .padding([.horizontal,.bottom])
                }
            }
        }
    }
}

struct PopUpServices_Previews: PreviewProvider {
    static var previews: some View {
        PopUpServices(configs: .constant([CardConfig]()), show: .constant(false), action: {config in

        })
    }
}
