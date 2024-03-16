//
//  ShowingOnlineApplication.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

protocol ShowingOnlineApplication{
    var assembler: Assembler {get}
    var navigationController: UINavigationController { get }
}

extension ShowingOnlineApplication{
    func toOnlineApplicationView(){
        let view: OnlineApplicationView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
