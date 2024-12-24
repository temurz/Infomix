//
//  ProductCategoryView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 07/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct ProductCategoryView: View {
    @ObservedObject var output: ProductCategoryViewModel.Output
    
    let selectTrigger = PassthroughSubject<IndexPath,Never>()
    let reloadTrigger = PassthroughSubject<Void,Never>()
    let loadTrigger = PassthroughSubject<Void,Never>()
    let closeTrigger = PassthroughSubject<Void,Never>()
    let backTrigger = PassthroughSubject<Void, Never>()
    let cancelBag = CancelBag()
    var body: some View {
        
        let categories = output.categories.enumerated().map{$0}
        
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack(spacing: 0) {
                CustomNavigationBar(title: output.filteredCategory != nil ? "Choose category".localized() : "Shop by department".localized(), rightBarTitle: "Cancel".localized()) {
                    backTrigger.send(())
                } onRightBarButtonTapAction: {
                    closeTrigger.send(())
                }

                List {
//                    Section {
                        ForEach(categories, id: \.element.id) { index, category in
                            Button(action: {
                                self.selectTrigger.send(IndexPath(row: index, section: 0))
                            }) {
                                HStack{
                                    Text(category.name)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.green)
                                }
                            }
                        }
//                    } header: {
//                        Spacer(minLength: 16).listRowInsets(EdgeInsets())
//                    }

                }
                .listStyle(.plain)
//                .environment(\.defaultMinListHeaderHeight, 16)
                .pullToRefresh(isShowing: self.$output.isReloading) {
                    self.reloadTrigger.send()
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
    }
    
    
    init(viewModel: ProductCategoryViewModel){
        self.output = viewModel.transform(ProductCategoryViewModel.Input(loadTrigger: self.loadTrigger.asDriver(), reloadTrigger: self.reloadTrigger.asDriver(), selectProductCategoryTrigger: self.selectTrigger.asDriver(), closeTrigger: self.closeTrigger.asDriver(), backTrigger: self.backTrigger.asDriver()), cancelBag: self.cancelBag)
        
        self.loadTrigger.send()
    }
    
}


struct ProductCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        
        let vm: ProductCategoryViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(),
                                                                      intent: ProductCategoryIntent(),filteredCategory: nil)
        
        ProductCategoryView(viewModel: vm)
    }
}
