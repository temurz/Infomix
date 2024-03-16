//
//  CityRow.swift
//  InfoMix
//
//  Created by Temur on 07/03/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import SwiftUI

struct CityRow: View {
    @Binding var cityRow : CityItemViewModel
    @State private var selectedCountry: String = ""
    let action: (_ city: String, _ hasChosen: Bool) -> Void
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                    Button {
                        selectedCountry = cityRow.cityName ?? ""
                        self.action(selectedCountry, true)
                    } label: {
                        VStack{
                            Text(cityRow.cityName ?? "")
                            Divider()
                        }
                        
                    }
                
                Spacer()
            }
        }
        
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(cityRow: .constant(CityItemViewModel(city: City())), action:{city,hasChosen in
            
        })
    }
}
