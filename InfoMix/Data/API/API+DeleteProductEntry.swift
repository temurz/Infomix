//
//  API+DeleteProductEntry.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Alamofire
import Combine

extension API {
    
    func deleteProductEntry(_ input: DeleteProductEntryApiInput) -> Observable<Order> {
        return request(input)
    }
    
    final class DeleteProductEntryApiInput: APIInput {
        init(entryId: Int){
            let parameters: Parameters = [
                "id": entryId]
            
            super.init(urlString: Urls.deleteProductEntry,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
        }
    }
    
}
