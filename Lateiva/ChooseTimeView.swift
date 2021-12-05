//
//  ChooseTimeView.swift
//  Lateiva
//
//  Created by sanjithsethu on 28/11/21.
//

import SwiftUI

struct startTimeVC: View {
    
    init(setsa: Binding<[ActivitySets]>) {
        self._setsa = setsa
    }
    
    var time1 = [0]
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    @Binding var setsa: [ActivitySets]
    var timeDiff: Int {
        return (Calendar.current.dateComponents([.minute], from: date, to: date1).minute ?? 0)
    }
    @State private var date = Date()
    @State private var date1 = Date()

    var body: some View {
        Form{
            Section {
                DatePicker(
                    "",
                    selection: $date,
                    in: dateRange,
                    displayedComponents: [.hourAndMinute]
                ).datePickerStyle(WheelDatePickerStyle())
                    .padding([.bottom, .trailing])
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                    .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
            } header: {
                Text("When would you like to start getting ready?")
                    .padding(.bottom)
            }
            
            Section() {
                if timeDiff < 0{
                Text("Tommorow")
                        .padding([.bottom, .trailing])
                        .frame(maxWidth: .infinity,alignment: .center)
                }
                DatePicker(
                    "",
                    selection: $date1,
                    in: dateRange,
                    displayedComponents: [.hourAndMinute]
                ).datePickerStyle(WheelDatePickerStyle())
                    .padding([.bottom, .trailing])
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
                    .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
            } header: {
                Text("When would you like to leave your house?").padding(.bottom)
            }
            
            NavigationLink(destination: chooseActivitySetVC(set: $setsa, timeDiff: timeDiff)){
                Button {
                    
                } label: {
                    
                    Text("Continue")
                        .foregroundColor(.blue)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, minHeight: 60)
                }
            }
        }
        .navigationBarTitle(Text("Hello"))
        .foregroundColor(Color(red: 0.4235294117647059, green: 0.11764705882352941, blue: 0.5254901960784314))
    }
    func hidden(_ shouldHide: Bool) -> some View {
            opacity(shouldHide ? 0 : 1)
        }
    
    struct startTimeVC_Previews: PreviewProvider {
        static var previews: some View {
            startTimeVC(setsa: .constant([])).preferredColorScheme(.light)
        }
    }
}
