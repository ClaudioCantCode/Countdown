//
//  ContentView.swift
//  CountdownNC1
//
//  Created by Antonio Claudio Pepe on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.5
    @State var isPresented: Bool = false
    @State var isChecked: Bool = true
    @State private var text: String = ""
    
    var body: some View {
        
        Text("Countdowns")
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .font(Font.custom("Comic Sans MS", size:35))
        
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
                    .font(Font.custom("Comic Sans MS Bold", size:30))
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
                    .font(Font.custom("Comic Sans MS", size:13))
                    
                    Section(header: Text("Pick an emoji icon")) {
                    }
                    .font(Font.custom("Comic Sans MS", size:13))
                    Section(header: Text("Pick a date")) {
                        DatePicker(selection: .constant(.now), displayedComponents: .date) {
                            Text("data")
                        }
                        .datePickerStyle(.graphical)
                    }
                    .font(Font.custom("Comic Sans MS", size:13))
                    Section(header: Text("Pick a time")) {
                        DatePicker(selection: .constant(.now), displayedComponents: .hourAndMinute) {
                            Text("All-day")
                        }
                    }
                    .font(Font.custom("Comic Sans MS", size:13))
                    Section(header: Text("Repeat")) {
                        Text("Item 1")
                    }
                    .font(Font.custom("Comic Sans MS", size:13))
                    Section(header: Text("Remind me")) {
                        Text("Item 1")
                    }
                    .font(Font.custom("Comic Sans MS", size:13))
                    Section(header: Text("Pick a color")) {
                        Text("Item 1")
                    }
                }
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        Button("Cancel") {
                            isPresented = false
                        }
                        .bold()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            isPresented = false
                        }
                        .bold()
                    }
                })
            }
        })
    }
}


#Preview {
    ContentView()
}
