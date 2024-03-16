//
//  NotificationsRow.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI

struct NotificationsRow: View {
    let viewModel : NotificationsItemViewModel
    let moreAction: ()->Void
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Text(viewModel.title)
                    .foregroundColor(Color.black)
                Spacer()
                if let date = viewModel.createDate {
                    Text(date.toShortFormat())
                        .foregroundColor(Color.gray)
                }
            }
            HStack{
                Text(viewModel.content)
                    .multilineTextAlignment(.leading)
                //                    .frame(alignment: .leading)
                    .foregroundColor(Color.black)
                
            }
            if [Subject.ORDER, Subject.EVENT,Subject.SCORE].contains(viewModel.notification.subject){
                HStack(){
                    Spacer()
                    Button {
                        self.moreAction()
                    } label: {
                       
                            Text("More".localized())
                                .font(.caption)
                                .foregroundColor(.green)
                                .padding(4)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.green))
                        
                    }
                }
                
            }
            
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct NotificationsRow_Previews: PreviewProvider {
    static var previews: some View {
        let notification = Notifications(id: 1, subject: Subject(rawValue: "")!, title: "", content: "", createDate: Date(), objectId: 1)
        NotificationsRow(viewModel: NotificationsItemViewModel(notification: notification)){}
    }
}
