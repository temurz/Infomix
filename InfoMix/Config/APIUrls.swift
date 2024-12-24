//
//  APIUrls.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/31/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

extension API {
    enum Urls {
        static let login = NetworkManager.shared.baseUrl + "/auth/login"
        static let logout = NetworkManager.shared.baseUrl + "/auth/logout"
        static let currentUser = NetworkManager.shared.baseUrl + "/auth/current"
        static let changePassword = NetworkManager.shared.baseUrl + "/master/change/password"
        static let events = NetworkManager.shared.baseUrl+"/events/list"
        static let eventTypes = NetworkManager.shared.baseUrl+"/events/types"
        static let agentCurrentICU = NetworkManager.shared.baseUrl + "/master/balance"
        static let statistics = NetworkManager.shared.baseUrl + "/statistics"
        static let getLoyalty = NetworkManager.shared.baseUrl + "/loyalty"
        static let addToCard = NetworkManager.shared.baseUrl + "/order/entry/add"
        static let currentShoppingCart = NetworkManager.shared.baseUrl + "/order/current"
        static let productCategories = NetworkManager.shared.baseUrl + "/product/categories/"
        static let products = NetworkManager.shared.baseUrl + "/products"
        static let productsTop = NetworkManager.shared.baseUrl + "/products/top"
        static let eventDetail = NetworkManager.shared.baseUrl+"/events/%d"
        static let transactionHistory = NetworkManager.shared.baseUrl+"/scores/history"
        static let transactionTypes = NetworkManager.shared.baseUrl+"/scores/types"
        static let transactionStatistic = NetworkManager.shared.baseUrl+"/scores/total"
        static let updateProductEntry = NetworkManager.shared.baseUrl + "/order/entry/update"
        static let deleteProductEntry = NetworkManager.shared.baseUrl + "/order/entry/delete"
        static let clearProductEntries = NetworkManager.shared.baseUrl + "/order/entry/clear"
        static let checkout = NetworkManager.shared.baseUrl + "/order/checkout"
        static let cancelOrder = NetworkManager.shared.baseUrl + "/order/cancel"
        static let getOrders = NetworkManager.shared.baseUrl + "/order/history"
        static let getOrderStatuses = NetworkManager.shared.baseUrl + "/order/statuses"
        static let getOrder = NetworkManager.shared.baseUrl + "/order/"
        static let getNotifications = NetworkManager.shared.baseUrl + "/notification/list"
        static let getCardsHistory = NetworkManager.shared.baseUrl + "/cards/history"
        static let getCardsDetail = NetworkManager.shared.baseUrl + "/cards/history/{id}"
        static let sendFcmToken = NetworkManager.shared.baseUrl + "/auth/registerFcmId"
        static let cities = NetworkManager.shared.baseUrl + "/cities/tree"
        static let configs = NetworkManager.shared.baseUrl + "/config"
        static let getCardConfigByCode = NetworkManager.shared.baseUrl + "/config"
        static let onlineApplication = NetworkManager.shared.baseUrl + "/auth/resume"
    }
}
