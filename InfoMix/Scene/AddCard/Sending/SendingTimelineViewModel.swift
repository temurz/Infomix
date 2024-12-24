//
//  SendingTimelineViewModel.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import Combine
import UIKit

struct SendingTimelineViewModel {
    let cardConfig: CardConfig
    let connectUseCase: SendingConnectUseCaseType
    let sendSerialNumbersUseCase: SendingSerialNumbersUseCaseType
    let sendAdditionalDataUseCase: SendingAdditionalDataUseCaseType
    let calculateBonusesUseCase: CalculateBonusesUseCaseType
    let openDisputeUseCase: OpenDisputeUseCaseType
    let navigator: SendingTimelineNavigatorType



    private let sendSerialNumbersTrigger = PassthroughSubject<SerialNumbersInput, Error>()
    private let resendSerialNumbersTrigger = PassthroughSubject<SerialNumbersInput, Error>()

    private let sendAdditionalDataTrigger = PassthroughSubject<AdditionalDataInput, Error>()
    private let resendAdditionalDataTrigger = PassthroughSubject<AdditionalDataInput, Error>()

    private let connectTrigger = PassthroughSubject<Void, Error>()
    private let reconnectTrigger = PassthroughSubject<Void, Error>()

    private let calculateBonusesTrigger = PassthroughSubject<CalculateBonusesInput, Error>()
    private let recalculateBonusesTrigger = PassthroughSubject<CalculateBonusesInput, Error>()

    private let reopenDisputeTrigger = PassthroughSubject<OpenDisputeInput,Error>()
    private let openDisputeTrigger = PassthroughSubject<OpenDisputeInput, Error>()

    private let sendImageValueTrigger = PassthroughSubject<ImageValueInput,Error>()
    private let resendImageValueTrigger = PassthroughSubject<ImageValueInput,Error>()
}

extension SendingTimelineViewModel: ViewModel {


    struct Input {
        let sendTrigger: Driver<Void>
        let resendTrigger: Driver<SendingTimeline>
        let openDisputeNoteTrigger: Driver<OpenDisputeInput>
        let openDisputeTrigger: Driver<OpenDisputeInput>
        let finishTrigger: Driver<Void>
        let popViewTrigger: Driver<Void>
    }

    final class Output: ObservableObject {

        @Published var timelines = [SendingTimeline]()
        @Published var isSending = false
        var sendedImageIds: [String] = []
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        input.finishTrigger.handleEvents(receiveOutput: {
            navigator.toRoot()
        }).sink().store(in: cancelBag)

        input.resendTrigger.handleEvents(receiveOutput: {
            timeline in
            output.isSending = true
            switch timeline.id {
            case SendingTimelineId.connect.rawValue:
                self.reconnectTrigger.send()
            case SendingTimelineId.serialNumbers.rawValue:
                if let serialNumbersInput = timeline.input as? SerialNumbersInput{
                    self.resendSerialNumbersTrigger.send(serialNumbersInput)
                }

            case SendingTimelineId.additionalData.rawValue:
                if let additionalDataInput = timeline.input as? AdditionalDataInput{
                    self.resendAdditionalDataTrigger.send(additionalDataInput)
                }

            case SendingTimelineId.calculateBonus.rawValue:
                if let calculateBonusesInput = timeline.input as? CalculateBonusesInput{
                    self.recalculateBonusesTrigger.send(calculateBonusesInput)
                }

            case SendingTimelineId.dispute.rawValue:
                if let openDisputeInput = timeline.input as? OpenDisputeInput{
                    self.reopenDisputeTrigger.send(openDisputeInput)
                }

            case SendingTimelineId.imageValue.rawValue:
                if let sendImageInput = timeline.input as? ImageValueInput {
                    self.resendImageValueTrigger.send(sendImageInput)
                }
            default :
                break
            }
        }).sink().store(in: cancelBag)


        input.sendTrigger.handleEvents(receiveOutput: {
            _ in

            output.isSending = true

            output.timelines.append(SendingTimeline(id: SendingTimelineId.connect.rawValue, status: .loading, title: "Waiting...".localized(), date: Date()))


            connectTrigger.send()

        }).sink().store(in: cancelBag)


