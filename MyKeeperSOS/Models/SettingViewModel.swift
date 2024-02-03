//
//  SettingViewModel.swift
//  MyKeeperSOS
//
//  Created by JamesMutura on 17/10/2023.
//

import Foundation

class SettingViewModel : ObservableObject {
    @Published var pressSelection: Int = 5
    @Published var pressSelection2: Int = 2
    @Published var sliderValue: Double = 40.0
    //@Published var showAlert = false
    
    init(){
        //showAlert = UserDefaults.standard.bool(forKey: UserDefaultsKeys.pressSelection) ?? 5
        pressSelection = UserDefaults.standard.integer(forKey: UserDefaultsKeys.pressSelection) ?? 5
        pressSelection2 = UserDefaults.standard.integer(forKey: UserDefaultsKeys.pressSelection2) ?? 2
        sliderValue = UserDefaults.standard.double(forKey: UserDefaultsKeys.sliderValue) ?? 40.0
    }
}
