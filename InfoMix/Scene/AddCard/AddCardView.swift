//
//  AddCardView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 15/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct AddCardView: View {

    @ObservedObject var output: AddCardViewModel.Output
    @State private var keyboardHeight: CGFloat = 0

    let nextStepTrigger = PassthroughSubject<Void, Error>()
    let prevStepTrigger = PassthroughSubject<Void, Error>()
    let sendCardTrigger = PassthroughSubject<Void, Error>()
    let loadCardTrigger = PassthroughSubject<Void, Error>()
    let popViewTrigger = PassthroughSubject<Void, Error>()
    let scanTrigger = PassthroughSubject<AddCardStepItem, Error>()
    let cancelBag = CancelBag()

    @State var showToast = false

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(title: "Add Card".localized()) {
                popViewTrigger.send(())
            }
            ZStack {
                if output.change {
                    StepView(addCardStep: $output.currentCardStep, scanTrigger: self.scanTrigger)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                }else {
                    StepView(addCardStep: $output.currentCardStep, scanTrigger: self.scanTrigger)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                }
                if showToast {
                    ToastView(message: "The entered string length must be between 15 and 15 characters.".localized())
                        .transition(.opacity)
                        .zIndex(1)
                        .padding()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                        }
                }
            }
            .animation(.easeInOut, value: showToast)



            HStack{

                Spacer()
                if output.hasPrevStep{
                    Button(action: {
                        self.prevStepTrigger.send()
                    }, label: {
                        HStack{
                            Image(systemName: "arrow.left")
                            Text("Previous".localized())
                        }
                    }).padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .background(Color.white)
                        .cornerRadius(.greatestFiniteMagnitude)
                        .foregroundColor(Color.green)
                }
                if output.hasNextStep {
                    if AddCardStep.isValid(output.currentCardStep)(){
                        Button(action: {
                            if output.currentCardStep.items.last?.valid() ?? false {
                                UIApplication.shared.endEditing(true)
                                self.nextStepTrigger.send()
                            } else {
                                showToast = true
                            }
                        }, label: {
                            HStack{
                                Text("Next".localized())
                                Image(systemName: "arrow.right")

                            }
                        }).padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                            .background(Color.white)
                            .cornerRadius(.greatestFiniteMagnitude)
                            .foregroundColor(Color.green)
                    }
                }
                if output.enabledSendButton {
                    if AddCardStep.isValid(output.currentCardStep)(){
                        Button(action: {
                            self.sendCardTrigger.send()
                        }, label: {
                            HStack{
                                Text("Send".localized())
                                Image(systemName: "paperplane")

                            }
                        }).padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                            .background(Color.white)
                            .cornerRadius(.greatestFiniteMagnitude)
                            .foregroundColor(Color.green)
                    }
                }
            }.frame(height: 64, alignment: .top)
                .padding(8)
                .padding(.bottom, keyboardHeight)
            // 3.
                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
                .frame(maxWidth: .infinity)
                .background(RoundedCorner(color: Color.green, tl: 32, tr: 0, bl: 0, br: 0))
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    init(viewModel: AddCardViewModel){
        let input = AddCardViewModel.Input(
            nextStepTrigger: self.nextStepTrigger.asDriver(),
            prevStepTrigger: self.prevStepTrigger.asDriver(),
            sendCardTrigger: self.sendCardTrigger.asDriver(),
            popViewTrigger: self.popViewTrigger.asDriver(),
            scanTrigger: self.scanTrigger.asDriver())

        self.output = viewModel.transform(input, cancelBag: self.cancelBag)

        self.nextStepTrigger.send()

    }
}

extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: AddCardViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), cardConfig: CardConfig(configCode: ""))
        return AddCardView(viewModel: vm)
    }
}
