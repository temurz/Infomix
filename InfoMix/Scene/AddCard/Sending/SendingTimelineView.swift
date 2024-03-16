//
//  SendingTimelineView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 23/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine

struct SendingTimelineView: View {
    
    // change these to visually style the timeline
    private static let lineWidth: CGFloat = 2
    private static let dotDiameter: CGFloat = 8
    @State private var dispute: OpenDisputeInput?
    @State private var disputeNote: String = ""
    
    
    private let dateFormatter: DateFormatter
    
    @ObservedObject var output: SendingTimelineViewModel.Output
    
    let sendTrigger = PassthroughSubject<Void, Error>()
    let resendTrigger = PassthroughSubject<SendingTimeline, Error>()
    let finishTrigger = PassthroughSubject<Void, Error>()
    let openDisputeTrigger = PassthroughSubject<OpenDisputeInput, Error>()
    let openDisputeNoteTrigger = PassthroughSubject<OpenDisputeInput, Error>()
    let cancelBag = CancelBag()
    
    var body: some View {
        VStack{
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(output.timelines.enumerated()), id: \.offset) { index, timeline in
                            
                            rowAt(index, item: timeline)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .padding(.horizontal, 12)
                            
                        }
                    }
                }
                .onAppear {
                    value.scrollTo(output.timelines.last?.id, anchor: .center)
                }
                
            }
        }.navigationBarBackButtonHidden(output.isSending)
        
    }
    
    
    
    @ViewBuilder private func rowAt(_ index: Int, item: SendingTimeline) -> some View {
        let calendar = Calendar.current
        let date = item.date
        let hasPrevious = index > 0
        let hasNext = index < output.timelines.count - 1
        let isPreviousSameDate = hasPrevious
        && calendar.dateComponents([.second], from: output.timelines[index-1].date, to: date).second ?? 0 > 0
        
        HStack {
            ZStack {
                Color.clear // effectively centers the text
                if !isPreviousSameDate {
                    Text(dateFormatter.string(from: date))
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: 56)
            
            GeometryReader { geo in
                ZStack {
                    Color.clear
                    line(height: geo.size.height,
                         hasPrevious: hasPrevious,
                         hasNext: hasNext,
                         isPreviousSameDate: isPreviousSameDate)
                }
            }
            .frame(width: 10)
            VStack(alignment: .leading,spacing: 0){
                HStack {
                    Text(item.title)
                    
                    Spacer()
                    
                    if item.status == .loading{
                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                    }
                    
                }.padding(6)
                VStack(alignment: .leading){
                    if let content = item.content {
                        Text(content).padding(6)
                            .font(.system(size: 14))
                            .frame(maxWidth:.infinity)
                    }
                    if item.id == SendingTimelineId.dispute.rawValue && item.status == .note {
                        TextEditor(text: $disputeNote)
                            .foregroundColor(.secondary)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100, alignment: .topLeading)
                            .padding()
                        
                    }
                    if item.status == .error || item.status == .dispute || item.status == .done || item.status == .note {
                        HStack (spacing: 4){
                            Spacer()
                            if item.status == .error  {
                                
                                Button {
                                    self.resendTrigger.send(item)
                                } label: {
                                    HStack{
                                        Image(systemName: "arrow.counterclockwise.circle")
                                        Text("Try again".localized())
                                            .font(.system(size: 13))
                                    }
                                    .foregroundColor(.black)
                                    .padding(4)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                                }
                            }
                            
                            if item.status == .dispute && item.disputeInput != nil {
                                
                                Button {
                                    self.openDisputeNoteTrigger.send(item.disputeInput!)
                                    
                                } label: {
                                    HStack{
                                        Image(systemName: "exclamationmark.bubble")
                                            .renderingMode(.original)
                                        Text("Open dispute".localized())
                                            .font(.system(size: 13))
                                    }
                                    .foregroundColor(.black)
                                    .padding(4)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                                }
                            }
                            if item.status == .note {
                                
                                Button {
                                    if var disputeInput = item.input as? OpenDisputeInput {
                                        disputeInput.disputeNote  = self.disputeNote
                                        self.openDisputeTrigger.send(disputeInput)
                                    }
                                    
                                } label: {
                                    HStack{
                                        Image(systemName: "exclamationmark.bubble")
                                            .renderingMode(.original)
                                        Text("Open".localized())
                                            .font(.system(size: 13))
                                    }
                                    .foregroundColor(.black)
                                    .padding(4)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                                }
                            }
                            if item.status == .done {
                                
                                Button {
                                    self.finishTrigger.send()
                                } label: {
                                    HStack{
                                        Image(systemName: "checkmark")
                                        Text("Finish".localized())
                                            .font(.system(size: 13))
                                    }
                                    .foregroundColor(.black)
                                    .padding(4)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                                }
                            }
                        }.frame(maxWidth:.infinity)
                            .padding(4)
                    }
                    
                }.background( Color.init(red: 0.92, green: 0.92, blue: 0.92))
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                
            }.frame(maxWidth:.infinity)
                .background(item.status == .loading ? Color.init(red: 0.98, green: 0.98, blue: 0.98) : item.status == .error ? Color.init(red: 0.94, green: 0.6, blue: 0.6) : item.status == .dispute || item.status == .note ? Color.init(red: 1, green: 0.88, blue: 0.51): item.status == .warning ? Color.init(red: 1, green: 0.93, blue: 0.34) : Color.init(red: 0.65, green: 0.84, blue: 0.65))
                .cornerRadius(10)
                .padding(6)
        }
    }
    
    // this methods implements the rules for showing dots in the
    // timeline, which might differ based on requirements
    @ViewBuilder private func line(height: CGFloat,
                                   hasPrevious: Bool,
                                   hasNext: Bool,
                                   isPreviousSameDate: Bool) -> some View {
        let lineView = Rectangle()
            .foregroundColor(.black)
            .frame(width: SendingTimelineView.lineWidth)
        let dot = Circle()
            .fill(Color.blue)
            .frame(width: SendingTimelineView.dotDiameter,
                   height: SendingTimelineView.dotDiameter)
        let halfHeight = height / 2
        let quarterHeight = halfHeight / 2
        if isPreviousSameDate && hasNext {
            lineView
        } else if hasPrevious && hasNext {
            lineView
            dot
        } else if hasNext {
            lineView
                .frame(height: halfHeight)
                .offset(y: quarterHeight)
            dot
        } else if hasPrevious {
            lineView
                .frame(height: halfHeight)
                .offset(y: -quarterHeight)
            dot
        } else {
            dot
        }
    }
    
    
    init(viewModel: SendingTimelineViewModel){
        let input = SendingTimelineViewModel.Input(sendTrigger: self.sendTrigger.asDriver(), resendTrigger: self.resendTrigger.asDriver(), openDisputeNoteTrigger: self.openDisputeNoteTrigger.asDriver(), openDisputeTrigger: self.openDisputeTrigger.asDriver(), finishTrigger: self.finishTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: self.cancelBag)
        
        dateFormatter = DateFormatter()
        // the format of the dates on the timeline
        dateFormatter.dateFormat = "HH:mm:ss"
        
        self.sendTrigger.send()
    }
}

struct SendingTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: SendingTimelineViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), cardConfig: CardConfig(configCode: ""))
        return SendingTimelineView(viewModel: vm)
    }
}
