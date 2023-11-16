import SwiftUI

struct MadeCountdown: View {
    var body: some View {
        NavigationStack {
            VStack (spacing: 30) {
                Circle()
                    .frame(width: 250)
                    .opacity(0.6)
                    .overlay(Text("Emoji"))
                
                VStack {
                    Text("Countdown")
                        .bold()
                        .font(.title)
                    Text("Friday, 17th November, 2023")
                }
                
                Rectangle()
                    .frame(width: 200, height: 70)
                    .opacity(0.6)
                    .overlay(Text("time left"))
                
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
                        .opacity(0.6)
                        .overlay(Image(systemName: "square.and.arrow.up"))
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Countdowns") {
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            })
        }
    }
}

struct MadeCountdown_Previews: PreviewProvider {
    static var previews: some View {
        MadeCountdown()
    }
}
