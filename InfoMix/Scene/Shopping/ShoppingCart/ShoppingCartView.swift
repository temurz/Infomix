//
//  ShoppingCartView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import SwiftUI
import Combine


struct ShoppingCartView: View {
    
    @ObservedObject var output: ShoppingCartViewModel.Output
    
    let updateEntryTrigger = PassthroughSubject<UpdateProductEntryInput, Never>()
    let deleteEntryTrigger = PassthroughSubject<Int, Never>()
    let checkoutTrigger = PassthroughSubject<Void,Never>()
    let clearShoppingCartTrigger = PassthroughSubject<Void,Never>()
    let cancelOrderTrigger = PassthroughSubject<Void,Never>()
    let loadOrderTrigger = PassthroughSubject<Void,Never>()
    let showAllProductsTrigger = PassthroughSubject<Void,Never>()
    let popViewTrigger = PassthroughSubject<Void,Never>()

    let cancelBag = CancelBag()
    
    fileprivate func CheckOutButton() -> some View {
        Button(action: {
            self.checkoutTrigger.send()
        }) {
            Text("CHECKOUT".localized())
                .font(.system(size: 15))
                .foregroundColor(.white)
                .frame(height: 44)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "00C301"), Color.init(hex: "26D701")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(22)
        }
        .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
    }
    
    fileprivate func CancelButton() -> some View {
        Button(action: {
            self.cancelOrderTrigger.send()
        }) {
            Text("CANCEL".localized())
                .font(.system(size: 15))
                .foregroundColor(.white)
                .frame(height: 44)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "cb2d3e"), Color.init(hex: "ef473a")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(22)
        }
        .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
    }
    
    var body: some View {
        let _isLoading = Binding<Bool>(
            get: { self.output.isClearing || self.output.isCanceling || self.output.isCheckingOut || self.output.isDeleting  || self.output.isLoading},
            set: { _ in
            }
        )
        
        let _loadingMessage = Binding<String>(
            get: {
                self.output.isDeleting ? "Deleting...".localized() :
                self.output.isClearing ? "Clearing...".localized() :
                self.output.isCanceling ? "Canceling...".localized() :
                self.output.isCheckingOut ? "Checking out...".localized() :
                "Loading...".localized()
            }, set: { _ in
                
            })
        return LoadingView(isShowing: _isLoading, text: _loadingMessage){
            VStack {
                if output.shoppingCart.isEditable() {
                    CustomNavigationBar(title: "Order detail".localized(), rightBarTitle: "Clear".localized()) {
                        popViewTrigger.send(())
                    } onRightBarButtonTapAction: {
                        clearShoppingCartTrigger.send(())
                    }
                } else {
                    CustomNavigationBar(title: "Order detail".localized()) {
                        popViewTrigger.send(())
                    }
                }

                ZStack{
                    if (self.output.checkedOut) {
                        VStack(alignment: .center) {
                            Image(systemName: "cube.box.fill")
                                .resizable()
                                .frame(width: 160, height: 160)
                                .foregroundColor(.green)
                                .aspectRatio(contentMode: .fit)
                            Text("Success!".localized())
                                .font(.largeTitle)
                                .padding(.vertical, 10)
                            Text("Your order has been placed. Thank you for choosing our app.".localized())
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }.frame(maxHeight: .infinity)
                    } else {
                        VStack(spacing: 0) {
                            if self.output.shoppingCart.entries.isEmpty && self.output.shoppingCart.status == "Draft" {
                                Text("Cart is empty".localized())
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)

                                Spacer().frame(height: 18)

                                Button("Search".localized()){
                                    self.showAllProductsTrigger.send()
                                }
                            } else {
                                ScrollView(.vertical, showsIndicators: false, content: {

                                    LazyVStack(alignment: .leading, spacing: 0) {
                                        HStack {
                                            Text("Order: " + "\(self.output.shoppingCart.id)")
                                                .font(.system(size: 18))
                                                .bold()
                                                .foregroundColor(.black)
                                            Spacer(minLength: 10)
                                            HStack(alignment: .center, spacing: 5) {

                                                Text("\(self.output.shoppingCart.status ?? "")")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 6)
                                            }.frame(height: 20)
                                                .background(Color.gray)
                                                .cornerRadius(10)
                                        }
                                        .padding([.horizontal], 15)
                                        .padding(.top, 8)

                                        Text(String(format: "Created date: %@", self.output.shoppingCart.createdDate?.toShortFormat() ?? ""))
                                            .font(.system(size: 13))
                                            .foregroundColor(Color(.secondaryLabel))
                                            .lineLimit(nil)
                                            .padding([.horizontal], 15)
                                            .padding(.bottom, 5)

                                        Divider()
                                            .padding(.vertical)



                                        ForEach($output.shoppingCart.entries, id: \.id) { entry in
                                            if self.output.shoppingCart.isEditable() {
                                                ShoppingCartEntryEditableView(entry: entry, updating: $output.isUpdating) { entryId, newQuantity in
                                                    self.updateEntryTrigger.send(UpdateProductEntryInput(entryId: entryId, quantity: newQuantity))
                                                } delete: { entryId in
                                                    self.deleteEntryTrigger.send(entryId)
                                                }
                                            } else {
                                                ShoppingCartEntryView(entry: entry)
                                            }
                                            Divider()
                                        }
                                    }
                                    .padding(.horizontal, 15)
                                }).frame(maxHeight: .infinity)

                                Divider()
                                    .padding(.horizontal, 15)

                                VStack {

                                    HStack {
                                        Text("Subtotal:".localized())
                                            .font(.footnote)
                                            .foregroundColor(Color(.secondaryLabel))
                                        Spacer()
                                        Text("\(self.output.shoppingCart.totalPrice.groupped(fractionDigits: 0, groupSeparator: " ")) ball")
                                            .font(.footnote)
                                            .foregroundColor(Color(.secondaryLabel))
                                    }
                                    .padding(.horizontal, 15)

                                    HStack {
                                        Text("Discount:".localized())
                                            .font(.footnote)
                                            .foregroundColor(Color(.secondaryLabel))
                                        Spacer()
                                        Text(String(format: "%.2f", self.output.shoppingCart.discount ?? 0) + " %")
                                            .font(.footnote)
                                            .foregroundColor(Color(.secondaryLabel))
                                    }
                                    .padding(.horizontal, 15)


                                    HStack {
                                        Text("Total:".localized())
                                            .font(.body)
                                            .bold()
                                            .foregroundColor(Color.primary)
                                        Spacer()
                                        Text("\(self.output.shoppingCart.totalAmount.groupped(fractionDigits: 0, groupSeparator: " ")) ball")
                                            .font(.body)
                                            .bold()
                                            .foregroundColor(Color.primary)
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 5)

                                }.padding(.vertical)
                                if self.output.shoppingCart.isEditable() {
                                    CheckOutButton()
                                } else if self.output.shoppingCart.cancelable {
                                    CancelButton()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .alert(isPresented: $output.alert.isShowing) {
                            Alert(
                                title: Text(output.alert.title),
                                message: Text(output.alert.message),
                                dismissButton: .default(Text("OK"))
                            )
                        }

                    }
                }
            }

        }
        
    }
    
    init(viewModel: ShoppingCartViewModel){
        
        self.output = viewModel.transform(ShoppingCartViewModel.Input(loadOrderTrigger: self.loadOrderTrigger.asDriver(), updateEntryTrigger: self.updateEntryTrigger.asDriver(), deleteEntryTrigger: self.deleteEntryTrigger.asDriver(), checkoutTrigger: self.checkoutTrigger.asDriver(), clearShoppingCartTrigger: self.clearShoppingCartTrigger.asDriver(), cancelOrderTrigger: self.cancelOrderTrigger.asDriver(), showAllProductsTrigger: self.showAllProductsTrigger.asDriver(), popViewTrigger: popViewTrigger.asDriver()), cancelBag: self.cancelBag)
        
        
        self.loadOrderTrigger.send()
    }
    
}


struct BagView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController(), order: Order(id: 0, entries: [], createdDate: nil, closedDate: nil, status: nil, totalPrice: 0, totalProducts: 0, notice: nil, cancelable: false, discount: nil)))
    }
}
