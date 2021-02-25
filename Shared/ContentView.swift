//
//  ContentView.swift
//  Shared
//
//  Created by Hamza Ikine on 2/22/21.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var progressValue:Float = 0.0
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                HStack {
                    Text("Hydration")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .bold()
                        .padding([.top, .leading])
                    Spacer()
                }
                
                ProgressCircle(progress: self.$progressValue)
                    .frame(width: 350, height: 350)
                Spacer()
                QuickAddView(progress: self.$progressValue)
            }
            
        }
        
        
    }
    
    func incrementProgress() {
        self.progressValue += 8
        
    }
    
    func decrementProgress()  {
        self.progressValue -= 8
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Wave: Shape {
    
    var offset: Angle
    var percent: Double
    
    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        // empirically determined values for wave to be seen
        // at 0 and 100 percent
        let lowfudge = 0.02
        let highfudge = 0.98
        
        let newpercent = lowfudge + (highfudge - lowfudge) * percent
        let waveHeight = 0.015 * rect.height
        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight)    + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        
        p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}

struct CircleWaveView: View {
    
    @State private var waveOffset = Angle(degrees: 0)
    @Binding var percent: Float
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                
                Circle()
                    .stroke(Color.blue, lineWidth: 0.025 * min(geo.size.width, geo.size.height))
                    .overlay(
                        Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent))
                            .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                            .clipShape(Circle().scale(0.92))
                    )
            }
            
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}


struct ProgressCircle: View {
    
    @Binding var progress: Float
    @State var isChecked: Bool = false
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        HStack {
            
            Button(action: {
                if progress > 0{
                    progress -= 0.08
                }
                
            }, label: {
                Image(systemName: "minus")
                    .foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
            .padding(.trailing, 40.0)
            
            
            ZStack {
                
                CircleWaveView(percent: self.$progress)
   
                Path{ path in
                    path.move(to: CGPoint(x: 140, y: 100))
                    path.addLine(to: CGPoint(x: 140, y: 250))
                }
                .stroke(Color.white,style: StrokeStyle( lineWidth: 10, dash: [5],dashPhase:2))
                
                
                
                VStack {
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack {
                        
                        
                        Text(String(format: "%.0f", self.progress * 100 ))
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: .white, radius: 20)
                        Text("oz")
                            .foregroundColor(.white)
              
                        
                    }
                    
     
                    VStack {
                        
                        
                        
                        if self.progress >= 1.0 {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .font(.title)
                                .scaledToFit()
                                .fixedSize()
                        }else{
                            Image(systemName: "checkmark")
                                .font(.title)
                                .scaledToFit()
                                .fixedSize()
                            
                            
                        }
                        
                        Text("100 oz")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        
                        
                    }
                                
                    
                    Text(String(format: "%.0f%% of Goal ", self.progress * 100))
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding(.top)
                    
                    Spacer()
                    
                }
                
    
                
            }
            
       
            Button(action: {
                progress += 0.08
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
            .padding(.leading, 40.0)
            
            
        }
    }
}

struct QuickAddView: View {
    @Binding var progress: Float
    
    var body: some View {
        Text("Quick Add")
            .font(.headline)
            .foregroundColor(.white)
            .bold()
        
        HStack {
            Button(action: {
                progress += 0.08
            }, label: {
                
                Text("+ 8 oz")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                
                
                
                
                
            })
            .frame(width: 100, height: 40)
            .overlay(RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 3.0).foregroundColor(.gray).opacity(1))
            .background(Color.gray)
            
            
            
            
            Button(action: {
                progress += 0.16
            }, label: {
                
                Text("+ 16 oz")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                
                
                
                
            })
            
            .frame(width: 100, height: 40)
            .overlay(RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 3.0).foregroundColor(.gray).opacity(1))
            .background(Color.gray)
            
            
            Button(action: {
                progress += 0.24
            }, label: {
                Text("+ 24 oz")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    
                    
                    
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 3.0).foregroundColor(.gray))
                    .background(Color.gray)
                    .opacity(1.0)
                
            })
            .frame(width: 100, height: 40)
            .overlay(RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 3.0).foregroundColor(.gray).opacity(1))
            .background(Color.gray)
            
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
