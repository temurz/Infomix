//
//  UpdatingProductEntry.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 11/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Combine

protocol UpdatingProductEntry {
    var shoppingGateway: ShoppingGatewayType { get }
}

extension UpdatingProductEntry {
    
    func updateProductEntry(input: UpdateProductEntryInput) -> Observable<Order> {
        shoppingGateway.updateProductEntry(entryId: input.entryId, quantity: input.quantity)
    }
    
}
