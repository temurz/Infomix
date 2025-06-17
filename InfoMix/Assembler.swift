//
//  Assembler.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

protocol Assembler: AnyObject,
                    ReposAssembler,
                    EventsAssembler,
                    EventDetailAssembler,
                    ShoppingAssembler,
                    ProductsAssembler,
                    MainAssembler,
                    HomeAssembler,
CityAssembler,
OnlineApplicationAssembler,
MyCardsDetailAssembler,
MyCardsAssembler,
NotificationsAssembler,
TransactionHistoryAssembler,
LoginAssembler,
ICUAssembler,
GatewaysAssembler,
AppAssembler,
AddCardAssembler,
AddCardConfirmAssembler,
SendingTimelineAssembler,
ScannerAssembler,
SplashAssembler,
ProductCategoryAssembler,
ShoppingCartAssembler,
OrderHistoryAssembler,
ProfileAssembler,
ChangePasswordAssembler,
ChangeLanguageAssembler,
AboutAssembler,
LocalUsersAssembler,
StatusViewAssembler,
VoucherViewAssembler
{

}

final class DefaultAssembler: Assembler {
    
}

final class PreviewAssembler: Assembler {
    
}
