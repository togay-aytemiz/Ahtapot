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
    
    // MARK: BODY
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(Utils.AppColor1))
                    .padding(.leading, 4)
                
                Text("Görevlerin içinde ara...")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(Utils.isDarkMode ? Color.white.opacity(0.8) : Color.black.opacity(0.8))
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Utils.isDarkMode ? Color.gray.opacity(0.5) : Color.gray.opacity(0.1))
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
