//
//  AnimatedBackground.swift
//  MealDB
//
//  Created by Zaid Naing on 11/21/23.
//

import SwiftUI

// See here using 3 slashes instead, this makes it so that you can hold Option and click on the struct and see in the Quick help the description you wrote

/// A dynamic animated background that is used in all views
struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: 0)
    @State var end = UnitPoint(x: 1, y: 1)
    let timer = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect()
    
    var colors = [Color.green,Color.yellow,Color.red, Color.purple, Color.blue]
    // this could be like this instead, so you don't have to put Color in front of everything
//    var colors: [Color] = [.green, .yellow, .red, .purple, .blue]
    var body: some View {
        background
            .blur(radius: 3)
            
    }
    var background:some View{
        LinearGradient(colors: colors, startPoint: start, endPoint: end)
            .ignoresSafeArea(.all)
            .animation(.easeInOut(duration: 10).repeatForever(autoreverses: true).speed(0.5),value: start)
            .onReceive(timer, perform: { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 4)
                self.end = UnitPoint(x: 4, y: 4)
            })
    }
}

#Preview {
    AnimatedBackground()
}
