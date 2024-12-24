//
//  DeletingProductEntry.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//
import Combine

protocol DeletingProductEnrty {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension DeletingProductEnrty {
    
    func deleteProductEntry(entryId: Int) -> Observable<ProductEntry> {
        shoppingGateway.deleteProductEntry(entryId: entryId)
    }
    
}
