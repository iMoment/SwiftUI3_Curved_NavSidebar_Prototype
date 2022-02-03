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
            // MARK: Blur View
            BlurView(style: .systemUltraThinMaterialDark)
            Color("bg02")
                .opacity(0.5)
                .blur(radius: 15)
            
            // Content
            VStack(alignment: .leading, spacing: 25) {
                Button {
                    
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .foregroundColor(Color.white.opacity(0.8))
                
                // MARK: Menu Buttons
                
            }
            .padding(.trailing, 120)
            .padding()
            .padding(.top, getSafeArea().top)
            .padding(.bottom, getSafeArea().bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .clipShape(MenuShape())
        .background(
            MenuShape()
                .stroke(
                    .linearGradient(.init(colors: [
                        
                        Color("skyblue01"),
                        Color("skyblue01")
                            .opacity(0.7),
                        Color("skyblue01")
                            .opacity(0.5),
                        Color.clear
                        
                    ]), startPoint: .top, endPoint: .bottom),
                    lineWidth: 7
                )
                .padding(.leading, -50)
        )
        .ignoresSafeArea()
    }
}

struct MenuShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width - 100
            let height = rect.height
            
            path.move(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            
            // Curve
            path.move(to: CGPoint(x: width, y: 0))
            
            path.addCurve(
                to: CGPoint(x: width, y: height + 100),
                control1: CGPoint(x: width + 150, y: height / 3),
                control2: CGPoint(x: width - 150, y: height / 2))
        }
    }
}

// View Extension for Safe Area
extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
    
    func getScreenSize() -> CGRect {
        return UIScreen.main.bounds
    }
}
