//
//  VoucherGateway.swift
//  InfoMix
//
//  Created by Temur on 17/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

protocol VoucherGatewayProtocol {
    func voucherRequest(amount: Double, comment: String) -> Observable<CreatedVoucherResponse>
    func getVoucherHistory(_ input: GetVoucherHistoryInput, page: GetPageDto) -> Observable<[VoucherHistoryResponse]>
    func getVoucherStatuses() -> Observable<[VoucherStatus]>
    func cancelVoucher(_ id: Int) -> Observable<Bool>
    func getVoucherCurrency() -> Observable<VoucherCurrency>

}

struct VoucherGateway: VoucherGatewayProtocol {
    func voucherRequest(amount: Double, comment: String) -> Observable<CreatedVoucherResponse> {
        let input = API.VoucherRequestAPIInput(amount: amount, comment: comment)
        return API.shared.voucherRequest(input)
    }
    
    func getVoucherHistory(_ input: GetVoucherHistoryInput, page: GetPageDto) -> Observable<[VoucherHistoryResponse]> {
        let input = API.VoucherHistoryAPIInput(input, page: page)
        return API.shared.getVoucherHistory(input)
    }
    
    func getVoucherStatuses() -> Observable<[VoucherStatus]> {
        API.shared.getVoucherStatuses()
    }
    
    func cancelVoucher(_ id: Int) -> Observable<Bool> {
        let input = API.VoucherCancelAPIInput(id)
        return API.shared.cancelVoucher(input)
    }
    
    func getVoucherCurrency() -> Observable<VoucherCurrency> {
        API.shared.getVoucherCurrency()
    }
}
