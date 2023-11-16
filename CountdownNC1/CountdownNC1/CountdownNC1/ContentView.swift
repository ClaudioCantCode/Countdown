//
//  ContentView.swift
//  CountdownNC1
//
//  Created by Antonio Claudio Pepe on 13/11/23.
//

import SwiftUI

enum Repeat {
    case off, weekly, monthly, yearly
}

struct ContentView: View {
    @State private var scale: CGFloat = 1.5
    @State var isPresented: Bool = false
    @State var isChecked: Bool = true
    @State private var selectedDate = Date()
    @State private var text: String = ""
    @State private var selectedRepeat: Repeat = .off
    @State var repeatWeek: Int = 0
    @State var repeatMonth: Int = 0
    @State var daybefore: Bool = false
    @State var weekbefore: Bool = false
    @State private var selectedColor: Color = .blue
    @State private var pickerColor: Color = .red
    
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: selectedDate)
    }
    
    var body: some View {
        
        Text("Countdowns")
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
        Spacer()
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 270, height: 70)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .scaledToFit()
                        .scaleEffect(scale)
                        .foregroundColor(.white)
                    
                    Button("New Countdown") {
                        isPresented = true
                    }
                    .bold()
                    .foregroundColor(.white)
                    .font(.title)
                }
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isPresented, content: {
            NavigationStack {
                   List {
                    Section(header: Text("Pick a name")) {
                        TextField("Name your countdown", text: $text)
                        
                    }
                    
                    Section(header: Text("Pick an emoji icon")) {
                        
                        
                        
                    }
                    Section(header: Text("Pick a date")) {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                           
                       }
                       Section(header: Text("Pick a time")) {
                           VStack(alignment: .leading) {
                            Toggle("All-day", isOn: $isChecked)
                            if !isChecked {
                            DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.wheel)
                               }
                           }
                    }
                       Section(header: Text("Repeat")) {
                           Picker(selection: $selectedRepeat, label: Text("Repeat")) {
                               Text("Off").tag(Repeat.off)
                               Text("Weekly").tag(Repeat.weekly)
                               Text("Monthly").tag(Repeat.monthly)
                               Text("Yearly").tag(Repeat.yearly)
                           }
                           .pickerStyle(.segmented)
                           if selectedRepeat != .off {
                               if(selectedRepeat == Repeat.weekly){
                                   Stepper(value: $repeatWeek, in: 0...100) {
                                       Text(getRecurrenceText2())
                                   }
                                   
                               }else{
                                   if(selectedRepeat == Repeat.monthly){
                                       Stepper(value: $repeatMonth, in: 0...100) {
                                           Text(getRecurrenceText2())
                                       }
                                   }
                                   
                               }
                               
                               Text(getRecurrenceText())
                                   .padding()
                           }
                       }
                    Section(header: Text("Remind me")) {
                        Toggle(isOn: .constant(true)) {
                            Text("When the countdown finishes")
                        }
                        Toggle(isOn: $daybefore) {
                            Text("1 day before")
                        }
                        Toggle(isOn: $weekbefore) {
                            Text("1 week before")
                        }
                    }
                    Section(header: Text("Pick a color")) {
                        VStack {
                            HStack(spacing: 10) {
                                Button{ print("")
                                } label: {
                                     Circle()
                                        .frame(width: 40)
                                        .overlay(){
                                            Text("ok")
                                        }
                                    
                                }
                        }
                            ColorPicker("", selection: $pickerColor)
                        }
                    }
                   }
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        Button("Cancel") {
                            isPresented = false
                        }

                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            isPresented = false
                        }
                    }
                })
            }
        })
    }
    
    func getRecurrenceText() -> String {
           switch selectedRepeat {
           case .off:
               return "No recurrence"
           case .weekly:
               return "Countdown will repeat every \(repeatWeek) weeks"
           case .monthly:
               return "Countdown will repeat every \(repeatMonth) months on the \(formattedDateString)"
           case .yearly:
               return "Countdown will repeat yearly on \(formattedDateString)"
           }
    }
    func getRecurrenceText2() -> String {
           switch selectedRepeat {
           case .off:
               return "No recurrence"
           case .weekly:
               return "Repeat every \(repeatWeek) weeks"
           case .monthly:
               return "Repeat every \(repeatMonth) months"
           case .yearly:
               return "Countdown will repeat yearly on \(formattedDateString)"
           }
    }
    
}


#Preview {
    ContentView()
}
