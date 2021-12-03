//
//  TimingGuidelinesView.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

struct TimeSpentVC: View {
    
    init(something: ActivitySets, hello: Int) {
        self._set = State(initialValue: something)
        
        self._activityArray = State(initialValue: something.activities)
        self._timeDiff = State(initialValue: hello)
        
    }
    
    @State var activityArray: [Activity] = []
    @State var timeDiff: Int
    @State var showAlert = false
    @State var showDetail: Bool = false
    @State var timeDiff2: Int = 0
    @State var set: ActivitySets
    @State var time1: [Int] = [0]

    var body: some View {
        
        VStack(alignment:.leading){
            List(activityArray) { timings in
                VStack(alignment:.leading){
                    HStack {
                        Text(timings.name1)
                            .font(.system(size: 20))
                            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                            .fontWeight(.bold)
                            .padding(.bottom)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        Text("")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                            .fontWeight(.regular)
                    }
                    Spacer()
                    HStack {
                        Text(timings.Priority)
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                            .fontWeight(.regular)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        if  timings.timeSpending < (timings.minTime-2) {
                            Text("0 min")
                                .font(.system(size: 18))
                                .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                                .fontWeight(.medium)
                                .padding(.bottom)
                        }
                        else {
                            Text("\(timings.timeSpending) min")
                                .font(.system(size: 18))
                                .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                                .fontWeight(.medium)
                                .padding(.bottom)
                        }
                    }
                }
                .onAppear{
                    for n in activityArray{
                        if n.Priority == "Very High Priority"{
                            time1.append(5)
                        } else if n.Priority == "High Priority" {
                            time1.append(4)
                        }else if n.Priority == "Medium Priority"{
                            time1.append(3)
                        }else if n.Priority == "Low Priority"{
                            time1.append(2)
                        }else if n.Priority == "Very Low Priority"{
                            time1.append(1)
                        }
                        
                    }
                    let newValue = time1[..<(activityArray.count+1)]
                    if timeDiff < 0 {
                        timeDiff2 = timeDiff + (24*60)
                    } else {
                        timeDiff2 = timeDiff
                    }
                    let timeValue = timeDiff2/(newValue.reduce(0, +))
                    for (index, i) in
                            activityArray.enumerated() {
                        
                        if i.Priority == "Very High Priority"{
                            
                            for activity in activityArray{
                                if activity.id == i.id {
                                    self.activityArray[index].timeSpending = (timeValue*5)
                                    print(activityArray[index].timeSpending)
                                    
                                }
                                
                            }
                        } else if i.Priority == "High Priority" {
                            for activity in activityArray {
                                if activity.id == i.id {
                                    self.activityArray[index].timeSpending = (timeValue*4)
                                    print(activityArray[index].timeSpending)
                                    
                                }
                                
                            }
                        } else if i.Priority == "Medium Priority"{
                            for activity in activityArray {
                                if activity.id == i.id {
                                    self.activityArray[index].timeSpending = (timeValue*3)
                                    print(activityArray[index].timeSpending)
                                }
                                
                            }
                        }else if i.Priority == "Low Priority"{
                            for activity in activityArray {
                                if activity.id == i.id {
                                    self.activityArray[index].timeSpending = (timeValue*2)
                                    print(activityArray[index].timeSpending)
                                }
                            }
                        }else if i.Priority == "Very Low Priority"{
                            for activity in activityArray {
                                if activity.id == i.id {
                                    self.activityArray[index].timeSpending = (timeValue*1)
                                    print(activityArray[index].timeSpending)
                                }
                            }
                        }
                    }
                    print(newValue)
                    print(timeDiff2)
                    print(timeDiff)
                    print(timeValue)
                    print(set.activities)
                }
                .padding()
                .background(Color(hue: 0.742, saturation: 0.149, brightness: 0.99))
                .cornerRadius(20)
                .padding(.vertical, 1)
                .listRowSeparator(.hidden)
            }
            
            .listStyle(.plain)
        }   .navigationBarTitle(Text("To do:"))
            .navigationBarItems(trailing: Button(action: {
                showAlert = true
            }, label: {
                Image(systemName: "info.circle")
            }).alert(isPresented: $showAlert) {
                Alert(title: Text("Not enough time"), message: Text("If you see 0 min in your activity, it means that there is not enough time to complete it. Hence, you can skip it and proceed to the next activity or change the times your choose to give yourself sufficeint time to complete the activities"))
            })
    }
}

struct TimeSpentVC_Previews: PreviewProvider {
    static var previews: some View {
        TimeSpentVC(something: ActivitySets(name: "School", activities: [Activity(name1: "Brushing", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5), Activity(name1: "Bathing", timeSpending: 15, Percentage: "20%", Priority: "High Priority", minTime: 1, maxTime: 5)]), hello: 60).preferredColorScheme(.light)
    }
}
