//
//  Home.swift
//  Spotify Redesign
//
//  Created by Osaretin Uyigue on 4/27/21.
//

import SwiftUI

struct Home: View {
    
    //Storing Current Tab...
    @State var selectedTab = "house.fill"
    
    //Volume...
    @State var volume : CGFloat = 0.4
    @State var showSlideBar = true
    
    var body: some View {
        
        HStack(spacing: 0) {
            let lightWhite = Color.white.opacity(0.7)
            VStack {
                
                Image("spotify")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25) //45
                    .padding(.top)
                                
                VStack {
                    TabButton(image: "house.fill", selectedTab: $selectedTab)
                    
                    TabButton(image: "safari.fill", selectedTab: $selectedTab)
                    
                    TabButton(image: "mic.fill", selectedTab: $selectedTab)
                    
                    TabButton(image: "clock.fill", selectedTab: $selectedTab)

                }
                // setting the tabs for half of the height so that remaining element will get space....
                .frame(height: getRect().height / 2.3)
                .padding(.top)
                Spacer(minLength: 50)
                
                Button(action: {
                    // checking and increasing volume...
                    volume = volume + 0.1 < 1.0 ?  volume + 0.1 : 1
                }, label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                
                // Custom Volume Progress View...
                GeometryReader{ proxy in
                    
                    // extract progress bar height and based on that getting progress value...
                    let height = proxy.frame(in: .global).height
                    let progress = height * volume
                    ZStack(alignment: .bottom) {
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 4)
                        
                        Capsule()
                            .fill(Color.white)
                            .frame(width: 4, height: progress)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                }
                .padding(.vertical, 20)
                
                
                Button(action: {
                    // checking and decreasing volume...
                    volume = volume - 0.1 > 0 ?  volume - 0.1 : 0
                }, label: {
                    Image(systemName: "speaker.wave.1.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                
                Button(action: {
                    withAnimation(.easeIn) {
                        showSlideBar.toggle()
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                        // rotating...
                        .rotationEffect(.init(degrees: showSlideBar ? -180 : 0))
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                })
                
                .padding(.top, 30)
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 0)
                .offset(x: showSlideBar ? 0 : 100)
            }
            //Max Slide tab Bar Width
            .frame(width: 80)
            .background(Color.black.ignoresSafeArea())
            .offset(x: showSlideBar ? 0 : -100)
            // reclaiming the sapce by using negative spacing...
            .padding(.trailing, showSlideBar ? 0 : -100)
            // chabging the stack position
            //so that the side tabbar will be on top...
            .zIndex(1)
            
            //Main Content...
            ScrollView(showsIndicators: false, content: {
                
            })
        }
        .background(Color.black.opacity(0.5).ignoresSafeArea()) //"bg"

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


// Tab Button...

struct TabButton: View {
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            withAnimation{selectedTab = image}
        }, label: {
            Image(systemName: image)
                .font(.title)
                .foregroundColor(selectedTab == image ? .white : Color.gray.opacity(0.6))
                .frame(maxHeight: .infinity)
            
        })
    }
}


// Extending View to get Screen Size
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
    }
}
