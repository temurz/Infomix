//
//  VoucherViewUseCase.swift
//  InfoMix
//
//  Created by Temur on 13/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

protocol VoucherViewUseCaseType {
    func voucherRequest(amount: Double) -> Observable<CreatedVoucherResponse>
    func getVoucherHistory(_ input: GetVoucherHistoryInput, page: GetPageDto) -> Observable<VoucherHistoryResponse>
    func getVoucherStatuses() -> Observable<[VoucherStatus]>
    func cancelVoucher(_ id: Int) -> Observable<Bool>
    func getVoucherCurrency() -> Observable<VoucherCurrency>
}

struct VoucherViewUseCase: VoucherViewUseCaseType, VoucherDomainUseCase {
    var voucherGateway: VoucherGatewayProtocol
}
