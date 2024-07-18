//
//  ContentView.swift
//  BreathingAnimation
//
//  Created by Shreyas Vilaschandra Bhike on 18/07/24.
//

//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            FinalFlower()
        }
    }
}

#Preview {
    ContentView()
}












struct FinalFlower: View {
    @State private var rightPetal = false
    @State private var mostRightPetal = false
    @State private var leftPetal = false
    @State private var mostLeftPetal = false
    
    @State private var breatheStatus = false
    
    
    
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 300)
                .foregroundColor(.green)
                .offset(x:150,y:380)
                .opacity(0.2)
            
            Circle()
                .frame(width: 300)
                .foregroundColor(.green)
                .offset(x:-150,y:380)
                .opacity(0.2)
            
            
            
            Rectangle()
                .frame(width: 8,height: 400)
                .foregroundStyle(.green)
                .opacity(0.7)
                .offset(y:300)
            
            
            Group{
                PetalManipulation(opacity: 0.6)
                    .rotationEffect(.degrees(leftPetal ? -25 : 0), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: leftPetal)
                    .onAppear {
                        leftPetal.toggle()
                    }
                
                
                PetalManipulation(opacity: 0.5)
                    .rotationEffect(.degrees(mostLeftPetal ? -50 : 0), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: mostLeftPetal)
                    .onAppear {
                        mostLeftPetal.toggle()
                    }
                
                
                
                
                
                
                PetalManipulation(opacity: 0.6)
                    .frame(width: 90, height: 180, alignment: .center)
                    .rotationEffect(.degrees(rightPetal ? 25 : 0), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: rightPetal)
                    .onAppear {
                        rightPetal.toggle()
                    }
                
                
                
                
                PetalManipulation(opacity: 0.5)
                    .frame(width: 90, height: 180, alignment: .center)
                    .rotationEffect(.degrees(mostRightPetal ? 50 : 0), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: mostRightPetal)
                    .onAppear {
                        mostRightPetal.toggle()
                    }
                
                
                
                
                
                PetalManipulation(opacity: 1)
            }.offset(y:100)
            
            Text("T H E    A P P   W I Z A R D")
                .foregroundStyle(.white)
                .font(.title2)
                .offset(y:-200)
        }
                           
    }
}



struct PetalManipulation:View {
    var opacity: Double
    var body: some View {
        PetalShape()
            .fill(LinearGradient(
                            gradient: Gradient(colors: [Color(red: 219/255, green: 8/255, blue: 107/255), Color(red: 226/255, green: 79/255, blue: 234/255)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                        .shadow(radius: 5)
                        .frame(width: 400, height: 200)
                        .rotationEffect(.degrees(180))
                        .opacity(opacity)
    }
}





struct PetalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
       
        let startPoint = CGPoint(x: rect.width / 2, y: rect.height)
        
    
        path.move(to: startPoint)
        
    
        let control1 = CGPoint(x: rect.width * 0.25, y: rect.height * 0.25)
        let control2 = CGPoint(x: rect.width * 0.75, y: rect.height * 0.25)
        let endPoint = CGPoint(x: rect.width / 2, y: 0)
        

        path.addQuadCurve(to: endPoint, control: control1)
        
    
        path.addQuadCurve(to: startPoint, control: control2)
        
        return path
    }
}


struct LotusLeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

       
        let petalCount = 15
        let controlPointFactor: CGFloat = 0.6

        for i in 0..<petalCount {
            let angle = (CGFloat(i) * (360.0 / CGFloat(petalCount))) * .pi / 180
            let nextAngle = (CGFloat(i + 1) * (360.0 / CGFloat(petalCount))) * .pi / 180

            let point1 = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let point2 = CGPoint(x: center.x + radius * cos(nextAngle), y: center.y + radius * sin(nextAngle))

            let controlPoint1 = CGPoint(x: center.x + radius * controlPointFactor * cos(angle + .pi / CGFloat(petalCount)),
                                        y: center.y + radius * controlPointFactor * sin(angle + .pi / CGFloat(petalCount)))
            let controlPoint2 = CGPoint(x: center.x + radius * controlPointFactor * cos(nextAngle - .pi / CGFloat(petalCount)),
                                        y: center.y + radius * controlPointFactor * sin(nextAngle - .pi / CGFloat(petalCount)))

            if i == 0 {
                path.move(to: point1)
            }

            path.addCurve(to: point2, control1: controlPoint1, control2: controlPoint2)
        }

        path.closeSubpath()

        return path
    }
}
