//
//  AnimatedBackground.swift
//  MealDB
//
//  Created by Zaid Naing on 11/21/23.
//

import SwiftUI


//A dynamic animated background that is used in all views
struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: 0)
    @State var end = UnitPoint(x: 1, y: 1)
    let timer = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect()
    
    var colors = [Color.green,Color.yellow,Color.red, Color.purple, Color.blue]
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
