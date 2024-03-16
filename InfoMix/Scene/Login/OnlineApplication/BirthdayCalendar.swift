//
//  BirthdayCalendar.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct BirthdayCalendar: View {
    @State var date: Date
    @State var dateId: UUID = UUID()
    let action: (_ date: Date) -> Void
    var body: some View {
        VStack{
            HStack{
                DatePicker("Birthday".localized(), selection: $date, in: ...Date(),displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: Localize.currentLanguage()))
                .id(dateId)
//                .onChange(of: date, perform: { newValue in
//                    dateId = UUID()
//                })
            }
            
            Button(action: {
                self.action(date)
            }) {
                HStack{
                    
                    Text("Confirm".localized())
                    
                }.font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color(.systemGreen))
                    .cornerRadius(10.0)
            }.padding()
        }.padding()
    }
    
    
}

struct BirthdayCalendar_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayCalendar(date: Date()){birthday in 
            
        }
        
    }
}
