//
//  MyCardsDatePicker.swift
//  InfoMix
//
//  Created by Temur on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct MyCardsDatePicker: View {
    @State var from: Date
    @State var to: Date
    @State var fromCalendarId: UUID = UUID()
    @State var toCalendarId: UUID = UUID()
    let action: (_ from: Date, _ to: Date) -> Void
    
    var body: some View {
        VStack(alignment: .trailing){
           
            DatePicker("Date of start".localized(), selection: $from, in: ...Date(), displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: Localize.currentLanguage()))
                .id(fromCalendarId)
                .onChange(of: from, perform: { newValue in
                    fromCalendarId = UUID()
                })
                .padding()
            
            DatePicker("Date of end".localized(), selection: $to, in: ...Date(),displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: Localize.currentLanguage()))
                .id(toCalendarId)
                .onChange(of: to, perform: { newValue in
                    toCalendarId = UUID()
                })
                .padding()
            
            
            Button(action: {
                self.action(from,to)
            }) {
                HStack{
                    
                    Text("Filter".localized())
                    
                }.font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color(.systemGreen))
                    .cornerRadius(10.0)
            }.padding()
           
        }
        .padding([.horizontal],10)
    }
}

struct MyCardsDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsDatePicker(from: Date(), to: Date()){from, to in
            
        }
    }
}
