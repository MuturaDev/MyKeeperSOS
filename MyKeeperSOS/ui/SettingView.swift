//
//  SettingView.swift
//  MyKeeperSOS
//
//  Created by JamesMutura on 08/10/2023.
//

import SwiftUI

struct UserDefaultsKeys {
    static let pressSelection = "PressSelectionKey"
    static let pressSelection2 = "PressSelection2Key"
    static let sliderValue = "SliderValueKey"
}


struct SettingView: View {
    

    @EnvironmentObject private var viewModel: SettingViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var showAlert: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack{
                        Text("Parameters")
                            .fontWeight(.bold)
                            .modifier(SailecFont(.bold, size: 14))
                            .foregroundColor(.blue)
            
                            .padding(.top, 10)
                        Spacer()
                    }.padding(.bottom)
                    
                    
                    //
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Number of presses on the power button to trigger the alert")
                                .modifier(SailecFont(.regular, size: 14))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                viewModel.pressSelection = 3
                                UserDefaults.standard.set(viewModel.pressSelection, forKey: UserDefaultsKeys.pressSelection)
                                UserDefaults.standard.synchronize()
                                print("test")
                            }
                        }) {
                            Text("3")
                                .foregroundColor(.white)
                                .frame(width: 60, height: 40)
                                .background(viewModel.pressSelection == 3 ? Color.blue : Color.gray)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            withAnimation{
                                viewModel.pressSelection = 5
                                UserDefaults.standard.set(viewModel.pressSelection, forKey: UserDefaultsKeys.pressSelection)
                                UserDefaults.standard.synchronize()
                            }
                        }) {
                            Text("5")
                                .foregroundColor(.white)
                                .frame(width: 60, height: 40)
                                .background(viewModel.pressSelection == 5 ? Color.blue : Color.gray)
                                .cornerRadius(20)
                        }
                    }.padding(.bottom)
                    
                    
                    
                    
                    HStack {
                        
                        Text("Duration during which successive suppors (dry) are expected")
                            .modifier(SailecFont(.regular, size: 14))
                        
                        
                        
                        Spacer()
                        
                        
                        Button(action: {
                            withAnimation{
                                viewModel.pressSelection2 = 1
                                UserDefaults.standard.set(viewModel.pressSelection2, forKey: UserDefaultsKeys.pressSelection2)
                                UserDefaults.standard.synchronize()
                            }
                        }) {
                            Text("1s")
                                .foregroundColor(.white)
                                .frame(width: 40, height: 30)
                                .background(viewModel.pressSelection2 == 1 ? Color.blue : Color.gray)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            withAnimation{
                                viewModel.pressSelection2 = 2
                                UserDefaults.standard.set(viewModel.pressSelection2, forKey: UserDefaultsKeys.pressSelection2)
                                UserDefaults.standard.synchronize()
                            }
                        }) {
                            Text("2s")
                                .foregroundColor(.white)
                                .frame(width: 40, height: 30)
                                .background(viewModel.pressSelection2 == 2 ? Color.blue : Color.gray)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            withAnimation{
                                viewModel.pressSelection2 = 3
                                UserDefaults.standard.set(viewModel.pressSelection2, forKey: UserDefaultsKeys.pressSelection2)
                                UserDefaults.standard.synchronize()
                            }
                        }) {
                            Text("3s")
                                .foregroundColor(.white)
                                .frame(width: 40, height: 30)
                                .background(viewModel.pressSelection2 == 3 ? Color.blue : Color.gray)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.bottom)
                    
                    
                    
                    HStack {
                        
                        Text("Duration during which the device automatically responds to incoming calls after an alert (in min)")
                            .modifier(SailecFont(.regular, size: 14))
                        
                        
                        Spacer()
                        
                        VStack{
                            Text("\(Int(viewModel.sliderValue))")
                            Slider(
                                value: $viewModel.sliderValue,
                                in: 0...100, step: 10,
                                label: {
                                    Text("Values from 0 to 50").foregroundColor(.blue)
                                },
                                onEditingChanged: { value in
                                    if !value {
                                        UserDefaults.standard.set(viewModel.sliderValue, forKey: UserDefaultsKeys.sliderValue)
                                        UserDefaults.standard.synchronize()
                                    }
                                   
                                }
                            )
                            .accentColor(.blue)
                        }
                        //.padding(.horizontal)
                    }.padding(.bottom)
                    
                    
                    HStack {
                        Text("Sim card choice")
                            .modifier(SailecFont(.regular, size: 14))
                        
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Sim 1")
                                .modifier(SailecFont(.regular, size: 16))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(5)
                        }
                        .padding(.horizontal)
                    }.padding(.bottom)
                    
                    
                    
                    Button(action: {
                        withAnimation{
                            viewModel.pressSelection = 5
                            UserDefaults.standard.set(viewModel.pressSelection, forKey: UserDefaultsKeys.pressSelection)
                            
                            viewModel.pressSelection2 = 2
                            UserDefaults.standard.set(viewModel.pressSelection2, forKey: UserDefaultsKeys.pressSelection2)
                            
                            viewModel.sliderValue = 40.0
                            UserDefaults.standard.set(viewModel.sliderValue, forKey: UserDefaultsKeys.sliderValue)
                            
                            UserDefaults.standard.synchronize()
                        }
                    }) {
                        Text("Restoring values by default".capitalized)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Button("Install config") {
                        showAlert = true
                        UserDefaults.standard.set(false, forKey: "config_installed")
                        UserDefaults.standard.synchronize()
                        presentationMode.wrappedValue.dismiss()
                     }
                    
                    Spacer()
                    
                    Text("Version 1.0.0")
                        .modifier(SailecFont(.bold, size: 16))
                        .font(.title)
                }.padding()
                
            }
        }.navigationBarTitle(Text("MyKeeper SOS").foregroundColor(Color.blue))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .background(Color.blue)
    }
}



//struct SettingView_Preview : PreviewProvider {
//    static var previews: some View {
//       // SettingView(isConfigInstalled: false)
//    }
//}
