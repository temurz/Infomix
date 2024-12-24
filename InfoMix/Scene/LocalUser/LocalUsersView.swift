//
//  LocalUserView.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 25/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import Combine

struct LocalUsersView: View {
    @ObservedObject var output: LocalUsersViewModel.Output
    private let cancelBag = CancelBag()
    private let reloadUsersTrigger = PassthroughSubject<Void, Never>()
    private let loadUsersTrigger = PassthroughSubject<Void,Never>()
    private let addAccountTrigger = PassthroughSubject<Void,Never>()
    private let popViewTrigger = PassthroughSubject<Void,Never>()
    private let activeTrigger = PassthroughSubject<LocalUser, Never>()
    private let token = UserDefaults.standard.string(forKey: "token") ?? ""
    var body: some View {
        
        
        return LoadingView(isShowing: $output.isLoading, text: .constant("")){
            
            VStack{
                CustomNavigationBar(title: "Local user List".localized()) {
                    popViewTrigger.send(())
                }
                List(output.certificates.enumerated().map { $0 }, id: \.element.id){ index, localUser in
                    LocalUserRow(localUser: localUser, currentUserToken: token) {
                        localUser in
                        self.activeTrigger.send(localUser)
                    }
                }
                .pullToRefresh(isShowing: self.$output.isReloading) {
                    self.reloadUsersTrigger.send()
                }
                
            }
            
        }
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button("Add".localized()){
                    self.addAccountTrigger.send(())
                }
            }
        }
        
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear(perform: {
            self.loadUsersTrigger.send(())
        })
       
    }
    
   
    
    
    init(viewModel: LocalUsersViewModel) {
        let input = LocalUsersViewModel.Input(
            loadUsersTrigger: self.loadUsersTrigger.asDriver(),
            reloadUsersTrigger: self.reloadUsersTrigger.asDriver(),
            activeTrigger: self.activeTrigger.eraseToAnyPublisher(),
            addAccountTrigger: self.addAccountTrigger.asDriver(),
            popViewTrigger: popViewTrigger.asDriver()
        )

        self.output = viewModel.transform(input, cancelBag: cancelBag)
       
    }
}

struct LocalUsersView_Previews: PreviewProvider {
    static var previews: some View {
        LocalUsersView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController(), cardConfig: CardConfig(configCode: "AA001")))
    }
}
