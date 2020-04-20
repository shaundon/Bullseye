//
//  ContentView.swift
//  Bullseye
//
//  Created by Shaun Donnelly on 17/04/2020.
//  Copyright © 2020 Shaun Donnelly. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var scoreAlertIsVisible = false
    @State var resetAlertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct FontStyle: ViewModifier {
        
        enum FontSize {
            case small
            case regular
            case large
            
            func getFontSize() -> CGFloat {
                switch self {
                case .small:
                    return 12
                case .regular:
                    return 18
                case .large:
                    return 24
                }
            }
        }
        
        let fontSize: FontSize
        
        func body(content: Content) -> some View {
            content
                .font(.custom("Arial Rounded MT bold", size: fontSize.getFontSize()))
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
        
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(FontStyle(fontSize: .regular))
                .modifier(ShadowStyle())
                .foregroundColor(.white)
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(FontStyle(fontSize: .large))
                .modifier(ShadowStyle())
                .foregroundColor(.yellow)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(FontStyle(fontSize: .regular))
                .foregroundColor(.black)
                .background(Image("Button"))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(FontStyle(fontSize: .small))
                .foregroundColor(.black)
                .background(Image("Button"))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            // Target row.
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            
            Spacer()
            
            // Slider row.
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100").modifier(LabelStyle())
            }
            
            Spacer()
            
            // Button row.
            Button(action: {
                self.scoreAlertIsVisible = true
                self.score = self.score + self.getPointsForCurrentRound()
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $scoreAlertIsVisible, content: {
                () ->
                Alert in
                let scoreStatement: String = "The slider's value is \(getSliderValueRounded()). You scored \(getPointsForCurrentRound()) points this round."
                return Alert(
                    title: Text(getAlertTitle()),
                    message: Text(scoreStatement),
                    dismissButton: .default(Text("Awesome")) {
                        self.round = self.round + 1
                        self.target = Int.random(in: 1...100)
                    }
                )
            })
            .modifier(ButtonLargeTextStyle())
            
            
            Spacer()
            
            // Score row.
            HStack {
                Button(action: {
                    self.resetAlertIsVisible = true
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over")
                    }
                }
                .alert(isPresented: $resetAlertIsVisible, content: {
                    () ->
                    Alert in
                    return Alert(
                        title: Text("Start over?"),
                        message: Text("Your score will be reset to zero."),
                        primaryButton: .destructive(Text("Start Over")) {
                            self.startNewGame()
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                })
                .modifier(ButtonSmallTextStyle())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(self.score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                    }
                }
                .modifier(ButtonSmallTextStyle())

            }
            .padding(.bottom, 20)
        }
        .accentColor(midnightBlue)
        .background(Image("Background"), alignment: .center)
    .navigationBarTitle("Bullseye")
    }
    
    
    func getSliderValueRounded() -> Int {
        Int(self.sliderValue.rounded())
    }
    
    func getAmountOff() -> Int {
        return abs(target - getSliderValueRounded())
    }
    
    func getPointsForCurrentRound() -> Int {
        let amountOff = getAmountOff()
        var points = 100 - amountOff
        if (amountOff == 0) {
            points = points + 100
        } else if (amountOff == 1) {
            points = points + 50
        }
        return points
    }

    
    func getAlertTitle() -> String {
        let amountOff = getAmountOff()
        let title: String
        if (amountOff == 0) {
            title = "Perfect!"
        } else if (amountOff < 5) {
            title = "You almost had it!"
        } else if (amountOff <= 10) {
            title = "Not bad."
        } else {
            title = "Not even close!"
        }
        return title
    }
    
    func startNewGame() {
        round = 1
        score = 0
        target = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 893, height: 414))
    }
}
