//
//  API+Resume.swift
//  InfoMix
//
//  Created by Temur on 07/04/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Alamofire
import Combine

extension API{
    func sendResume(_ input: SendingResumeInput) -> Observable<Resume> {
        return request(input)
    }
    
    final class SendingResumeInput: APIInput {
        init(resume: Resume){
            let parameters: Parameters = [
                "firstName" : resume.firstName
                
            ]
            
            super.init(urlString: API.Urls.onlineApplication,
                       parameters: parameters,
                       method: .post,
                       requireAccessToken: true)
            
            self.headers = [
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            ]
            self.encoding = URLEncoding.httpBody
        }
    }
}
