//
//  DeleteProductEntryUseCase.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 10/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import Foundation

protocol DeleteProductEntryUseCaseType{
    func deleteProductEntry(entryId: Int) -> Observable<Order>
}

struct DeleteProductEntryUseCase: DeleteProductEntryUseCaseType, DeletingProductEnrty {
    let shoppingGateway: ShoppingGatewayType
}
