//
//  ContentView.swift
//  Shared
//
//  Created by Hamza Ikine on 2/22/21.
//

import SwiftUI

struct ContentView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @State var progressValue:Float = 0.0
    
    var body: some View {
        NavigationView{
            
            ZStack {
                
                Color.black
                    .opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    ProgressCircle(progress: self.$progressValue)
                        .frame(width: 350, height: 350)
                    
                    
                    
                    Spacer()
                    
                    
                    
                    QuickAddView(progress: self.$progressValue)
                    
                    
                    
                    
                }
                
                
                
            }
            
            .navigationTitle("Hydration")
            
            
            
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

struct ProgressCircle: View {
    
    @Binding var progress: Float
    
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
                
                
               
                
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.1)
                    .foregroundColor(.blue)
                
            
                
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress,1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                
               
                Path{ path in
                    path.move(to: CGPoint(x: 140, y: 100))
                    path.addLine(to: CGPoint(x: 140, y: 250))
                }
                .stroke(Color.white,style: StrokeStyle( lineWidth: 10, dash: [5],dashPhase:2))
                
                
                
                VStack {
                    
                    
                    
                    Spacer()
                    
                    Text(String(format: "%.0f", self.progress * 100 ))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top)
                        .shadow(color: .white, radius: 20)
                    
                    Text("oz")
                        .foregroundColor(.white)
                        .padding(.bottom)
                        
                    
                    
                    Text("100 oz")
                        .font(.headline)
                        .foregroundColor(.white)
                        
                        
                    
                    Spacer()
                    
                    Text(String(format: "%.0f%% of Goal ", self.progress * 100))
                        .font(.headline)
                        .foregroundColor(.orange)
                        
                    
                    
                    
                    
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
