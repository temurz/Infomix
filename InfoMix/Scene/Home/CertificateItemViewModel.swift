//
//  CertificateViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import Foundation

struct CertificateItemViewModel {
    var cardConfig: CardConfig?
    var certificate: Certificate?
    var certificateCode: String = ""
    var agentFullName: String = ""
    var serviceName: String = ""
    var phoneNumber: String = ""
    var balance: Double = 0.0
    var url: URL?
    var loyalty: Loyalty? = nil

    init(certificate: Certificate) {
        self.certificate = certificate
        self.certificateCode = certificate.certificate ?? ""
        self.agentFullName = String.init(format: "%@ %@", certificate.master?.firstName ?? "",  certificate.master?.lastName ?? "")
        self.serviceName = certificate.service?.name ?? ""
        self.phoneNumber = certificate.master?.phone ?? ""
        
        url = URL(string: certificate.service?.icon ?? "")
    }
    
    init() {
       certificate = nil
        cardConfig = nil
    }

}
