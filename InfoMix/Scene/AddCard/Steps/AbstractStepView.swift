//
//  AbstractStepView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//


import SwiftUI
import Combine

protocol AbstractStepView: View {
    associatedtype DeleteHandler = (_ addCardStepItem : AddCardStepItem)  -> Void
    var cardStepItem :AddCardStepItem { get }
    var onDelete: DeleteHandler? { get }
    
}
