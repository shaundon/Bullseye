//
//  ContentView.swift
//  Bullseye
//
//  Created by Shaun Donnelly on 17/04/2020.
//  Copyright © 2020 Shaun Donnelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                // Target row.
                HStack {
                    Text("Put the bullseye as close as you can to:")
                    Text("\(self.target)")
                }
                
                Spacer()
                
                // Slider row.
                HStack {
                    Text("1")
                    Slider(value: self.$sliderValue, in: 1...100)
                    Text("100")
                }
                
                Spacer()
                
                // Button row.
                Button(action: {
                    self.alertIsVisible = true
                    self.score = self.score + self.getPointsForCurrentRound()
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
                }
                .alert(isPresented: $alertIsVisible, content: {
                    () ->
                    Alert in
                    let scoreStatement: String = "The slider's value is \(getSliderValueRounded()). You scored \(getPointsForCurrentRound()) points this round."
                    return Alert(title: Text("Hi there"), message: Text(scoreStatement), dismissButton: .default(Text("Awesome")) {
                        self.round = self.round + 1
                        self.target = Int.random(in: 1...100)
                    })
                })
                
                
                Spacer()
                
                // Score row.
                HStack {
                    Button(action: {}) {
                        Text("Start over")
                    }
                    Spacer()
                    Text("Score:")
                    Text("\(self.score)")
                    Spacer()
                    Text("Round:")
                    Text("\(round)")
                    Spacer()
                    Button(action: {}) {
                        Text("Info")
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
    
    func getSliderValueRounded() -> Int {
        Int(self.sliderValue.rounded())
    }
    
    func getPointsForCurrentRound() -> Int {
        100 - abs(target - getSliderValueRounded())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 893, height: 414))
    }
}
