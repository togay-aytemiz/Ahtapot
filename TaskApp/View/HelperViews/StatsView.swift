//
//  StatsView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 30.04.2021.
//

import SwiftUI

struct StatsView: View {
    // MARK: PROPERTIES
    
    // STATS TYPE
    //@AppStorage("isSummaryVisible") var isSummaryBig: Bool = false
    
    
    // COLORS
    //@AppStorage("appColor1") private var AppColor1: String = "Color1A"
    //@AppStorage("appColor2") private var AppColor2: String = "Color1B"
    
    let haptics = UIImpactFeedbackGenerator()
    
    var numberOfPreviousTask = 1    // geçmiş tasklar
    var numberOfFutureTasks = 0     // gelecek tasklar
    var todayClosedTask = 12        // bugün kapatılan tasklar
    var todayAllTask = 78           // bugün yapılacak tüm tasklar
    
    
    
    var calculatedCompletionForText: Float {
        
        let calculatedProgress = (Float(todayClosedTask) / Float(todayAllTask) ) * 100
        return calculatedProgress
    }
    var calculatedCompletionForBar: Float {
        return (calculatedCompletionForText / 100)
    }
    
    
    
    // MARK: BODY
    var body: some View {
        
        ZStack {
            // MARK: BACKGROUND IMAGE
            Image("backgroundStat")
                .resizable()
                .opacity(0.8)
                .animation(.spring())
            
            
            // MAIN HSTACK
            HStack {
                // PROGRESS CHART
                Spacer()
                if todayAllTask > 0 {
                    VStack(alignment: .center, spacing: 0) {
                        
                        
                        Spacer()
                        
                        Group {
                            // PROGRESS
                            ZStack {
                                Group {
                                    ZStack{
                                        
                                        // ARKA ÇEMBER
                                        Circle()
                                            .stroke(lineWidth: 3.0)
                                            .opacity(0.3)
                                        
                                        // ÖN ÇEMBER
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(min(self.calculatedCompletionForBar, 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                                            .rotationEffect(Angle(degrees: 270.0))
                                            .animation(.linear)
                                            .shadow(color: Color.primary.opacity(0.2), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                                        
                                        
                                    }
                                    .padding(7)
                                    .scaledToFit()
                                    .minimumScaleFactor(0.5)
                                }
                                
                                
                                
                                // PROGRESS İÇİN YAZI (%'li kısım)
                                Group {
                                    
                                    VStack {
                                        HStack(alignment: .firstTextBaseline, spacing: 2) {
                                            Text("%")
                                                .font(.system(.headline, design: .rounded))
                                                .fontWeight(.heavy)
                                            Text(String(format: "%.0f", calculatedCompletionForText))
                                                .font(.system(.largeTitle, design: .rounded))
                                                .fontWeight(.heavy)
                                                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.1)
                                            
                                        }
                                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                                        
                                        Text("today".localized().uppercased())
                                            .font(.system(.subheadline, design: .rounded))
                                            .fontWeight(.heavy)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                            .foregroundColor(.white)
                                        
                                    }
                                }
                                
                                
                                
                            }
                            //.frame(maxWidth: 120)
                            .frame(width: UIScreen.screenWidth / 8 * 2.5)
                            .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                    }}
                
                
                // YAZILAR
                VStack(alignment: .leading) {
                    
                    // BUGÜN
                    Spacer()
                    VStack(alignment: .leading, spacing: 6) {
                        Text(todayAllTask > 0 ? getMotivationalText() : getTextIfNoTaskToday())
                            .font(.headline)
                            .bold()
                            .padding(.trailing)
                            .lineLimit(3)
                            .minimumScaleFactor(0.1)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if todayClosedTask > 0 {
                            if todayAllTask > 0 {
                                HStack{
                                    Text("\(todayClosedTask) / \(todayAllTask) \("numberOfTaskCompleted".localized())")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                            
                        }
                    }
                    .foregroundColor(.white)
                    
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    
                    // MINI STATS
                    HStack{
                        HStack {
                            Text("pastTaskNumber".localized().uppercased())
                                .StatLabelStyle()
                                .multilineTextAlignment(.trailing)
                                .minimumScaleFactor(0.5)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("\(numberOfPreviousTask)")
                                .ScoreNumberStyle()
                                .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
                                .lineLimit(1)
                        } // hstack
                        .minimumScaleFactor(0.1)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color("ColorTransparentBlack"))
                        .cornerRadius(8)
                        
                        
                        HStack {
                            
                            Text("\(numberOfFutureTasks)")
                                .ScoreNumberStyle()
                                .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
                                .lineLimit(1)
                            Text("futureTaskNumber".localized().uppercased())
                                .StatLabelStyle()
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                        } // hstack
                        .minimumScaleFactor(0.1)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color("ColorTransparentBlack"))
                        .cornerRadius(8)
                    }
                    
                    
                }
                
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal,5)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 180)
        .background(Utils.AppThemeBackgroundColor)
        .cornerRadius(8)
        .shadow(color: Color(Utils.AppColor1).opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
        .frame(width: UIScreen.main.bounds.width - 30)
        
    }
    
    // MARK: FUNCTIONS
    
    func getMotivationalText() -> String {
        
        switch calculatedCompletionForText {
        case 0:
            return "\(todayAllTask) \("motivationalMessageFor_0".localized())"
        case 1...20:
            return "motivationalMessageFor_1-20".localized()
            
        case 21...49:
            return "motivationalMessageFor_21-49".localized()
            
        case 50...65:
            return "motivationalMessageFor_50-65".localized()
            
            
        case 66...80:
            return "motivationalMessageFor_66-80".localized()
            
            
        case 81...99:
            return "motivationalMessageFor_81-99".localized()
            
        case 100:
            return "motivationalMessageFor_100".localized()
            
        default:
            return ""
        }
        
    }
    func getTextIfNoTaskToday() -> String {
        if numberOfPreviousTask > 0 {
            return "motivationalMessageWhen_NoToday-YesPast".localized()
        } else {
            return "motivationalMessageWhen_NoToday-NoPast".localized()
        }
    }
    
    
    
}



// MARK: PREVIEW
struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}



