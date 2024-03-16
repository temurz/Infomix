//
//  ShoppingGateway.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 05/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol ShoppingGatewayType {
    func addToCart(product: Product, quantity: Int) -> Observable<Order>
    func currentShoppingCart() -> Observable<Order>
    func deleteProductEntry(entryId: Int) -> Observable<Order>
    func updateProductEntry(entryId: Int, quantity: Int) -> Observable<Order>
    func checkout(orderId: Int) -> Observable<Order>
    func clearShoppingCart(orderId: Int) -> Observable<Order>
    func cancelOrder(orderId: Int) -> Observable<Order>
    func getOrders(dto: GetPageDto, from: String?, to: String?, status: String?) -> Observable<PagingInfo<Order>>
    func getOrderStatusList() -> Observable<[OrderStatus]>
    func getOrder(orderId: Int) -> Observable<Order>
}

struct ShoppingGateway: ShoppingGatewayType {
    
    func getOrderStatusList() -> Observable<[OrderStatus]> {
        let input = API.GetOrderStatusListApiInput()
        
        return API.shared.getOrderStatusList(input)
            .eraseToAnyPublisher()
    }
    
    
    func getOrders(dto: GetPageDto, from: String?, to: String?, status: String?) -> Observable<PagingInfo<Order>> {
        let input = API.GetOrderListApiInput(dto: dto, from: from, to: to, status: status)
        
        return API.shared.getOrders(input)
            .map { (output) -> [Order]? in
            return output
        }
        .replaceNil(with: [])
        .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage) }
        .eraseToAnyPublisher()
    }
    
    func getOrder(orderId: Int) -> Observable<Order> {
        let input = API.GetOrderApiInput(orderId: orderId)
        
        return API.shared.getOrder(input)
            .eraseToAnyPublisher()
    }
    
    func checkout(orderId: Int) -> Observable<Order> {
        let input = API.CheckoutApiInput(orderId: orderId)
        
        return API.shared.checkout(input)
            .eraseToAnyPublisher()
    }
    func cancelOrder(orderId: Int) -> Observable<Order> {
        let input = API.CancelOrderApiInput(orderId: orderId)
        
        return API.shared.cancelOrder(input)
            .eraseToAnyPublisher()
    }
    
    func clearShoppingCart(orderId: Int) -> Observable<Order> {
        let input = API.ClearShoppingCartApiInput(orderId: orderId)
        
        return API.shared.clearShoppingCart(input)
            .eraseToAnyPublisher()
    }
    
    func updateProductEntry(entryId: Int, quantity: Int) -> Observable<Order> {
        let input = API.UpdateProductEntryApiInput(entryId: entryId, quantity: quantity)
        
        return API.shared.updateProductEntry(input)
            .eraseToAnyPublisher()
    }
    
    
    func deleteProductEntry(entryId: Int) -> Observable<Order> {
        let input = API.DeleteProductEntryApiInput(entryId: entryId)
        
        return API.shared.deleteProductEntry(input)
            .eraseToAnyPublisher()
    }
    
    
    func currentShoppingCart() -> Observable<Order> {
        let input = API.CurrentShoppingCartInput()
        
        return API.shared.currentShoppingCart(input)
            .eraseToAnyPublisher()
    }
    
    
    func addToCart(product: Product, quantity: Int) -> Observable<Order> {
        let input = API.AddToCartInput(product: product, quantity: quantity)
        
        return API.shared.addToCard(input)
            .eraseToAnyPublisher()
    }
    

   
}

struct PreviewShoppingGateway: ShoppingGatewayType {
    func getOrderStatusList() -> Observable<[OrderStatus]> {
        Future<[OrderStatus], Error> { promise in
           
            promise(.success([OrderStatus(value: "Draft", text: "Draft")]))
        }
        .eraseToAnyPublisher()
    }
    
    func getOrders(dto: GetPageDto, from: String?, to: String?, status: String?) -> Observable<PagingInfo<Order>> {
        Future<PagingInfo<Order>, Error> { promise in
            let orders = [
               Order(id: 1, entryCount: 10, totalAmount: 10, entries: [ProductEntry](), createdDate: Date(), closedDate: Date(), status: "Draft", statusText: "Draft")
            ]
            
            let page = PagingInfo<Order>(page: 1, items: orders)
            promise(.success(page))
        }
        .eraseToAnyPublisher()
    }
    
    func getOrder(orderId: Int) -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
    
    
    func checkout(orderId: Int) -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
    
    func cancelOrder(orderId: Int) -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
    
    func clearShoppingCart(orderId: Int) -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
    
    func deleteProductEntry(entryId: Int) -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
    
    func updateProductEntry(entryId: Int, quantity: Int) -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
    
    func currentShoppingCart() -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
    
    func addToCart(product: Product, quantity: Int) -> Observable<Order> {
        Future<Order, Error> { promise in
            promise(.success(Order()))
        }
        .eraseToAnyPublisher()
    }
 
}