        let connectInput = GetItemInput(loadTrigger: self.connectTrigger.asDriver(), reloadTrigger: self.reconnectTrigger.asDriver(), getItem: connectUseCase.connect)

        let (serialCardId, errorConnecting, isConnecting, isReconnecting) = getItem(input: connectInput).destructured



        isConnecting.handleEvents(receiveOutput: {
            isConnecting in
            if isConnecting {
                output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.connect.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Connecting...".localized())
                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)



        isReconnecting.handleEvents(receiveOutput: {
            isReconnecting in
            if isReconnecting {

                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.connect.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Reconnecting...".localized())
                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)


        errorConnecting.handleEvents(receiveOutput: {
            error in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.connect.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .error, title: "Error".localized(), (error as? LocalizedError)?.errorDescription)
                output.timelines[index] = timeline
            }

            output.isSending = false

        }).sink().store(in: cancelBag)


        serialCardId.handleEvents(receiveOutput: {
            serialCardId in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.connect.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .success, title: "Connected".localized())
                output.timelines[index] = timeline
            }

            let input = SerialNumbersInput(serialCardId: serialCardId, serialNumbers: self.cardConfig.serialNumbers())

            output.timelines.append(SendingTimeline(id: SendingTimelineId.serialNumbers.rawValue, status: .loading, title: "Waiting...".localized(), date: Date(),input: input))

            self.sendSerialNumbersTrigger.send(input)
        }).sink().store(in: cancelBag)


        let sendSerialNumbersInput = GetItemInput(loadTrigger: self.sendSerialNumbersTrigger.asDriver(), reloadTrigger: self.resendSerialNumbersTrigger.asDriver(), getItem: self.sendSerialNumbersUseCase.sendSerialNumbers)

        let (serialCard, errorSendingSerialNumbers, isSendingSerialNumbers, isResendingSerialNumbers) = getItem(input: sendSerialNumbersInput).destructured

        isSendingSerialNumbers.handleEvents(receiveOutput: {
            isLoading in
            if isLoading {

                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.serialNumbers.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Sending serial numbers...".localized(), self.cardConfig.serialNumberText(separator: "\n"))

                    output.timelines[index] = timeline
                }


            }
        }).sink().store(in: cancelBag)



