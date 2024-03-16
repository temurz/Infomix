//
//  LocalUserRow.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI

struct LocalUserRow: View {
    
    let localUser: LocalUser
    let currentUserToken: String
    let onActive: (_ localUser:LocalUser)->Void
    
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4){
            Text(String.init(format: "%@ %@", localUser.firstName ?? "", localUser.lastName ?? ""))
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Text(String(format: "Certificate: %@".localized(), localUser.certificate ?? ""))
                    .font(.caption)
                Spacer()
                Text(String(format: "Service: %@".localized(), localUser.serviceName ?? ""))
                    .font(.caption)
            }
            
            Text(String(format: "Last activation: %@".localized(), localUser.lastActivation?.toApiFormat() ?? "" ))
                    .font(.caption).frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            if currentUserToken == localUser.token {
                Text("Current account".localized())
                    .foregroundColor(.green)
                    .font(.subheadline)
                    .padding(.vertical)
            }else {
                Button {
                    self.onActive(localUser)
                } label: {
                    Text("Active".localized())
                        .font(.subheadline)
                        .bold()
                }.foregroundColor(.green)
                    .padding(.vertical)
            }

        }
            .buttonStyle(PlainButtonStyle())
    }
}

struct LocalUserRow_Previews: PreviewProvider {
    static var previews: some View {
        LocalUserRow(localUser: LocalUser(), currentUserToken: "213") {
            _ in
        }
    }
}
