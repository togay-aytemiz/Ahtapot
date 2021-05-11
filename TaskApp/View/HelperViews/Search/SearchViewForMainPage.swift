//
//  SearchViewForMainPage.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct SearchViewForMainPage: View {
    // MARK: PROPERTIES
    
    @State private var searchOpen = false
    @EnvironmentObject var obj: observed
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    
    
    // MARK: BODY
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(AppColor1))
                    .padding(.leading, 4)
                
                Text("Görevler içinde ara...")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(Color.secondary)
                
                Spacer()
            }
            .padding(.horizontal,5)
            .padding(.vertical, 8)
            .background(isDarkMode ? Color.gray.opacity(0.5) : Color(AppColor1).opacity(0.1))
            .cornerRadius(8)
            .onTapGesture {
                searchOpen.toggle()
            }
        }
        .background(EmptyView().sheet(isPresented : $searchOpen) {SearchView().environmentObject(obj)})
        .padding(.vertical)
        .frame(width: UIScreen.main.bounds.width - 30)

        
        
        
    }
}


// MARK: PREVIEW
struct SearchViewForMainPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewForMainPage()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