        isResendingSerialNumbers.handleEvents(receiveOutput: {
            isResendingSerialNumbers in
            if isResendingSerialNumbers {

                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.serialNumbers.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Resending serial numbers...".localized(), self.cardConfig.serialNumberText(separator: "\n"))

                    output.timelines[index] = timeline
                }

            }
        }).sink().store(in: cancelBag)


        errorSendingSerialNumbers.handleEvents(receiveOutput: {
            error in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.serialNumbers.rawValue
            }){

                var timeline = output.timelines[index].clone(status:(error as? APIUnknownError)?.disputable ?? false ? .dispute : .error, title: "Error".localized(), (error as? LocalizedError)?.errorDescription)

                if timeline.status == .dispute{
                    if let snInput = timeline.input as? SerialNumbersInput {
                        timeline.disputeInput = OpenDisputeInput(serialCardId: snInput.serialCardId, disputeCode: (error as? APIError)?.statusCode ?? 0, disputeSubject: (error as? LocalizedError)?.errorDescription ?? "", timelineId: timeline.id, disputeNote: nil)
                    }
                }

                output.timelines[index] = timeline
            }

            output.isSending = false

        }).sink().store(in: cancelBag)

        serialCard.handleEvents(receiveOutput: {
            sc in


            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.serialNumbers.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .success, title: "Sended serial numbers".localized(), self.cardConfig.serialNumberText(separator: "\n"))
                output.timelines[index] = timeline


                let input = AdditionalDataInput(serialCardId: sc.id, installedDate: self.cardConfig.installedDate, data: cardConfig.getAdditionalData(), latitude: nil, longitude: nil)

                output.timelines.append(SendingTimeline(id: SendingTimelineId.additionalData.rawValue, status: .loading, title: "Waiting...".localized(), content: self.cardConfig.additionalData(), date: Date(), input: input, inDispute: timeline.inDispute))


                self.sendAdditionalDataTrigger.send(input)
            }


        }).sink().store(in: cancelBag)


        let sendAdditionalDataInput = GetItemInput(loadTrigger: self.sendAdditionalDataTrigger.asDriver(), reloadTrigger: self.resendAdditionalDataTrigger.asDriver(), getItem: self.sendAdditionalDataUseCase.sendAdditionData)

        let (serialCardWithAdditional, errorSendingAdditionalData, isSendingAdditionalData, isResendingAdditionalData) = getItem(input: sendAdditionalDataInput).destructured



        isSendingAdditionalData.handleEvents(receiveOutput: {
            isLoading in
            if isLoading {

                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.additionalData.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Sending additional data...".localized(), self.cardConfig.additionalData())

                    output.timelines[index] = timeline
                }

            }
        }).sink().store(in: cancelBag)



        isResendingAdditionalData.handleEvents(receiveOutput: {
            isResending in
            if isResending {

                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.additionalData.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Resending additional data...".localized(), self.cardConfig.additionalData())
                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)


        errorSendingAdditionalData.handleEvents(receiveOutput: {
            error in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.additionalData.rawValue
            }){
                var timeline = output.timelines[index].clone(status:(error as? APIUnknownError)?.disputable ?? false ? .dispute : .error, title: "Error".localized(), (error as? LocalizedError)?.errorDescription)

                  if timeline.status == .dispute{
                      if let snInput = timeline.input as? AdditionalDataInput {
                          timeline.disputeInput = OpenDisputeInput(serialCardId: snInput.serialCardId, disputeCode: (error as? APIError)?.statusCode ?? 0, disputeSubject: (error as? LocalizedError)?.errorDescription ?? "", timelineId: timeline.id, disputeNote: nil)
                      }
                  }

                  output.timelines[index] = timeline
            }

            output.isSending = false

        }).sink().store(in: cancelBag)


        serialCardWithAdditional.handleEvents(receiveOutput: {
            sc in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.additionalData.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .success, title: "Sended additional data".localized(), self.cardConfig.additionalData())
                output.timelines[index] = timeline

                if let nextImageStepItem = cardConfig.getNextImageData(sendingImage: output.sendedImageIds){
                    let imageSenderInput = ImageValueInput(serialCardId: sc.id, data: nextImageStepItem.imageValue!, fileName: nextImageStepItem.title ?? "")

                    output.sendedImageIds.append(nextImageStepItem.id)
                    output.timelines.append(SendingTimeline(id: SendingTimelineId.imageValue.rawValue, status: .loading, title: "Waiting...".localized(), content: nextImageStepItem.title, date: Date(), input: nextImageStepItem, inDispute: timeline.inDispute))

                    self.sendImageValueTrigger.send(imageSenderInput)
                } else if timeline.inDispute {

                        output.timelines.append(SendingTimeline(id: SendingTimelineId.done.rawValue, status: .done, title: "Successfully saved".localized(), date: Date()))
                } else {
                        let input = CalculateBonusesInput(serialCardId: sc.id)

                    output.timelines.append(SendingTimeline(id: SendingTimelineId.calculateBonus.rawValue, status: .loading, title: "Waiting...".localized(), date: Date(), input: input))

                        self.calculateBonusesTrigger.send(input)
                    }


            }


        }).sink().store(in: cancelBag)

        let sendImageValueInput = GetItemInput(loadTrigger: self.sendImageValueTrigger.asDriver(), reloadTrigger: self.resendImageValueTrigger.asDriver(), getItem: self.sendAdditionalDataUseCase.sendImageValue)

        let (imageValue, errorSendingImageValue, isSendingImageValue, isResendingImageValue) = getItem(input: sendImageValueInput).destructured

        isSendingImageValue.handleEvents(receiveOutput:{
            isLoading in
            if isLoading{
                output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.imageValue.rawValue

                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Sending image...".localized())
                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)

        isResendingImageValue.handleEvents(receiveOutput:{isResending in
            if isResending{
                output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.imageValue.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Resending image...".localized())
                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)

        errorSendingImageValue.handleEvents(receiveOutput:{
            error in
            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.imageValue.rawValue
            }){
                var timeline = output.timelines[index].clone(status:(error as? APIUnknownError)?.disputable ?? false ? .dispute : .error, title: "Error".localized(), (error as? LocalizedError)?.errorDescription)

                  if timeline.status == .dispute{
                      if let snInput = timeline.input as? AdditionalDataInput {
                          timeline.disputeInput = OpenDisputeInput(serialCardId: snInput.serialCardId, disputeCode: (error as? APIError)?.statusCode ?? 0, disputeSubject: (error as? LocalizedError)?.errorDescription ?? "", timelineId: timeline.id, disputeNote: nil)
                      }
                  }

                  output.timelines[index] = timeline
            }
        }).sink().store(in: cancelBag)


        imageValue.handleEvents(receiveOutput:{
            sc in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.imageValue.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .success, title: "Successfully saved image")
                output.timelines[index] = timeline

                if let nextImageStepItem = cardConfig.getNextImageData(sendingImage: output.sendedImageIds){
                    let imageSenderInput = ImageValueInput(serialCardId: sc.id, data: nextImageStepItem.imageValue!, fileName: nextImageStepItem.title ?? "")

                    output.sendedImageIds.append(nextImageStepItem.id)

                    output.timelines.append(SendingTimeline(id: SendingTimelineId.imageValue.rawValue, status: .loading, title: "Waiting...".localized(), content: nextImageStepItem.title, date: Date(), input: imageSenderInput, inDispute: timeline.inDispute))

                    self.sendImageValueTrigger.send(imageSenderInput)
                } else if timeline.inDispute {

                        output.timelines.append(SendingTimeline(id: SendingTimelineId.done.rawValue, status: .done, title: "Successfully saved".localized(), date: Date()))
                } else {
                        let input = CalculateBonusesInput(serialCardId: sc.id)

                        output.timelines.append(SendingTimeline(id: SendingTimelineId.calculateBonus.rawValue, status: .loading, title: "Waiting...".localized(), date: Date()))

                        self.calculateBonusesTrigger.send(input)
                    }

            }
        }).sink().store(in: cancelBag)



        let calculateBonusesInput = GetItemInput(loadTrigger: self.calculateBonusesTrigger.asDriver(), reloadTrigger: self.recalculateBonusesTrigger.asDriver(), getItem: self.calculateBonusesUseCase.calculateBonuses)

        let (transaction, errorCalculate, isCalculating, isRecalculating) = getItem(input: calculateBonusesInput).destructured

        isCalculating.handleEvents(receiveOutput: {
            isLoading in
            if isLoading {

                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.calculateBonus.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Calculating bonuses...".localized())
                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)



        isRecalculating.handleEvents(receiveOutput: {
            isReloading in
            if isReloading {

                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.calculateBonus.rawValue
                }){
                    let timeline = output.timelines[index].clone(status: .loading, title: "Recalculating bonuses...".localized())
                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)


        errorCalculate.handleEvents(receiveOutput: {
            error in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.calculateBonus.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .error, title: "Error",(error as? LocalizedError)?.errorDescription)
                output.timelines[index] = timeline
            }

            output.isSending = false
        }).sink().store(in: cancelBag)


        transaction.handleEvents(receiveOutput: {
            t in


            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.calculateBonus.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .success, title: t.confirmed ? "Calculated bonuses".localized() : "Card details have been verified. The bonus for the card will be provided after verification by the inspector or manager.".localized(), t.confirmed ? "\(t.amount ?? 0)" : "")
                output.timelines[index] = timeline
            }

            output.timelines.append(SendingTimeline(id: SendingTimelineId.done.rawValue, status: .done, title: "Successfully saved".localized(), date: Date()))

            output.isSending = false

        }).sink().store(in: cancelBag)


