//
//  ConfirmView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct AddCardConfirmView: View {
    
    @ObservedObject var output: AddCardConfirmViewModel.Output
    
    let sendCardTrigger = PassthroughSubject<Void, Error>()
    let prevStepTrigger = PassthroughSubject<Void, Error>()
    
    let cancelBag = CancelBag()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Spacer()
                
            HStack{
                
                Spacer()
                Button(action: {
                    self.prevStepTrigger.send()
                }, label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Previous".localized())
                    }
                }).padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                    .background(Color.white)
                    .cornerRadius(.infinity)
                    .foregroundColor(Color.green)
                
                Button(action: {
                    self.sendCardTrigger.send()
                }, label: {
                    HStack{
                        Text("Sent".localized())
                        Image(systemName: "paperplane")
                        
                    }
                }).padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                    .background(Color.white)
                    .cornerRadius(.infinity)
                    .foregroundColor(Color.green)
                
                
            }.frame(height: 64, alignment: .top)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(RoundedCorner(color: Color.green, tl: 32, tr: 0, bl: 0, br: 0))
        
        }
        .navigationBarTitle("Add Card".localized())
            .edgesIgnoringSafeArea(.bottom)
    }
    
    init(viewModel: AddCardConfirmViewModel){
        let input = AddCardConfirmViewModel.Input(sendCardTrigger: self.sendCardTrigger.asDriver(), prevStepTrigger: self.prevStepTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: self.cancelBag)
    }
}

struct AddCardConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: AddCardConfirmViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), cardConfig: CardConfig(configCode: ""))
        return AddCardConfirmView(viewModel: vm)
    }
}
