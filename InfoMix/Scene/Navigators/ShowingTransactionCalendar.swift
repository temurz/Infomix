//
//  ShowingTransactionCalendar.swift
//  CleanArchitecture
//
//  Created by Temur on 13/01/22.
//  Copyright © 2022 Tuan Truong. All rights reserved.
//

import UIKit
import SwiftUI

protocol ShowingTransactionCalendar {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}


