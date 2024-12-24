//
//  EventsView.swift
//  CleanArchitecture
//
//  Created by Damir Asamatdinov on 13/12/21.
//  Copyright © 2021 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIRefresh

struct EventsView: View {
    
    @ObservedObject var output : EventsViewModel.Output
    @State private var selectedType : Int = -1
    private let cancelBag = CancelBag()
    private let loadEventTypesTrigger = PassthroughSubject<Void, Never>()
    private let reloadEventsTrigger = PassthroughSubject<Optional<Int>, Never>()
    private let selectEventTrigger = PassthroughSubject<IndexPath, Never>()
    private let loadMoreEventsTrigger = PassthroughSubject<Optional<Int>,Never>()
    private let loadEventsTrigger = PassthroughSubject<Optional<Int>,Never>()
    private let selectEventTypeTrigger = PassthroughSubject<IndexPath,Never>()

    @State var showPicker = false
    var body: some View {
        
        let types = output.types.enumerated().map { $0 }
        
        
        return LoadingView(isShowing: $output.isLoading, text: .constant("")){
            ZStack(alignment: .topTrailing) {
                Color(.systemGray6)
                VStack {
                    CustomNavigationBarWithMenu(
                        title: "Event List".localized(),

                        menu:
                            Menu("Filter".localized()){
                                Picker(selection: $selectedType, label: Text("Select types".localized())) {
                                    Text("All".localized()).tag(-1)
                                    ForEach(types, id: \.element.id){index, type in
                                        Text(type.name.localized()).tag(type.id)
                                    }

                                }
                            }.onChange(of: selectedType) { newValue in
                                self.selectEventTypeTrigger.send(IndexPath(row: newValue, section: 0))
                            },
                        backButtonColor: .clear) {

                        }
                        .padding(.top)
//                    ModuleNavigationBar(title: "Event List".localized())
//                    .padding(.top)
                    if output.events.isEmpty {
                        VStack {
                            Spacer()
                            EmptyDataView()
                            Spacer()
                        }
                    } else {
                        List(output.events.enumerated().map { $0 }, id: \.element.title){ index, event in
                            Button(action: {
                               self.selectEventTrigger.send(IndexPath(row: index, section: 0))
                            }) {
                                    EventRow(viewModel: event)
                            }

                        }
                        .listStyle(SidebarListStyle())

                    }


                }
                .pullToRefresh(isShowing: self.$output.isReloading) {
                    self.reloadEventsTrigger.send(selectedTypes())
                }
//                Menu("Filter".localized()){
//                    Picker(selection: $selectedType, label: Text("Select types".localized())) {
//                        Text("All".localized()).tag(-1)
//                        ForEach(types, id: \.element.id){index, type in
//                            Text(type.name.localized()).tag(type.id)
//                        }
//
//                    }
//                }.onChange(of: selectedType) { newValue in
//                    self.selectEventTypeTrigger.send(IndexPath(row: newValue, section: 0))
//                }
//                .padding(.horizontal)
            }
            .padding(.top)

        }
        
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationBarHidden(true)

    }

    func selectedTypes()->Int? {
        selectedType == 0 ? nil : selectedType
    }
    
    
    init(viewModel: EventsViewModel) {
        let input = EventsViewModel.Input(
            loadEventTypesTrigger: self.loadEventTypesTrigger.asDriver(), loadEventsTrigger: self.loadEventsTrigger.asDriver(), reloadEventsTrigger: self.reloadEventsTrigger.asDriver(), loadMoreEventsTrigger: self.loadMoreEventsTrigger.asDriver(), selectEventTrigger: self.selectEventTrigger.asDriver(),selectEventTypeTrigger: self.selectEventTypeTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.loadEventTypesTrigger.send(())
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: EventsViewModel = PreviewAssembler().resolve(
            navigationController: UINavigationController()
        )
        return EventsView(viewModel: viewModel)
    }
}
