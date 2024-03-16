//
//  ShoppingView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 06/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import BottomSheet

struct ShoppingView: View {
    
    @ObservedObject var output: ShoppingViewModel.Output
    
    let loadShoppingCartTrigger =  PassthroughSubject<Void,Never>()
    let loadTopProductsTrigger = PassthroughSubject<Void, Never>()
    let showShopByDepartmentTrigger = PassthroughSubject<Void,Never>()
    let showProductListTrigger = PassthroughSubject<Void,Never>()
    let showOrderHistoryTrigger = PassthroughSubject<Void,Never>()
    let showShoppingCartTrigger = PassthroughSubject<Void, Never>()
    let addToCartTrigger = PassthroughSubject<Void, Never>()
    let showProductDetailTrigger = PassthroughSubject<Int,Never>()
    let cancelBag = CancelBag()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            
            Color(.systemGray6)
            
            RoundedCorner(color: .green, tl: 0, tr: 0, bl: 0, br: 60)
                .frame(maxWidth: .infinity, maxHeight: 240)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                Text(output.certificate.agentFullName)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding([.horizontal,.top], 20)
                
                Text("You ".localized() + "\(output.certificate.balance.groupped(fractionDigits: 0, groupSeparator: " "))" + "balls".localized())
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 5) {
                    HStack{
                        Text(output.certificate.serviceName.localized())
                            .font(.headline)
                            .frame(maxWidth:.infinity,alignment: .leading)
                        
                        Button {
                            self.showOrderHistoryTrigger.send()
                        } label: {
                            HStack{
                                Text("History".localized())
                            }
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.green))
                        }
                    }
                    .padding(12)
                    
                    Divider()
                    
                    VStack{
                        
                        Text("In cart".localized())
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        if output.isLoadingShoppingCart {
                            ProgressView()
                                .frame(width: 64, height: 64)
                                .progressViewStyle(.circular)
                        }else {
                            Image(systemName: "cart.fill")
                                .resizable()
                                .foregroundColor(.green)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 64, height: 64)
                        }
                        
                        Text(!output.isLoadingShoppingCart ? "\(output.shoppingCart.entryCount)" + " " + "Product".localized() : "Loading...".localized())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(!output.isLoadingShoppingCart ? "\(output.shoppingCart.totalAmount.groupped(fractionDigits: 0, groupSeparator: " ")) ball" : " ")
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Button(action: {
                            self.showShoppingCartTrigger.send()
                        }) {
                            HStack {
                                Text("View".localized())
                                Image(systemName: "eye")
                            }.font(.subheadline)
                        }
                        .padding(6)
                        .disabled(output.isLoadingShoppingCart)
                        .foregroundColor(.white)
                        .background(output.isLoadingShoppingCart ? Color.gray: Color.green)
                        .cornerRadius(.greatestFiniteMagnitude)
                    }.padding()
                    
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(20)
                
//                Button(action: {
//                    self.showShopByDepartmentTrigger.send()
//                }) {
//                    HStack {
//                        Text("Shop by department".localized())
//                            .foregroundColor(.black)
//                        Spacer()
//                        Image(systemName: "bag.fill")
//                            .foregroundColor(.green)
//                        Image(systemName: "arrow.right")
//                            .foregroundColor(.green)
//                    }.font(.subheadline)
//                        .padding(16)
//                        .frame(maxWidth:.infinity)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//                    .shadow(radius: 4)
                
                
                VStack(spacing: 5) {
                    HStack(spacing: 5){
                        Text("Top products".localized())
                            .font(.headline)
                            .frame(maxWidth:.infinity,alignment: .leading)
                        
                        
                        Button {
                            self.showProductListTrigger.send()
                        } label: {
                            HStack{
                                Text("All products".localized())
                                Image(systemName: "arrow.right")
                            }
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.green))
                        }
                    }
                    .padding(12)
                    
                    Divider()
                    
                    if output.isLoadingTopProducts {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding()
                    } else {
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(output.products, id: \.id) {product in
                                
                                Button(action: {
                                    self.showProductDetailTrigger.send(product.id)
                                }) {
                                    ProductRow(viewModel: product)
                                }
                            }
                        }
                        .resignKeyboardOnDragGesture()
                        .padding(.horizontal, 6)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(20)
                
            }.padding(.top, 40)
            
        }
        .onAppear(perform: {
            self.loadShoppingCartTrigger.send()
        })
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .bottomSheet(bottomSheetPosition: $output.bottomSheetPosition, options: [.swipeToDismiss, .tapToDissmiss, .noBottomPosition, .background(AnyView(Color.white)), .backgroundBlur(effect: .dark)]) {
            ProductDetailView(productItemModel: $output.showingProductItemModel, quantity: $output.quantity, isLoading: $output.isAddingToCart) {
                self.addToCartTrigger.send()
            }.padding(.bottom, 48)
        }
    }
    
    init(viewModel: ShoppingViewModel){
        self.output = viewModel.transform(ShoppingViewModel.Input(loadShoppingCartTrigger: self.loadShoppingCartTrigger.asDriver(), shopByDepartmentTrigger: self.showShopByDepartmentTrigger.asDriver(), showAllProductsTrigger: self.showProductListTrigger.asDriver(), addToCartTrigger: self.addToCartTrigger.asDriver(), showOrderHistoryTrigger: self.showOrderHistoryTrigger.asDriver(), showShoppingCartTrigger: self.showShoppingCartTrigger.asDriver(), showProductDetailTrigger: self.showProductDetailTrigger.asDriver(),loadTopProductListTrigger: self.loadTopProductsTrigger.asDriver()), cancelBag: self.cancelBag)
        
        self.loadTopProductsTrigger.send()
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: ShoppingViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), certificate: CertificateItemViewModel())
        
        ShoppingView(viewModel: vm)
    }
}
