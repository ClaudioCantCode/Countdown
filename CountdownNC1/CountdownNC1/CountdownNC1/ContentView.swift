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
enum Emoji {
    case party, lunch, travel, job
}





struct ContentView: View {
    
    
    @ObservedObject var ObjectList = EventsView
    
    
    @StateObject private var viewModel = ContentViewModel()

    @State private var timer: Timer?
    
    @State private var scale: CGFloat = 1.5
    @State var isPresented: Bool = false
    @State var isChecked: Bool = true
    
    @State private var text: String = ""
    @State private var selectedRepeat: Repeat = .off
    @State var repeatWeek: Int = 0
    @State var repeatMonth: Int = 0
    @State var daybefore: Bool = false
    @State var weekbefore: Bool = false
    
  
   
    //Array
    @State var CountdownList: [String] = []
    
    
    //Array
    
    
    
    
    var body: some View {
        
        
        NavigationStack {
            VStack {
                List{
                    
                    ForEach(ObjectList.EventList) { event in
                        NavigationLink {
                            MadeCountdown(myEvent: event)
                        } label: {
                            HStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(event.color)
                                    .frame(width: 370, height: 95)
                                    .overlay {
                                        HStack {
                                            Text(getRecurrenceEmoji(emojiLocal: event.emoji))
                                            .font(.title)
                                            
                                            VStack {
                                                if event.text == "" {
                                                    Text("Countdown")
                                                        .font(.title)
                                                        
                                                }
                                                Text("\(event.text)")
                                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                Text("\(event.selectedDate)")
                                            }
                                            .foregroundColor(.white)
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundColor(.black)
                                                .opacity(0.5)
                                                .frame(width: 100, height: 95)
                                                .overlay {
                                                    VStack {
                                                        Text(String(event.remainingDays)).foregroundColor(.white)
                                                        Text("Days left").foregroundColor(.white)
                                                    }
                                                }.offset(x: 18)
                                            
                                        }.padding()
                                    }
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                            ObjectList.EventList.remove(atOffsets: indexSet)
                    })
                }
                .listStyle(.plain)
                
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
                                startTimer()
                            }
                            .bold()
                            .foregroundColor(.white)
                            .font(.title)
                            .onTapGesture {
                            startTimer()
                            }
                        }
                    }
                }
                .padding()
               
            }
            .fullScreenCover(isPresented: $isPresented){
                ModalView(isPresented: $isPresented)
            }
            .onAppear {
                viewModel.calculateRemainingDays()
                startTimer()
            }
            .onDisappear {
                stopTimer()
                       }
            .navigationTitle("Countdowns")
        }
    }
    
    func getRecurrenceEmoji(emojiLocal: Emoji) -> String {
        switch emojiLocal {
        case .party:
            return "🎉"
        case .travel:
            return "✈️"
        case .job:
            return "💼"
        case .lunch:
            return "🍽️"
        }
    }
    
    private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            }
        }

        private func stopTimer() {
            timer?.invalidate()
        }
    
}


#Preview {
    ContentView()
}
