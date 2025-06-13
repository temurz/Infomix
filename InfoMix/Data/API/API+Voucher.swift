//
//  API+Voucher.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import Foundation

extension API {
    //Input classes
    final class VoucherRequestAPIInput: APIInput {
        init(_ amount: Double) {
            let params = [
                "amount": amount
            ]
            super.init(urlString: API.Urls.voucherRequest, parameters: params, method: .post, requireAccessToken: true)
        }
    }
    
    final class VoucherHistoryAPIInput: APIInput {
        init(_ input: GetVoucherHistoryInput, page: GetPageDto) {
            let params: [String: Any] = [
                "from": input.from,
                "to": input.to,
                "status": input.status,
                "page": page.page,
                "rows": page.perPage
            ]
            super.init(urlString: API.Urls.voucherHistory, parameters: params, method: .post, requireAccessToken: true)
        }
    }
    
    final class VoucherCancelAPIInput: APIInput {
        init(_ id: Int) {
            let params = [
                "id": id
            ]
            super.init(urlString: API.Urls.voucherCancel, parameters: params, method: .post, requireAccessToken: true)
        }
    }
    
    struct EmptyResponse: Decodable {
        
    }
    
    //Methods
    func voucherRequest(_ input: VoucherRequestAPIInput) -> Observable<CreatedVoucherResponse> {
        request(input)
    }
    func getVoucherHistory(_ input: VoucherHistoryAPIInput) -> Observable<VoucherHistoryResponse> {
        request(input)
    }
    func getVoucherStatuses() -> Observable<[VoucherStatus]> {
        let input = APIInput(urlString:  API.Urls.voucherStatuses, parameters: nil, method: .get, requireAccessToken: true)
        return requestList(input)
    }
    func cancelVoucher(_ input: VoucherCancelAPIInput) -> Observable<Bool> {
        success(input)
    }
    func getVoucherCurrency() -> Observable<VoucherCurrency> {
        let input = APIInput(urlString: API.Urls.voucherCurrency, parameters: nil, method: .get, requireAccessToken: true)
        return request(input)
    }
}
