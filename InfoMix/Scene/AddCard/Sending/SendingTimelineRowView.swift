//
//  SendingTimelineRowView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 25/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import MapKit

struct SendingTimelineRowView: View {
    @Binding var item: SendingTimeline
    @Binding private var title: String
    var body: some View {
        HStack {
            ZStack {
                Color.clear // effectively centers the text
                
                    Text("sdsasd")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                
            }
            .frame(width: 64)
            
            GeometryReader { geo in
                ZStack {
                    Color.clear
                    line(height: geo.size.height,
                         hasPrevious: item.id != SendingTimelineId.connect.rawValue,
                         hasNext: item.id != SendingTimelineId.done.rawValue)
                }
            }
            .frame(width: 10)
        
            VStack{
                Text(item.title)
            Text(title)
            }.frame(maxWidth:.infinity)
                .background(item.status == .loading ? Color.yellow : item.status == .error ? Color.red : item.status == .success ? Color.green: Color.orange)
                .cornerRadius(10)
                .padding(6)
            
        }
        
        
    }
    
    init(item: Binding<SendingTimeline>){
        self._item = item
        self._title = item.title
    }
    
    // this methods implements the rules for showing dots in the
    // timeline, which might differ based on requirements
    @ViewBuilder private func line(height: CGFloat,
                                   hasPrevious: Bool,
                                   hasNext: Bool) -> some View {
        let lineView = Rectangle()
            .foregroundColor(.black)
            .frame(width: 2)
        let dot = Circle()
            .fill(Color.blue)
            .frame(width: 8,
                   height: 8)
        let halfHeight = height / 2
        let quarterHeight = halfHeight / 2
        if hasPrevious && hasNext {
            lineView
            dot
        } else if hasNext {
            lineView
                .frame(height: halfHeight)
                .offset(y: quarterHeight)
            dot
        } else if hasPrevious {
            lineView
                .frame(height: halfHeight)
                .offset(y: -quarterHeight)
            dot
        } else {
            dot
        }
    }
    
}

struct SendingTimelineRowView_Previews: PreviewProvider {
    @State static var i = SendingTimeline(id: "1", title: "")
    static var previews: some View {
        SendingTimelineRowView(item: $i)
    }
}
