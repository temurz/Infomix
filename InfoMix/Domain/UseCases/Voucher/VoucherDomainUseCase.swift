//
//  VoucherDomainUseCase.swift
//  InfoMix
//
//  Created by Temur on 17/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

protocol VoucherDomainUseCase {
    var voucherGateway: VoucherGatewayProtocol { get }
}

extension VoucherDomainUseCase {
    func voucherRequest(amount: Double) -> Observable<CreatedVoucherResponse> {
        voucherGateway.voucherRequest(amount: amount)
    }
    
    func getVoucherHistory(_ input: GetVoucherHistoryInput, page: GetPageDto) -> Observable<[VoucherHistoryResponse]> {
        voucherGateway.getVoucherHistory(input, page: page)
    }
    
    func getVoucherStatuses() -> Observable<[VoucherStatus]> {
        voucherGateway.getVoucherStatuses()
    }
    
    func cancelVoucher(_ id: Int) -> Observable<Bool> {
        voucherGateway.cancelVoucher(id)
    }
    
    func getVoucherCurrency() -> Observable<VoucherCurrency> {
        voucherGateway.getVoucherCurrency()
    }

}
