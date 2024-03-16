//
//  CitiesView.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI
import Combine

struct CitiesView: View {
    
    @State var cities : [CityItemViewModel]
    
    let cancelBag = CancelBag()
    let chosenCity: (_ city: String,_ hasChosen: Bool,_ cityIteration: Int) -> Void
    var body: some View {
        ScrollView{
                VStack(alignment: .leading){
                    ForEach(cities){city in
                        Button {
                            if city.child == nil{
                                self.chosenCity(city.cityName ?? "", true, -1)
                            }else{
                                if let cityIteration = findCity(cities: cities, cityId: city.id){
                                    self.chosenCity(city.cityName ?? "", true,cityIteration)
                                }
                                
                            }
                        } label: {
                            VStack{
                                
                                Text(city.cityName ?? "")
                                Divider()
                            }
                            
                        }
                    }
                }
                .padding()
                Spacer()
        }
    }
    
    
    init(cities: [CityItemViewModel], chosenCity: @escaping (_ city: String, _ hasChosen: Bool, _ cityIteration: Int) -> Void) {
        self.cities = cities
        self.chosenCity = chosenCity
    }
}

private func findCity(cities:[CityItemViewModel], cityId: Int) -> Int?{
    for i in cities.indices {
        if cities[i].id == cityId{
            return i
        }
    }
    return nil
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        let cities = [CityItemViewModel]()
        CitiesView(cities: cities, chosenCity: {city,hasChosen, hasChild  in
            
        })
    }
}