//        OPEN DISPUTE TRIGGERS
        input.openDisputeNoteTrigger.handleEvents(receiveOutput: {
            input in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == input.timelineId
            }){
                let timeline = output.timelines[index].clone(status: .warning, title: "Error".localized(), output.timelines[index].content)
                output.timelines[index] = timeline
            }

            output.timelines.append(SendingTimeline(id: SendingTimelineId.dispute.rawValue, status: .note, title: "Comment for dispute".localized(), date: Date(), input: input))

        }).sink().store(in: cancelBag)

        input.openDisputeTrigger.handleEvents(receiveOutput: {
            input in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.dispute.rawValue
            }){
                var timeline = output.timelines[index].clone(status: .loading, title: "Waiting...".localized(), input.disputeNote)
                timeline.input = input
                output.timelines[index] = timeline

                self.openDisputeTrigger.send(input)
            }



        }).sink().store(in: cancelBag)

        let openDisputeInput = GetItemInput(loadTrigger: self.openDisputeTrigger.asDriver(), reloadTrigger: self.reopenDisputeTrigger.asDriver(), getItem: self.openDisputeUseCase.open)

        let (dispute, errorOpenDispute, isOpeningDispute, isReopeningDispute) = getItem(input: openDisputeInput).destructured


        isOpeningDispute.handleEvents(receiveOutput: {
            isLoading in
            if isLoading {


                    output.isSending = true

                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.dispute.rawValue
                }){
                    var timeline = output.timelines[index].clone(status: .loading, title: "Opening dispute...".localized())
                    timeline.content = (timeline.input as? OpenDisputeInput)?.disputeNote

                    output.timelines[index] = timeline
                }

            }
        }).sink().store(in: cancelBag)



        isReopeningDispute.handleEvents(receiveOutput: {
            isReloading in
            if isReloading {


                    output.isSending = true
                if let index = output.timelines.lastIndex(where: { it in
                    it.id == SendingTimelineId.dispute.rawValue
                }){
                    var timeline = output.timelines[index].clone(status: .loading, title: "Reopening dispute...".localized())
                    timeline.content = (timeline.input as? OpenDisputeInput)?.disputeNote

                    output.timelines[index] = timeline
                }
            }
        }).sink().store(in: cancelBag)


        errorOpenDispute.handleEvents(receiveOutput: {
            error in

            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.dispute.rawValue
            }){
                let timeline = output.timelines[index].clone(status: .error, title: "Error".localized(), (error as? APIUnknownError)?.errorDescription)
                output.timelines[index] = timeline
            }


                output.isSending = false
        }).sink().store(in: cancelBag)



        dispute.handleEvents(receiveOutput: {
            dispute in


            if let index = output.timelines.lastIndex(where: { it in
                it.id == SendingTimelineId.dispute.rawValue
            }){
                var timeline = output.timelines[index].clone(status: .success, title: "Opened dispute".localized())
                timeline.content = (timeline.input as? OpenDisputeInput)?.disputeNote
                output.timelines[index] = timeline

                if let lastActionIndex = output.timelines.lastIndex(where: { it in
                    it.id == (timeline.input as? OpenDisputeInput)?.timelineId ?? ""
                }) {
                    let lastTimeline = output.timelines[lastActionIndex]

                    if let input = lastTimeline.input {
                        if input is SerialNumbersInput {

                            output.timelines.append(SendingTimeline(id: SendingTimelineId.serialNumbers.rawValue, status: .loading, title: "Waiting...".localized(), content: self.cardConfig.serialNumberText(separator: "\n"), date: Date(), input: input, inDispute: true))
                            self.resendSerialNumbersTrigger.send(input as! SerialNumbersInput)
                        }else if lastTimeline.input is AdditionalDataInput {

                            output.timelines.append(SendingTimeline(id: SendingTimelineId.additionalData.rawValue, status: .loading, title: "Waiting...".localized(), content: self.cardConfig.additionalData(), date: Date(), input: input, inDispute: true))

                            self.resendAdditionalDataTrigger.send(input as! AdditionalDataInput)
                        }
                    }
                }

                    output.isSending = false

            }


        }).sink().store(in: cancelBag)

        input.popViewTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)

        return output
    }
}
