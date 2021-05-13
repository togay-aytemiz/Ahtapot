//
//  ChangingThemeColor.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI






struct ChangingThemeColor: View {
    // MARK: PROPERTIES
    
    // OTHER DETAILS
    let haptics = UIImpactFeedbackGenerator()
    
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"


    var color1A = "Color1A"
    var color1B = "Color1B"
    var color2A = "Color2A"
    var color2B = "Color2B"
    var color3A = "Color3A"
    var color3B = "Color3B"
    var color4A = "Color4A"
    var color4B = "Color4B"
    var color5A = "Color5A"
    var color5B = "Color5B"
    var color6A = "Color6A"
    var color6B = "Color6B"
    var color7A = "Color7A"
    var color7B = "Color7B"
    var color8A = "Color8A"
    var color8B = "Color8B"
    
    // MARK: BODY
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            Text("changeAppThemeColor".localized())
                
         
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    
                    
                    
                    // COLOR1
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color1A"
                            AppColor2 = "Color1B"
                            haptics.impactOccurred()
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color1A), Color(color1B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color1A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                    
                    // COLOR4
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color4A"
                            AppColor2 = "Color4B"
                            haptics.impactOccurred()

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color4A), Color(color4B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color4A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                    
                    // COLOR2
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color2A"
                            AppColor2 = "Color2B"
                            haptics.impactOccurred()

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color2A), Color(color2B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color2A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                    
                    // COLOR3
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color3A"
                            AppColor2 = "Color3B"
                            haptics.impactOccurred()

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color3A), Color(color3B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color3A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                
                    // COLOR5
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color5A"
                            AppColor2 = "Color5B"
                            haptics.impactOccurred()

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color5A), Color(color5B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color5A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                    
                    // COLOR6
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color6A"
                            AppColor2 = "Color6B"
                            haptics.impactOccurred()

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color6A), Color(color6B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color6A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                    
                    // COLOR7
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color7A"
                            AppColor2 = "Color7B"
                            haptics.impactOccurred()

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color7A), Color(color7B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color7A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                    
                    // COLOR8
                    Group{
                        Button(action: {
                            // changeColorAction
                            AppColor1 = "Color8A"
                            AppColor2 = "Color8B"
                            haptics.impactOccurred()

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(color8A), Color(color8B)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                if AppColor1 == "Color8A" {
                                    selectedColorCheckmark()
                                }
                            }
                            .frame(width: 32, height: 32)
                            
                        })
                    }
                     
                    
                }
            }
            
        }
        
    }
}


// MARK: PREVIEW
struct ChangingThemeColor_Previews: PreviewProvider {
    static var previews: some View {
        ChangingThemeColor()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct selectedColorCheckmark: View {
    var body: some View {
        Image(systemName: "checkmark")
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .imageScale(.large)
            .foregroundColor(.white)
    }
}
