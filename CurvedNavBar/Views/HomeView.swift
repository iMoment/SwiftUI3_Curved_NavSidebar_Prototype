//
//  HomeView.swift
//  CurvedNavBar
//
//  Created by Stanley Pan on 2022/02/03.
//

import SwiftUI

struct HomeView: View {
    @State var showMenu: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                // Nav Bar
                HStack {
                    Button {
                        
                    } label:  {
                        Image("menu")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .shadow(radius: 1)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label:  {
                        Image("add02")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .shadow(radius: 1)
                    }
                }
                .overlay(
                    Text("Stories")
                        .font(.title2.bold())
                )
                .foregroundColor(Color.white.opacity(0.8))
                .padding([.horizontal, .top])
                .padding(.bottom, 5)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 25) {
                        // Sample Cards
                        ForEach(stories) { story in
                            // Card View
                            CardView(story: story)
                        }
                    }
                    .padding()
                    .padding(.top, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [
                    Color("bg01"),
                    Color("bg02"),
                ], startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            
            MenuView(showMenu: $showMenu)
        }
    }
    
    @ViewBuilder
    func CardView(story: Story) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            GeometryReader { proxy in
                
                let size = proxy.size
                
                Image(story.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(15)
            }
            .frame(height: 200)
            
            Text(story.title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.8))
            
            Button {
                
            } label: {
                Text("Read Now")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(
                        Capsule()
                            .fill(Color("red01"))
                    )
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// Menu View
struct MenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            // Blur View
            BlurView(style: .systemUltraThinMaterialDark)
            Color("bg02")
                .opacity(0.5)
                .blur(radius: 15)
        }
        .ignoresSafeArea()
    }
}
