//
//  BasicStatsView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 23.04.2021.
//

import SwiftUI

struct BasicStatsView: View {
    // MARK: PROPERTIES
    
    @AppStorage("isSummaryVisible") var isSummaryBig: Bool = false
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"
    
    
    
    let haptics = UIImpactFeedbackGenerator()

    
    
    var numberOfPreviousTask = 1
    var numberOfFutureTasks = 1
    var closedNumber = 70
    var totalNumber = 100
    
    var calculatedCompletionForText: Float {
        
        let calculatedProgress = (Float(closedNumber) / Float(totalNumber) ) * 100
        return calculatedProgress
    }
    
    var calculatedCompletionForBar: Float {
        return (calculatedCompletionForText / 100)
    }
    
    
    
    
    // MARK: BODY
    var body: some View {
        
        VStack{
            
        // MARK: GENİŞ ÖZET
        if isSummaryBig == true {
            ZStack(alignment: .topTrailing) {
                
                
                ZStack(alignment: .leading){

                // BACKGROUND
                Group{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Utils.AppThemeBackgroundColor)
                        .shadow(color: Color.primary.opacity(0.2), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                        .animation(.spring())

                    Image("backgroundStat")
                        .resizable()
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        .animation(.spring())
                }
                

                // INFO
                VStack {
                    HStack {
                        VStack(alignment: .leading){
                            VStack(alignment: .leading) {
                                
                                // PROGRESS BAR
                                ZStack {
                                    
                                    // PROGRESS
                                    Group {
                                        ZStack{

                                                Circle()
                                                    .stroke(lineWidth: 3.0)
                                                    .opacity(0.3)
                                                    .foregroundColor(Color.white)
                                                
                                                Circle()
                                                    .trim(from: 0.0, to: CGFloat(min(self.calculatedCompletionForBar, 1.0)))
                                                    .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                                                    .foregroundColor(Color.white)
                                                    .rotationEffect(Angle(degrees: 270.0))
                                                    .animation(.linear)
                                                    .shadow(color: Color.primary.opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                                                
                                            }
                                            .padding(10)
                                            .scaledToFit()
                                            .minimumScaleFactor(0.5)
                                    }
                                    
                                    // %'li kısım
                                    Group{
                                        VStack {
                                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                                Text("%")
                                                    .font(.system(.title3, design: .rounded))
                                                    .fontWeight(.heavy)
                                                Text(String(format: "%.0f", calculatedCompletionForText))
                                                    .font(.system(.title, design: .rounded))
                                                    .fontWeight(.heavy)
                                                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                                                

                                            }
                                            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                                            
                                            
                                            Text("BUGÜN")
                                                .font(.system(.subheadline, design: .rounded))
                                                .fontWeight(.light)
                                                .scaledToFit()
                                                .minimumScaleFactor(0.5)
                                        }
                                    }

                                }
                                
                                // OTHER STATS
                                if numberOfPreviousTask > 0 || numberOfFutureTasks > 0 {
                                    // MINI STATS
                                    HStack{
                                        HStack {
                                            Text("Zamanı\nGeçen".uppercased())
                                                .StatLabelStyle()
                                                .multilineTextAlignment(.trailing)
                                            
                                            Text("\(numberOfPreviousTask)")
                                                .ScoreNumberStyle()
                                                .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
                                                .layoutPriority(1)
                                            
                                        } // hstack
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 10)
                                        .frame(minWidth: 100)
                                        .background(Color("ColorTransparentBlack"))
                                        .cornerRadius(8)
                                        
                                        
                                        HStack {
                                            
                                            Text("\(numberOfFutureTasks)")
                                                .ScoreNumberStyle()
                                                .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
                                                .layoutPriority(1)
                                            
                                            Text("Gelecek\nZaman".uppercased())
                                                .StatLabelStyle()
                                                .multilineTextAlignment(.leading)
                                            
                                            
                                            
                                        } // hstack
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 10)
                                        .frame(minWidth: 100)
                                        .background(Color("ColorTransparentBlack"))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                          
                    }
                    
                }
                .padding()
                .animation(.spring())
                    
                    
                    
                    GeometryReader { geo in
                        HStack {
                            Spacer()
                            Image("statCalender")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width / 2)
                                .frame(height: geo.size.height)
                        }
                        .offset(x: 20, y: 0)
                        
                    }
                }
                
                
                // ÖZET KÜÇÜLTME BUTTON
                Button(action: {
                    isSummaryBig = false
                    haptics.impactOccurred()
                }, label: {
                    HStack {
                        Image(systemName: "arrow.up")
                            .font(.caption)
                        Text("Daralt")
                            .font(.system(.footnote, design: .rounded))
                            .multilineTextAlignment(.trailing)
                            
                            
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color("ColorTransparentBlack"))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
                    .padding(8)
                })
                
  
            }
            .animation(.spring())
            .frame(maxWidth: 640, idealHeight: 200, maxHeight: 200)
        }
        
        
        
        
        
        // MARK: MİNİ ÖZET
        else {
            
            Button(action: {
                isSummaryBig = true
                haptics.impactOccurred()
            }, label: {
                ZStack(alignment: .trailing){
                    
                    
                    // BACKGROUND
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Utils.AppThemeBackgroundColor)
                        .shadow(color: Color.primary.opacity(0.2), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                        .animation(.spring())
                    
                    
                    // INFO
                    HStack {
                        VStack(alignment: .leading){
                            
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                
                                Text("BUGÜN: ")
                                    .font(.system(.subheadline, design: .rounded))
                                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                                Text("%")
                                    .font(.system(.subheadline, design: .rounded))
                                    .fontWeight(.heavy)
                                Text(String(format: "%.0f", calculatedCompletionForText))
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.heavy)
                                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
 
                                
                            }
                            
                            
                            
                            if numberOfPreviousTask > 0 {
                                HStack{
                                    Text("Zamanı geçen: \(numberOfPreviousTask)")
                                        .font(.system(.subheadline, design: .rounded))
                                        .fontWeight(.light)
                                }
                            }
                            
                            if numberOfFutureTasks > 0 {
                                HStack{
                                    Text("Gelecek: \(numberOfFutureTasks)")
                                        .font(.system(.subheadline, design: .rounded))
                                        .fontWeight(.light)
                                }
                            }
                            
                            
                            
                        }
                        .foregroundColor(.white)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    
                    
                    // GENİŞLETME BUTTON
                    
                    HStack {
                        Image(systemName: "arrow.down")
                            .font(.caption)
                        Text("Genişlet")
                            .font(.system(.footnote, design: .rounded))
                            .multilineTextAlignment(.trailing)
                        
                        
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color("ColorTransparentBlack"))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
                    .padding(8)
                    
                    

                    
                }
                .animation(.spring())
                .frame(maxWidth: 640, idealHeight: 50, maxHeight: 50)
            })
            .animation(.spring())
            
        }
        }
        .animation(.spring())

        
            
        
        
    }
}


// MARK: PREVIEW
struct BasicStatsView_Previews: PreviewProvider {
    static var previews: some View {
        
        BasicStatsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
            .previewLayout(.sizeThatFits)
            .padding()
        
        BasicStatsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
