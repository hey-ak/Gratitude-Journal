import Foundation
import SwiftUI

struct MileStoneView1: View {
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("You've earned 1,000 points!")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .padding(.leading,8)
                    Spacer()
                    Text("+1000")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .padding(.trailing,8)
                }
                Spacer()
                    .frame(height: 40, alignment: .center)
                
                LinearProgress(progress: 40, foregroundColor: .black,backgroundColor: .gray,cornerRadius: 5, fillAxis: .horizontal)
                    .frame(height: 10)
             
             Spacer()
                    .frame(height: 40, alignment: .center)
                
                HStack {
                    VStack {
                        HStack {
                            Text("Keep it up! You're on a roll.")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            Text("You're halfway to your next milestone")
                                .foregroundStyle(.gray)
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                    Spacer()
                    HStack {
                        Text("500/1000")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                            .padding(.trailing,8)
                    }
                }
                Spacer()
            }
            .padding(20)
            .background(.white)
            .navigationTitle("Milestones")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MileStoneView: View {
    
    @State var totleScore:Int
    @State var progress:Double
    
    @State var scoreData:String
    @State var scoreData2:String
    @State var scoreData3:String
    @State var scoreData4:String
    @State var scoreData5:String
    
    @State var statusMessage:String
    @State var goalDataArray:[Item]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("You've earned \(totleScore) points!")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .padding(.leading,8)
                    Spacer()
                    Text("+\(totleScore)")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .padding(.trailing,8)
                }
                Spacer()
                    .frame(height: 40, alignment: .center)
                
                LinearProgress(progress:progress,
                               foregroundColor: .black,
                               backgroundColor: .gray,
                               cornerRadius: 5,
                               fillAxis: .horizontal)
                    .frame(height: 10)
             
             Spacer()
                    .frame(height: 40, alignment: .center)
                
                HStack {
                    VStack {
                        HStack {
                            Text("Keep it up! You're on a roll.")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            Text("You're halfway to your next milestone")
                                .foregroundStyle(.gray)
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                    Spacer()
                    HStack {
                        Text(scoreData)
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                            .padding(.trailing,8)
                    }
                }
                
                Spacer()
                       .frame(height: 40, alignment: .center)
                   
                   HStack {
                       VStack {
                           HStack {
                               Text("Keep it up! You're on a roll.")
                                   .font(.system(size: 16, weight: .medium, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                           Spacer()
                               .frame(height: 5)
                           HStack {
                               Text("You're halfway to your next milestone")
                                   .foregroundStyle(.gray)
                                   .font(.system(size: 14, weight: .semibold, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                       }
                       Spacer()
                       HStack {
                           Text(scoreData2)
                               .font(.system(size: 16, weight: .medium, design: .default))
                               .multilineTextAlignment(.trailing)
                               .lineLimit(1)
                               .padding(.trailing,8)
                       }
                   }
                   
                
                Spacer()
                       .frame(height: 40, alignment: .center)
                   
                   HStack {
                       VStack {
                           HStack {
                               Text("Keep it up! You're on a roll.")
                                   .font(.system(size: 16, weight: .medium, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                           Spacer()
                               .frame(height: 5)
                           HStack {
                               Text("You're halfway to your next milestone")
                                   .foregroundStyle(.gray)
                                   .font(.system(size: 14, weight: .semibold, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                       }
                       Spacer()
                       HStack {
                           Text(scoreData3)
                               .font(.system(size: 16, weight: .medium, design: .default))
                               .multilineTextAlignment(.trailing)
                               .lineLimit(1)
                               .padding(.trailing,8)
                       }
                   }
                   
                Spacer()
                       .frame(height: 40, alignment: .center)
                   
                   HStack {
                       VStack {
                           HStack {
                               Text("Keep it up! You're on a roll.")
                                   .font(.system(size: 16, weight: .medium, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                           Spacer()
                               .frame(height: 5)
                           HStack {
                               Text("You're halfway to your next milestone")
                                   .foregroundStyle(.gray)
                                   .font(.system(size: 14, weight: .semibold, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                       }
                       Spacer()
                       HStack {
                           Text(scoreData4)
                               .font(.system(size: 16, weight: .medium, design: .default))
                               .multilineTextAlignment(.trailing)
                               .lineLimit(1)
                               .padding(.trailing,8)
                       }
                   }
                   
                
                Spacer()
                       .frame(height: 40, alignment: .center)
                   
                   HStack {
                       VStack {
                           HStack {
                               Text("Keep it up! You're on a roll.")
                                   .font(.system(size: 16, weight: .medium, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                           Spacer()
                               .frame(height: 5)
                           HStack {
                               Text("You're halfway to your next milestone")
                                   .foregroundStyle(.gray)
                                   .font(.system(size: 14, weight: .semibold, design: .default))
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Spacer()
                           }
                       }
                       Spacer()
                       HStack {
                           Text(scoreData5)
                               .font(.system(size: 16, weight: .medium, design: .default))
                               .multilineTextAlignment(.trailing)
                               .lineLimit(1)
                               .padding(.trailing,8)
                       }
                   }
                   
                
                Spacer()
            }
            .padding(20)
            .background(.white)
            .navigationTitle("Milestones")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .onAppear {
            handleInitialSetup()
        }
    }
    
    private func handleInitialSetup() {
        let scoreData = ItemDataManager.shared.fetchScoreData()
        let scoreInInt = Int(scoreData.totleScore)
        self.totleScore = scoreInInt
        goalDataArray = ItemDataManager.shared.fetchItems()
        handleCurrentDateData()
    }
    
    private func handleCurrentDateData() {
        var goalDataArray1 = [Item]()
         let calendar = Calendar.current
         let startOfDay = calendar.startOfDay(for: Date()) // Start of the day
         let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: Date()) // End of the day

         // Ensure endDate is not nil before using it in the condition
         if let endDate = endOfDay {
             for item in goalDataArray {
                 let dateData = item.date
                 if dateData >= startOfDay && dateData <= endDate {
                     goalDataArray1.append(item)
                 }
             }
         }
        
        var count = goalDataArray1.count
        totleScore = goalDataArray1.count * 100
        
      //  let maxScore = Int( Double(totleScore) / Double(1000) * 1000)
        
      //  let per = totleScore / maxScore * 100
        
        let progress = Double(count * 10)
        if progress > 100 {
            self.progress = 100
        }
        else{
            self.progress = progress
        }
        
        
        
        scoreData = "\(Int(totleScore))/1000"
        scoreData2 = "\(Int(totleScore))/5000"
        
        scoreData3 = "\(Int(totleScore))/10000"
        scoreData4 = "\(Int(totleScore))/15000"
        scoreData5 = "\(Int(totleScore))/20000"
        
        
        
        
         if goalDataArray1.count == 0 {
             statusMessage = "Add Gratitude to achieve daily goal."
         }
        else if goalDataArray1.count < 10 {
            statusMessage = "Keep it up! You're on a roll."
        }
         else if goalDataArray1.count >= 10 {
             statusMessage = "Daily Goal reached."
         }
    }
}



enum ScoreDataStatus:Int,CaseIterable {
    case zero = 0
    case mid = 1
    case finish = 2
    
    public func getMessage(_ input:ScoreDataStatus) -> String {
        switch input {
        case .zero:
            return "Add Gratitude to achieve daily goal."
        case .mid:
            return "Keep it up! You're on a roll."
        case .finish:
            return "Daily Goal reached."
        }
    }
}
