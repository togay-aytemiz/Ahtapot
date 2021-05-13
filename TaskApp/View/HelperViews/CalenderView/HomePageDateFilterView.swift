//
//  HomePageDateFilterView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 8.05.2021.
//

import SwiftUI

struct HomePageDateFilterView: View {
    // MARK: PROPERTIES
    
    
    @StateObject var homeData = HomeViewModel()
    
    var seenDate: Text {
        if homeData.checkFilterDate() == "Other day" {
            return Text(homeData.filterDate, formatter: miniDateFormat)
        } else {
            return Text(homeData.checkFilterDate())
        }
    }
    
    
    // MARK: BODY
    var body: some View {

            
        HStack {
            HStack(spacing: 16){
                
                Image(systemName: "calendar.badge.clock")
                    .foregroundColor(Color(Utils.AppColor1))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                
                
                seenDate
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
                
                
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                
                
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Utils.isDarkMode ? Color.gray : Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            Spacer()
            
        }
        .padding(.bottom)
        .frame(width: UIScreen.main.bounds.width - 30)
        
    }
}


// MARK: PREVIEW
struct HomePageDateFilterView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageDateFilterView()
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.light)
    }
}
