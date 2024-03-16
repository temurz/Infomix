//
//  API+UpdateProductEntry .swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//


import Alamofire
import Combine

extension API {
    
    func updateProductEntry(_ input: UpdateProductEntryApiInput) -> Observable<Order> {
        return request(input)
    }
    
    final class UpdateProductEntryApiInput: APIInput {
        init(entryId: Int, quantity: Int){
            let parameters: Parameters = [
                "id": entryId,
                "quantity": quantity]
            
            super.init(urlString: Urls.updateProductEntry,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
