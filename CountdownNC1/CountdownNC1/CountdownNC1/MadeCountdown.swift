import SwiftUI

struct MyBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                Text("Countdowns")
                    .foregroundColor(.white)
            }
        }
    }
}

struct MadeCountdown: View {
    
    @ObservedObject var ObjectList = EventsView
    
    @State var myEvent: Event
    
    var body: some View {
        NavigationView {
            NavigationStack {
                ZStack{
                    myEvent.color.ignoresSafeArea(.all)
                    VStack (spacing: 30) {
                        Circle()
                            .frame(width: 150)
                            .opacity(0.6)
                            .overlay(Text(getRecurrenceEmoji(emojiLocal: myEvent.emoji)))
                            .font(.largeTitle)
                        
                        VStack {
                            Text("\(myEvent.text)")
                                .bold()
                                .font(.title)
                                .foregroundColor(.white)
                            Text("\(myEvent.selectedDate)")
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                        
                        Rectangle()
                            .frame(width: 200, height: 70)
                            .opacity(0.6)
                            .overlay(
                                VStack {
                                    Text("Remaining Time:")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("\(myEvent.remainingDays)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                })
                        VStack {
                            Spacer()
                                .frame(height: 80)
                            HStack {
                                Spacer()
                                
                                Button { } label: {
                                    Circle()
                                        .foregroundColor(.black)
                                        .opacity(0.6)
                                }
                                .frame(width: 70)
                                .padding()
                                .opacity(0.9)
                                .overlay(Image(systemName: "square.and.arrow.up").foregroundColor(.white))
                            }
                        }
                    }
                    .padding()
                  
                }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: MyBackButton())
            .navigationBarItems(
                        trailing: HStack {
                            Button("Edit") {
                               
                            }
                            .foregroundColor(.white)
                            Button {
                               
                            } label: {
                                Image(systemName: "ellipsis").foregroundColor(.white)
                            }
                        }
                    )
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
    
}

#Preview {
    MadeCountdown(myEvent: Event(emoji: .party, text: "Countdown", selectedDate: Date(), color: .green))
}
