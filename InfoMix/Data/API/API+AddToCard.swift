//
//  API+ShoppingCard.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 05/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Alamofire
import Combine

extension API {
    
    func addToCard(_ input: AddToCartInput) -> Observable<Order> {
        return request(input)
    }
    
    final class AddToCartInput: APIInput {
        init(product: Product, quantity: Int){
            let parameters: Parameters = [
                "productId": product.id,
                "quantity": quantity
            ]
          
            super.init(urlString: Urls.addToCard,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}


