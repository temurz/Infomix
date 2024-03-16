//
//  AuthGateway.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/29/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Combine
import Foundation

protocol AuthGatewayType {
    func login(dto: LoginDto) -> Observable<Certificate>
    func getCurrentUser()-> Observable<Certificate>
    func changePassword(password: String, newPassword: String) -> Observable<Bool>
    func
    logout() -> Observable<Int>
    func sendFcmToken(token: String) -> Observable<Bool>
}

struct AuthGateway: AuthGatewayType {
    func sendFcmToken(token: String) -> Observable<Bool> {
        let input = API.SendFcmTokenAPIInput(token: token)
        return API.shared.sendFcmToken(input)
    }
    
    func changePassword(password: String, newPassword: String) -> Observable<Bool> {
        let input = API.ChangePasswordApiInput(password: password, newPassword: newPassword)
        return API.shared.changePassword(input)
    }
    
    func logout() -> Observable<Int> {
        let input = API.LogoutInput()
        return API.shared.logout(input)
            .tryMap {
                if $0 {
                    
                    if let token = UserDefaults.standard.string(forKey: "token"){
                        _ = LocalUserDao.shared.deleteByToken(token)
                    }
                    
                    UserDefaults.standard.removeObject(forKey: "token")
                    
                    return LocalUserDao.shared.count()
                } else {
                    throw APIInvalidResponseError()
                }
                
            }
            .eraseToAnyPublisher()
    }
    
    
    func getCurrentUser() -> Observable<Certificate> {
        let input = API.CurrentUserInput()
        return API.shared.getCurrentUser(input)
    }
    
    func login(dto: LoginDto) -> Observable<Certificate> {
        if !dto.isValid{
            return Empty().eraseToAnyPublisher()
        }
       
        let input = API.LoginInput(dto: dto)
        return API.shared.login(input)
            .tryMap { output in
                
                let localUserCount = LocalUserDao.shared.count()
                if localUserCount == 0 {
                    UserDefaults.standard.set(output.token, forKey: "token")
                }
                
                if let certificate = output.certificate {
                    _ = LocalUserDao.shared.save(certificate, output.token)
                }
             
                if output.certificate != nil{
                    return output.certificate!
                } else {
                    throw APIInvalidResponseError()
                }
                
            }
            .eraseToAnyPublisher()
       
    }
}
