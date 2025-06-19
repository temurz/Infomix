//
//  CertificateInfo.swift
//  InfoMix
//
//  Created by Temur on 19/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI

struct CertificateInfo: View {
    let model: CertificateItemViewModel
    var cancelAction: (() -> Void)?
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .onTapGesture {
                    cancelAction?()
                }
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    HStack {
                        Text("Certificate".localized())
                        Spacer()
                        Button {
                            cancelAction?()
                        } label: {
                            Image(systemName: "x.circle")
                                .centerCropped()
                                .tint(.black)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding()
                    QrCodeGeneratedView(value: model.certificateCode)
                    VStack(spacing: 16) {
                        VStack {
                            Text(model.agentFullName)
                                .font(.title3)
                                .bold()
                            Text(model.serviceName)
                        }
                        VStack {
                            Text("Certificate number".localized())
                                .font(.caption)
                            Text(model.certificateCode)
                                .font(.footnote)
                                .bold()
                        }
                        VStack {
                            Text("Phone".localized())
                                .font(.caption)
                            Text(model.phoneNumber)
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .padding(.bottom)
                }
                .background(.white)
                .padding()
                Spacer()
            }
            
            
        }
    }
}
