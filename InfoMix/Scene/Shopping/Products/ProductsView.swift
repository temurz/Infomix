//
//  ProductsView.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/20/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIRefresh
import BottomSheet
import URLImage
import AVFAudio


struct ProductsView: View {
    
    @State var index = 0
    @ObservedObject var output: ProductsViewModel.Output
    @State private var showCancelButton: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let cancelBag = CancelBag()
    private let loadTrigger = PassthroughSubject<Void, Never>()
    private let loadShoppingCartTrigger = PassthroughSubject<Void, Never>()
    private let loadMoreTrigger  = PassthroughSubject<Void, Never>()
    private let reloadTrigger = PassthroughSubject<Void, Never>()
    private let selectTrigger = PassthroughSubject<Int, Never>()
    private let addToCartTrigger = PassthroughSubject<Void, Never>()
    private let showShoppingCartTrigger = PassthroughSubject<Void, Never>()
    private let showProductCategoryList = PassthroughSubject<Void, Never>()
    private let clearProductCategoryFilter = PassthroughSubject<Void, Never>()
    private let popViewTrigger = PassthroughSubject<Void, Never>()

    @State private var isScrolling = false

    var body: some View {
        
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "Product List".localized(), rightBarTitle: "Refresh".localized()) {
                    popViewTrigger.send(())
                } onRightBarButtonTapAction: {
                    loadTrigger.send()
                }

                ScrollView{
                    VStack(alignment: .leading, spacing: 6) {
                        // Search view
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                
                                TextField("search", text: $output.query, onEditingChanged: { isEditing in
                                    self.showCancelButton = true
                                }, onCommit: {
                                    self.loadTrigger.send()
                                }).foregroundColor(.primary)
                                
                                Button(action: {
                                    output.query = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill").opacity(output.query == "" ? 0 : 1)
                                }
                            }
                            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                            .foregroundColor(.secondary)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10.0)
                            
                            if showCancelButton  {
                                Button("Cancel".localized()) {
                                    UIApplication.shared.endEditing(true)
                                    self.output.query = ""
                                    self.showCancelButton = false
                                    self.loadTrigger.send()
                                }
                                .foregroundColor(Color(.systemBlue))
                            }
                        }.padding( 6)
                        
                        
                        HStack{
                            
                            Button {
                                self.showProductCategoryList.send()
                            } label: {
                                HStack{
                                    Text(output.category?.name ?? "Choose category".localized())
                                    
                                    if output.category == nil {
                                        Image(systemName: "chevron.compact.down")
                                    }
                                }.font(.caption2)
                                    .foregroundColor(.gray)
                                    .padding(6)
                            }
                            
                            if output.category != nil {
                                
                                Button {
                                    self.clearProductCategoryFilter.send()
                                } label: {
                                    Image(systemName: "xmark")
                                        .padding(6)
                                }.font(.caption2)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                        .background(RoundedCorner(color: Color(.systemGray6), tl: 10, tr: 10, bl: 10, br: 10))
                            .padding(6)
                        
                        
                        
                    }
                    .background(Color(.systemBackground))
                    
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(output.products, id: \.id) {product in
                            
                            Button(action: {
                                self.selectTrigger.send(product.id)
                            }) {
                                ProductRow(viewModel: product)
                            } .onAppear {
                                if self.output.products.last?.id ?? -1 == product.id && output.hasMorePages { // 6
                                    self.loadMoreTrigger.send()
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
//                    .resignKeyboardOnDragGesture()
                    .padding(.horizontal, 6)
                    
                    if output.hasMorePages {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding()
                    }
                    
                }
                .gesture(
                    DragGesture()
                        .onChanged { _ in isScrolling = true }
                        .onEnded { _ in isScrolling = false }
                )
                .frame(maxHeight: .infinity)
                if output.shoppingCart.totalProducts > 0 {
                    HStack{
                        Button {
                            self.showShoppingCartTrigger.send()
                        } label: {
                            HStack(spacing: 4){
                                
                                Text("Cart".localized())
                                
                                HStack{
                                    Text(String(output.shoppingCart.totalProducts)+" items".localized())
                                        .padding(.horizontal, 6)
                                        .font(.caption2)
                                }.frame(height: 20)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                
                                Spacer()
                                
                                Text(output.shoppingCart.totalAmount.groupped(fractionDigits: 0, groupSeparator: " ")+" ball".localized())
                            }
                            .padding(12)
                            .background(Color.orange)
                            .foregroundColor(Color.black)
                            .cornerRadius(5)
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .padding(.bottom, 32)
                        .frame(maxWidth: .infinity)
                    }.background(Color.white)
                        .shadow(radius: 2)
                }
                
            }
        }
        .onAppear(perform: {
            self.loadShoppingCartTrigger.send()
        })
//        .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
        .background(.clear)
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .bottomSheet(bottomSheetPosition: $output.bottomSheetPosition, options: [.swipeToDismiss, .tapToDissmiss, .noBottomPosition, .background(AnyView(Color.white)), .backgroundBlur(effect: .dark)]) {
            ProductDetailView(productItemModel: $output.showingProductItemModel, quantity: $output.quantity, isLoading: $output.isAdding) {
                self.addToCartTrigger.send()
            }
        }
    }
    
    
    init(viewModel: ProductsViewModel) {
        let input = ProductsViewModel.Input(
            loadShoppingCartTrigger: self.loadShoppingCartTrigger.eraseToAnyPublisher(),
            loadTrigger: loadTrigger.eraseToAnyPublisher(),
            reloadTrigger: reloadTrigger.eraseToAnyPublisher(),
            loadMoreTrigger: self.loadMoreTrigger.asDriver(),
            selectTrigger: selectTrigger.eraseToAnyPublisher(),
            addToCartTrigger: self.addToCartTrigger.asDriver(),
            showShoppingCartTrigger: self.showShoppingCartTrigger.asDriver(),
            showProductCategoryTrigger: self.showProductCategoryList.asDriver(),
            clearProductCategoryFilter: self.clearProductCategoryFilter.asDriver(),
            popViewTrigger: self.popViewTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        
        self.loadTrigger.send()
    }
    
}

struct ProductsView_Preview: PreviewProvider {
    static var previews: some View {
        let viewModel: ProductsViewModel = PreviewAssembler().resolve(
            navigationController: UINavigationController(), category: nil)
        
        return ProductsView(viewModel: viewModel)
    }
}
