//
//  ModalView.swift
//  CountdownNC1
//
//  Created by Antonio Claudio Pepe on 21/11/23.
//

import SwiftUI

struct ModalView: View {
    
    @Binding var isPresented: Bool
    
    @State private var scale: CGFloat = 1.5
    @State var isChecked: Bool = true
    
    @ObservedObject var ObjectList = EventsView
    
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var text: String = ""
    @State var pickerColor: Color = .blue
    @State private var selectedRepeat: Repeat = .off
    @State var repeatWeek: Int = 0
    @State var repeatMonth: Int = 0
    @State var daybefore: Bool = false
    @State var weekbefore: Bool = false
    
    @State var emojiVar: Emoji = .party
    @State var selectedDate = Date()
    
   
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Pick a name")) {
                    TextField("Name your countdown", text: $text)
                    
                }
                Section(header: Text("Pick an emoji icon")) {
                    
                    Picker(selection: $emojiVar, label: Text("Emoji")) {
                        Text("🎉").tag(Emoji.party)
                        Text("🍽️").tag(Emoji.lunch)
                        Text("✈️").tag(Emoji.travel)
                        Text("💼").tag(Emoji.job)
                        
                    }
                    .pickerStyle(.segmented)
                    
                    
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
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 40)
                            Circle()
                                .foregroundColor(.green)
                                .frame(width: 40)
                            Circle()
                                .foregroundColor(.brown)
                                .frame(width: 40)
                            Circle()
                                .foregroundColor(.yellow)
                                .frame(width: 40)
                            Circle()
                                .foregroundColor(.purple)
                                .frame(width: 40)
                           
                        }
                        ColorPicker("", selection: $pickerColor).accessibilityLabel("Select a color for your countdown")
                    }
                }
            }.toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button("Cancel") {
                        isPresented = false
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        //CountdownList.append(text)
                        
                        let newEvent = Event(emoji: emojiVar, text: text, selectedDate: selectedDate, color: pickerColor)
                        ObjectList.EventList.append(newEvent)
                        
                        isPresented = false
                    }
                }
            })
        }
    }
    func getRecurrenceText() -> String {
           switch selectedRepeat {
           case .off:
               return "No recurrence"
           case .weekly:
               return "Countdown will repeat every \(repeatWeek) weeks"
           case .monthly:
               return "Countdown will repeat every \(repeatMonth) months on the \(viewModel.formattedDateString)"
           case .yearly:
               return "Countdown will repeat yearly on \(viewModel.formattedDateString)"
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
               return "Countdown will repeat yearly on \(viewModel.formattedDateString)"
           }
    }
}

/*#Preview {
    var isPresented = true
    ModalView(isPresented: isPresented)
}*/
