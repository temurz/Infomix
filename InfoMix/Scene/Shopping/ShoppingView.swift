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
import Localize_Swift
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
    let popViewTrigger = PassthroughSubject<Void,Never>()
    let cancelBag = CancelBag()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            
            Color(.systemGray6)
            
            RoundedCorner(color: Colors.appMainColor, tl: 0, tr: 0, bl: 0, br: 60)
                .frame(maxWidth: .infinity, maxHeight: 320)
                .ignoresSafeArea(.all)

            
            ScrollView(.vertical, showsIndicators: false) {
//                ZStack(alignment: .leading) {
//                    HStack {
//                        Spacer()
//                        Text("Shop".localized())
//                                .font(.title3)
//                                .foregroundStyle(.white)
//                                .padding()
//                        Spacer()
//                    }
//                    Button {
//                        popViewTrigger.send(())
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .foregroundStyle(.white)
//                    }
//
//
//                }
//                .padding()

                ZStack(alignment: .leading) {
                    Text("Shop".localized())
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                    Button {
                        popViewTrigger.send(())
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundStyle(.white)
                            .aspectRatio(contentMode: .fit)
                            .padding(4)
                    }
                    .frame(width: 24, height: 24)
                    .padding(.leading)
                }
                .padding(.bottom, 4)

                HStack {
                    Text(output.certificate.agentFullName)
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity,alignment: .leading)

                    Button {
                        self.showOrderHistoryTrigger.send()
                    } label: {
                        HStack{
                            Text("History".localized())
                        }
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.white))
                    }
                }
                .padding(.horizontal, 12)

                Text("You ".localized() + "\(output.certificate.balance.groupped(fractionDigits: 0, groupSeparator: " "))" + "balls".localized())
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.horizontal, 12)

                if let discount = output.certificate.loyalty?.discount {
                    VStack(alignment: .leading) {
                        Text(String(format: "%@ off".localized(), String(discount)))
                            .font(.body)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                        Text("Specific to your level.".localized())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.gray.opacity(0.2))

                }


                VStack(spacing: 5) {
                    HStack{
                        Text(output.certificate.serviceName.localized())
                            .font(.headline)
                            .frame(maxWidth:.infinity,alignment: .leading)

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
                        
                        Text(!output.isLoadingShoppingCart ? "\(output.shoppingCart.totalProducts)" + " " + "Product".localized() : "Loading...".localized())
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        if let discount = output.shoppingCart.discount, discount > 0 {
                            Text(!output.isLoadingShoppingCart ? "\(output.shoppingCart.totalPrice.groupped(fractionDigits: 0, groupSeparator: " ")) ball" : " ")
                                .font(.subheadline)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }


                        Text(!output.isLoadingShoppingCart ? "\(output.shoppingCart.totalAmount.groupped(fractionDigits: 0, groupSeparator: " ")) ball" : " ")
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Button(action: {
                            self.showShoppingCartTrigger.send()
                        }) {
                            HStack {
                                Text("Go to cart".localized())
                                Image(systemName: "chevron.right")
                            }.font(.subheadline)
                        }
                        .padding(8)
                        .disabled(output.isLoadingShoppingCart)
                        .foregroundColor(.white)
                        .background(output.isLoadingShoppingCart ? Color.gray: Color.green)
                        .cornerRadius(.greatestFiniteMagnitude)
                    }.padding()
                    
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
                .padding(12)

                Button(action: {
                    self.showShopByDepartmentTrigger.send()
                }) {
                    HStack {
                        Text("Shop by department".localized())
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "bag.fill")
                            .foregroundColor(.green)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.green)
                    }.font(.subheadline)
                        .padding(16)
                        .frame(maxWidth:.infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                }.padding(.horizontal, 12)
                    .shadow(radius: 1)

                
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
                        if output.products.isEmpty {
                            Text("Be this week`s first shopper.".localized())
                                .multilineTextAlignment(.center)
                                .padding(32)
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
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
                .padding(12)

            }.padding(.top)
            
        }
        .onAppear(perform: {
            self.loadShoppingCartTrigger.send()
        })
        .frame(maxHeight: .infinity)
//        .navigationBarHidden(true)
//        .navigationTitle("Shop".localized())
//        .edgesIgnoringSafeArea(.all)
        .bottomSheet(bottomSheetPosition: $output.bottomSheetPosition, options: [.swipeToDismiss, .tapToDissmiss, .noBottomPosition, .background(AnyView(Color.white)), .backgroundBlur(effect: .dark)]) {
            ProductDetailView(productItemModel: $output.showingProductItemModel, quantity: $output.quantity, isLoading: $output.isAddingToCart) {
                self.addToCartTrigger.send()
            }.padding(.bottom, 48)
        }
    }
    
    init(viewModel: ShoppingViewModel){
        self.output = viewModel.transform(ShoppingViewModel.Input(loadShoppingCartTrigger: self.loadShoppingCartTrigger.asDriver(), shopByDepartmentTrigger: self.showShopByDepartmentTrigger.asDriver(), showAllProductsTrigger: self.showProductListTrigger.asDriver(), addToCartTrigger: self.addToCartTrigger.asDriver(), showOrderHistoryTrigger: self.showOrderHistoryTrigger.asDriver(), showShoppingCartTrigger: self.showShoppingCartTrigger.asDriver(), showProductDetailTrigger: self.showProductDetailTrigger.asDriver(),loadTopProductListTrigger: self.loadTopProductsTrigger.asDriver(), popViewTrigger: popViewTrigger.asDriver()), cancelBag: self.cancelBag)
        
        self.loadTopProductsTrigger.send()
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: ShoppingViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), certificate: CertificateItemViewModel())
        
        ShoppingView(viewModel: vm)
    }
}
