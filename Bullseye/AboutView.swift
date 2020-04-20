//
//  AboutView.swift
//  Bullseye
//
//  Created by Shaun Donnelly on 20/04/2020.
//  Copyright © 2020 Shaun Donnelly. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let duskyPink: Color = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
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
    
    struct TitleStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(FontStyle(fontSize: .large))
                .foregroundColor(.black)
            .padding(20)
        }
    }
    
    struct ParagraphStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(FontStyle(fontSize: .regular))
                .foregroundColor(.black)
                .padding(EdgeInsets.init(top: 0, leading: 60, bottom: 20, trailing: 60))
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(TitleStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.").modifier(ParagraphStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(ParagraphStyle())
                Text("Enjoy!").modifier(ParagraphStyle())
            }
            .background(duskyPink)
            .navigationBarTitle("About Bullseye")
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 893, height: 414))
    }
}
