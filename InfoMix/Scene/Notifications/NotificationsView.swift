//
//  NotificationsView.swift
//  CleanArchitecture
//
//  Created by Temur on 22/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct NotificationsView: View {
    
    @ObservedObject var output : NotificationsViewModel.Output
    private let cancelBag = CancelBag()
    private let reloadNotificationsTrigger = PassthroughSubject<Void, Never>()
    private let loadMoreNotificationsTrigger = PassthroughSubject<Void,Never>()
    private let loadNotificationsTrigger = PassthroughSubject<Void,Never>()
    private let popViewTrigger = PassthroughSubject<Void,Never>()
    private let moreActionTrigger = PassthroughSubject<NotificationsItemViewModel,Never>()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "Notifications".localized()) {
                    popViewTrigger.send()
                }
                

                ScrollView {
                    LazyVStack(spacing: 8){
                        ForEach(output.notifications) { notification in

                            NotificationsRow(viewModel: notification) {
                                self.moreActionTrigger.send(notification)
                            }
                                .padding(.horizontal, 12)
                                .onAppear {
                                    if output.notifications.last?.id ?? -1 == notification.id && output.hasMorePages {
                                        self.loadMoreNotificationsTrigger.send()
                                    }
                                }
                        }
                        if output.hasMorePages {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }

                    }
                    .padding(.top,40)
                }
                .onAppear {
                    self.loadNotificationsTrigger.send()
                }
            }
        }
        
    }
    
    
    init(viewModel: NotificationsViewModel){
        let input = NotificationsViewModel.Input(
            loadNotificationsTrigger: self.loadNotificationsTrigger.asDriver(),
            reloadNotificationsTrigger: self.reloadNotificationsTrigger.asDriver(),
            loadMoreNotificationsTrigger: self.loadMoreNotificationsTrigger.asDriver(),
            popViewTrigger: popViewTrigger.asDriver(),
            moreActionTrigger: self.moreActionTrigger.asDriver())

        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel : NotificationsViewModel = PreviewAssembler().resolve(navigationController: UINavigationController())
        NotificationsView(viewModel: viewModel)
    }
}
