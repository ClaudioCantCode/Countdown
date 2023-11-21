//
//  ContentViewModel.swift
//  CountdownNC1
//
//  Created by Antonio Claudio Pepe on 20/11/23.
//
import SwiftUI
import Foundation



struct Event: Identifiable{
    
    var id = UUID()
    var emoji: Emoji
    var text: String
    var selectedDate: Date
    
    var remainingDays: Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: selectedDate)
        
        if let days = components.day {
           return max(0, days)
        }else{
            return 0
        }
    }
    
    var remainingHours: Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: selectedDate)
        
        
        if let hours = components.hour {
            return max(0, hours)
        }else{
            return 0
        }
    }
    
    var remainingMinutes: Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: selectedDate)
        
        
        if let hours = components.minute {
            return max(0, 59)
        }else{
            return 0
        }
    }
    
    var color: Color
    
        
}

class EventViewModel: ObservableObject{
    
    @Published var EventList: [Event] = [
    ]
    
}

var EventsView = EventViewModel()


@Observable
class ContentViewModel: ObservableObject {
    
   var remainingTime: String {
            let calendar = Calendar.current
            let currentDate = Date()
            let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: selectedDate)

            guard let days = components.day,
                  let hours = components.hour,
                  let minutes = components.minute,
                  let seconds = components.second else {
                return ""
            }

            return String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
        }
    
    var emojiSelector: Emoji = .party
    var selectedDate = Date()
    var remainingDays: Int = 0
    var pickerColor: Color = .blue
    var remainingHours: Int = 0
    var remainingMinutes: Int = 0
    
    private var timer: Timer?
    
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: selectedDate)
        
    }
    
    func calculateRemainingDays() {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.day], from: currentDate, to: selectedDate)
        
        if let days = components.day {
            remainingDays = max(0, days)
        }
    }
    func calculateRemainingHours() {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.hour], from: currentDate, to: selectedDate)
        
        if let days = components.hour {
            remainingHours = max(0, days)
        }
    }
    func calculateRemainingMinutes() {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.minute], from: currentDate, to: selectedDate)
        
        if components.minute != nil {
            remainingMinutes = max(0, 59)
        }
    }

}

