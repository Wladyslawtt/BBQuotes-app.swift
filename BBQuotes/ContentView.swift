//
//  ContentView.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 24/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{ //תצוגת כרטיסיות
            //הקוסטאנס אלה קיצורים שיצרנו בתקייה קונסטנס לשמות של הסדרות
            //במקום לרשום כל פעם את שם הסדרה יצרנו קיצור דרך
            Tab(Constants.bbName, systemImage: "tortoise") {
                FetchView(show: Constants.bbName)
              }
            Tab(Constants.bcsName,systemImage: "briefcase"){
                FetchView(show: Constants.bcsName)
              }
            
            Tab(Constants.ecName,systemImage: "car"){
                FetchView(show: Constants.ecName)
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
