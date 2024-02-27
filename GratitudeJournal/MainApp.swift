//
//  AkshayProjectApp.swift
//  AkshayProject
//
//  Created by Amit Kumar Dhal on 24/02/24.
//

import SwiftUI

@main
struct AkshayProjectApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.preferredFont(forTextStyle: .extraLargeTitle2)]
           UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.preferredFont(forTextStyle: .extraLargeTitle2)]
        let fetchedItems = ItemDataManager.shared.fetchItems()
        for item in fetchedItems {
            print("Item ID: \(item.id), Title: \(item.title), Date: \(item.date), ImageURL: \(item.imageURL)")
        }
       }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}


struct MainView: View {
    var body: some View {
        TabView {
            ContentView1(dateChange: Date(), isShowAddGoalView: false, goalDataArray: [], goalDataArrayOriginalData: [], isRemoveFilterClicked: false)
                .tabItem( {
                    Image(systemName: "house.circle.fill")
                Text("Home")
            })//:ContentView
            
            ContentView(text: "", selectedImage: UIImage(named: "add-image")!)
                .tabItem({
                    
                    Image(systemName: "pencil.tip.crop.circle.badge.plus")
                    
                    //Image(systemName: "magnifyingglass.circle.fill")
                    Text("Add Gratitude")
                })//: VideoListView
            
            MileStoneView(totleScore: 0, progress: 0, scoreData: "", scoreData2: "", scoreData3: "", scoreData4: "", scoreData5: "", statusMessage: "", goalDataArray: [])
                .tabItem({
                    Image(systemName: "star.leadinghalf.filled")
                    Text("Goals")
                })
        } .tint(.black)
    }
}
