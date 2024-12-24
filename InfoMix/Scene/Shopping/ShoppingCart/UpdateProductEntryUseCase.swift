//
//  UpdateProductEntryUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol UpdateProductEntryUseCaseType{
    func updateProductEntry(input: UpdateProductEntryInput) -> Observable<ProductEntry>
}

struct UpdateProductEntryUseCase: UpdateProductEntryUseCaseType, UpdatingProductEntry {
    let shoppingGateway: ShoppingGatewayType
}
struct UpdateProductEntryInput{
    let entryId: Int
    let quantity: Int
}

