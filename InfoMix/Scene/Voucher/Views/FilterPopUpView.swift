//
//  FilterPopUpView.swift
//  InfoMix
//
//  Created by Temur on 19/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct FilterPopUpView: View {
    @Binding var fromDate: Date
    @Binding var toDate: Date
    var cancelAction: (() -> Void)?
    var updateAction: (() -> Void)?
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
                        Text("Filter".localized())
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
                    
                    VStack(spacing: 16) {
                        DatePicker(selection: $fromDate, in: ...Date.now, displayedComponents: .date) {
                            Text("From".localized())
                                   }
                        DatePicker(selection: $toDate, in: ...Date.now, displayedComponents: .date) {
                            Text("To".localized())
                                   }
                        
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        Button {
                            fromDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                            toDate = Date()
                            updateAction?()
                        } label: {
                            Text("Clear".localized())
                                .foregroundStyle(.primary)
                        }
                        .padding(.horizontal)
                        Button {
                            updateAction?()
                        } label: {
                            Text("OK")
                                .foregroundStyle(.primary)
                        }
                    }
                    .padding()
                }
                .background(.white)
                .cornerRadius(radius: 12, corners: .allCorners)
                .padding()
                Spacer()
            }
            
            
        }
    }
}
