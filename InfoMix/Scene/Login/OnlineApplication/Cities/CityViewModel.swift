//
//  CityViewModel.swift
//  InfoMix
//
//  Created by Temur on 09/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import Combine

struct CityViewModel {
    let useCase: CityUseCase
    let loadCitiesTrigger = PassthroughSubject<Void,Never>()
    let loadMoreCitiesTrigger = PassthroughSubject<Void,Never>()
    let reloadCitiesTrigger = PassthroughSubject<Void,Never>()
}

extension CityViewModel : ViewModel{
    
    struct Input{
        let loadCitiesTrigger : Driver<Void>
        let loadMoreCitiesTrigger : Driver<Void>
        let reloadCitiesTrigger : Driver<Void>
    }
    
    final class Output : ObservableObject{
        @Published var cities = [CityItemViewModel]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loadCitiesTrigger.handleEvents(receiveOutput:{
            self.loadCitiesTrigger.send()
        }).sink().store(in: cancelBag)
        
        let getListInput = GetListInput(loadTrigger: input.loadCitiesTrigger.asDriver(), reloadTrigger: input.reloadCitiesTrigger.asDriver(), getItems: useCase.getCities)
        
        let (cities, _, _, _) = getList(input: getListInput).destructured
        
        cities
            .map{ $0.map { it in
                CityItemViewModel(city: it)
            }}
            .assign(to: \.cities, on: output)
            .store(in: cancelBag)
        
        return output
    }

    
}
