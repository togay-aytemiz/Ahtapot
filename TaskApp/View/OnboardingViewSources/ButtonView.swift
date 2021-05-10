//
//  ButtonView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 21.04.2021.
//

import SwiftUI

struct ButtonView: View {
    // MARK: PROPERTIES
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"
    
    @Binding var selection: Int
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    @Environment(\.managedObjectContext) var context
    @StateObject var homeData = HomeViewModel()

    let haptics = UIImpactFeedbackGenerator()

    let buttons = ["Previous", "Next"]
    
    // MARK: BODY
    var body: some View {
        
        
          // BUTTON ALTERNATIVE 2
//        HStack{
//            ForEach(buttons, id:\.self) { label in
//                Button(action: {
//                    buttonAction(label)
//                }, label: {
//                    Text(label)
//                        .fontWeight(.heavy)
//                        .padding()
//                        .frame(width: 150, height: 44)
//                        .background(Color.black.opacity(0.2))
//                        .cornerRadius(12)
//                        .padding(.horizontal)
//                })
//            }
//        } // HSTACK
//        .foregroundColor(.white)
//        .padding()
        
        
        VStack {
            ProgressBarView(selection: $selection)
                .padding(.horizontal)
                .padding(.horizontal)
            HStack{
                if selection == 0 {
                    
                } else {
                    Button(action: {
                        buttonAction("Previous")
                        haptics.impactOccurred()
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .font(.title3)

                            Text("Geri")
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.semibold)
                        }
                    })
                    .padding()
                }
                
                
                Spacer()
                
                
                if selection == onboardingViewTabs.count - 1 {
                    Button(action: {
                        isOnboarding = false
                        haptics.impactOccurred()
                        homeData.firstTimeAddTasks(context: context)

                    }, label: {
                        HStack {
                            Text("Hadi Başlayalım")
                                .font(.headline)
                                .fontWeight(.semibold)
                                
                                .layoutPriority(/*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                            
                            Image(systemName: "arrow.right")
                                .font(.title3)

                        }
                    })
                    .padding()
                    .background(Utils.AppThemeBackgroundColor)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                    .padding(.horizontal)
                    .scaledToFit()
                    .minimumScaleFactor(0.6)

                    
                } else {
                    Button(action: {
                        buttonAction("Next")
                        haptics.impactOccurred()

                    }, label: {
                        HStack {
                            Text("İleri")
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                                .font(.title3)
                        }
                    })
                    .padding()
                }
                
            }
            .padding(.horizontal)
            .foregroundColor(Color("Color1"))
            .animation(.default)
        }

    }

    
    func buttonAction(_ buttonLabel: String) {
        withAnimation {
            if buttonLabel == "Previous" && selection > 0 {
                selection -= 1
            } else if buttonLabel == "Next" && selection < onboardingViewTabs.count - 1 {
                selection += 1
            }
        }
    }
}


// MARK: PREVIEW
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
            ButtonView(selection: .constant(2))
                .previewLayout(.sizeThatFits)
                .padding()
        
        
    }
}
