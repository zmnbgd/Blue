//
//  ContentView.swift
//  Blue
//
//  Created by Marko Zivanovic on 30.1.24..
//

import SwiftUI

struct ContentView: View {
    
    @State var settingsView: Bool = false
    
    let universalSize = UIScreen.main.bounds
    
    @State var isAnimated = false
    
    @State var progressValue: Float = 0.0
    
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
            
//            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            ZStack {
                ZStack {
                    //MARK: - Progress Bar
                    ProgressBar(progress: self.$progressValue)
                        .frame(width: 300.0, height: 300.0)
                        .padding(30.0).onAppear() {
                            self.progressValue = 0.00
                        }
                    //MARK: - A button that shows a percentage and opens a new screen with statistics
//                    Button("Intake") {
//                        if (progressValue) < 1.0 {
//                            self.progressValue += 0.10
//                        } else {
//                            progressValue -= 1.0
//                        }
//                    }
                    //MARK: Progress Bar Height 
                        .offset(y: -100)
                }
                getWave()
                    .blur(radius: 8.0)
                    .foregroundColor(Color("wave3").opacity(0.7))
                    .offset(x: isAnimated ? -1 * universalSize.width : 0)
                    .animation(Animation.linear(duration: 15.3).repeatForever(autoreverses: false))

                getWave()
                    .blur(radius: 8.0)
                    .foregroundColor(Color("wave2").opacity(0.8))
                    .offset(x: isAnimated ? -1 * universalSize.width : 0)
                    .animation(Animation.linear(duration: 8.9).repeatForever(autoreverses: false))
                
                getWave()
                    .blur(radius: 8.0)
                    .foregroundColor(Color("wave1").opacity(0.9))
                    .offset(x: isAnimated ? -1 * universalSize.width : 0)
                    .animation(Animation.linear(duration: 5.4).repeatForever(autoreverses: false))
                VStack {
                    //MARK: - Button
                    Spacer()
                        .frame(height: 650, alignment: .center)
                    
                        Button("Edit") {
                            //settingsView.toggle()
                            if (progressValue) < 1.0 {
                                self.progressValue += 0.10
                            } else {
                                progressValue -= 1.0
                            }
                        }
                        .padding(50)
                    
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("ButtonGradient1"), Color("ButtonGradient2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color: Color("ButtonShadow"), radius: 10, x: 10, y: 10)
                        .sheet(isPresented: $settingsView, content: {
                            //SettingsScreen()
                        })
                }
            }
            .onAppear() {
                self.isAnimated = true
                    
        }
    }
        .ignoresSafeArea()
}
    
    func getWave (baseline: CGFloat = UIScreen.main.bounds.height / 1.40) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: baseline))
            path.addCurve(
                to: CGPoint(x: 1 * universalSize.width, y: baseline),
                          control1: CGPoint(x: universalSize.width * (0.23), y: 45 + baseline),
                          control2: CGPoint(x: universalSize.width * (0.63), y: -45 + baseline)
            )
            path.addCurve(
                to: CGPoint(x: 2 * universalSize.width, y: baseline),
                control1: CGPoint(x: universalSize.width * (1.23), y: 45 + baseline),
                control2: CGPoint(x: universalSize.width * (1.63), y: -45 + baseline)
            )
            
            path.addLine(to: CGPoint(x: 2 * universalSize.width, y: universalSize.height))
            path.addLine(to: CGPoint(x: 0, y: universalSize.height))
            
        }
    }
}

//MARK: - PRogress Bar
struct ProgressBar: View {
    
    @Binding var progress: Float
    
    var color: Color = Color("wave1")
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 27.5)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 27.5, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.1), value: progress)
        }
    }
}

#Preview {
    ContentView()
}

