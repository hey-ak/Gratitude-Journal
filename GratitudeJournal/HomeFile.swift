import Foundation
import SwiftUI

struct ContentView1: View {
    
    @State var dateChange:Date
    @State var isShowAddGoalView:Bool
    @State var goalDataArray:[Item]
    @State var goalDataArrayOriginalData:[Item]
    @State var isRemoveFilterClicked:Bool
    let haptic = UIImpactFeedbackGenerator(style: .medium)
    

    var body: some View {
        NavigationView {
            Group {
            VStack {
                VStack{
                RemoveFilterView(isRemoveFilterClicked: $isRemoveFilterClicked)
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: .infinity, minHeight: 20)
                    .background(Color(UIColor.clear))
                }
                .onChange(of: isRemoveFilterClicked) { _, _ in
                    if isRemoveFilterClicked == false {
                        handleFilterSelection(false, nil)
                    }
                    else{
                        isRemoveFilterClicked = true
                        
                    }
                }
                List {
                    ForEach (goalDataArray) { item in
                        NavigationLink(destination:ContentView(text: "", selectedImage: UIImage(named: "add-image")!)) {
                            AnimalListItemView(goalData: item)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                Spacer()
            }
            .background(Color.clear)
            .navigationTitle("Gratitude Journal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        DatePickerView(date: $dateChange)
                            .onChange(of: dateChange) { oldValue, newValue in
                                isRemoveFilterClicked = true
                                handleFilterSelection(true, dateChange)
                                print(dateChange)
                            }
                    }
                }
            })
           }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigate(to:ContentView(text: "", selectedImage: UIImage(named: "add-image")!), when: $isShowAddGoalView)
        .onAppear {
            goalDataArray = ItemDataManager.shared.fetchItems()
            goalDataArrayOriginalData = goalDataArray
            handleSorting()
        }
    }
    
    private func handleFilterSelection(_ isSelected:Bool,_ date:Date?) {
        if isSelected == true {
            guard let filterDate = date else {
                   return // Return the original array if isSelected is false or date is nil
               }
            
           var goalDataArray1 = [Item]()
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: filterDate) // Start of the day
            let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: filterDate) // End of the day

            // Ensure endDate is not nil before using it in the condition
            if let endDate = endOfDay {
                for item in goalDataArrayOriginalData {
                    let dateData = item.date
                    
                    // Check if dateData falls within the range of the start and end of the day
                    if dateData >= startOfDay && dateData <= endDate {
                        goalDataArray1.append(item)
                    }
                }
            }
            if goalDataArray1.count > 0 {
                goalDataArray = goalDataArray1
            }
            else{
                goalDataArray = []
            }
        }
        else{
        goalDataArray = goalDataArrayOriginalData
        }
        handleSorting()
    }
    
    private func handleSorting() {
        goalDataArray = goalDataArray.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
    }
}

struct RemoveFilterView: View {
    
    @Binding var isRemoveFilterClicked:Bool

    var body: some View {
        if isRemoveFilterClicked == true {
            HStack {
              Spacer()
                    .background(Color.clear)
                Button(action: {
                    isRemoveFilterClicked = false
                }) {
                    Text("Remove Filter")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .foregroundColor(.red)
                }
                .background(Color.clear)
                .frame(height: 20, alignment: .center)
            }
            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
       }
    }
}

struct AddGoalView: View {
    
    @Binding var isAddGoalClicked:Bool

    var body: some View {
        HStack {
          Spacer()
                .background(Color.clear)
            Button(action: {
                isAddGoalClicked = true
            }) {
              Image(uiImage:  UIImage(named: "addition")!)
                    .resizable()
                    .font(.title)
                    .foregroundColor(.accentColor)
            }
            .background(Color.clear)
            .frame(width: 40, height: 40, alignment: .center)
        }
        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
    }
}

struct AnimalListItemView: View {
    var goalData:Item
    
    var body: some View {
            HStack (alignment: .center, spacing: 16) {
                Image(uiImage:goalData.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment:.leading,spacing: 8) {
                    Text("What are you grateful for today?")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .foregroundColor(.accentColor)
                    
                    Text(goalData.title)
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.trailing,8)
                    
                    Text(getCurrentDate(goalData.date) ?? "")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .padding(.trailing,8)
                } // :VSTACK
            }// :HSTACK
    }
    
    
    func getCurrentDate(_ date:Date) -> String? {
        let formatDate = DateFormatter()
          formatDate.dateFormat = "E, MMM d"
          let drawDate = formatDate.string(from: date)
          print(drawDate)
        return drawDate
    }
}


struct DatePickerView: View {
    
    @Binding var date:Date
    
    var body: some View {
        
        ZStack{
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.compact)
                .frame(width: 20, height: 20)
                .clipped()
            SwiftUIWrapper {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .topLeading)
            }.allowsHitTesting(false)
        }//ZStack
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}
