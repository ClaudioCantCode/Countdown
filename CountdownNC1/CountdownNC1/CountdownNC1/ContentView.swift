//
//  ContentView.swift
//  CountdownNC1
//
//  Created by Antonio Claudio Pepe on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.5
    
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
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .bold()
                    .foregroundColor(.white)
                    .font(Font.custom("Comic Sans MS Bold", size:30))
                }
                }
        }
        .padding()
        }
    }


#Preview {
    ContentView()
}
