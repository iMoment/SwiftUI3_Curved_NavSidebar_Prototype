//
//  HomeView.swift
//  CurvedNavBar
//
//  Created by Stanley Pan on 2022/02/03.
//

import SwiftUI

struct HomeView: View {
    @State var showMenu: Bool = false
    @State var animatePath: Bool = false
    @State var animateBackground: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                // Nav Bar
                HStack {
                    Button {
                        withAnimation {
                            animateBackground.toggle()
                        }
                        
                        withAnimation(.spring()) {
                            showMenu.toggle()
                        }
                        // Animating path with delay
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3).delay(0.2)) {
                            animatePath.toggle()
                        }
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
            
            Color.black
                .opacity(animateBackground ? 0.25 : 0)
                .ignoresSafeArea()
            
            MenuView(showMenu: $showMenu, animatePath: $animatePath, animateBackground: $animateBackground)
                .offset(x: showMenu ? 0 : -getScreenSize().width)
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
    @Binding var animatePath: Bool
    @Binding var animateBackground: Bool
    
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
                    // Close Menu
                    
                    // Animating path with delay
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)) {
                        animatePath.toggle()
                    }
                    
                    withAnimation {
                        animateBackground.toggle()
                    }
                    
                    withAnimation(.spring().delay(0.1)) {
                        showMenu.toggle()
                    }
                    
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .foregroundColor(Color.white.opacity(0.8))
                
                // MARK: Menu Buttons
                MenuButtons(title: "Premium Access", image: "square.grid.2x2", offset: 0)
                    .padding(.top, 40)
                
                MenuButtons(title: "Upload Content", image: "square.and.arrow.up.on.square", offset: 10)
                
                MenuButtons(title: "My Account", image: "profile", offset: 30)
                
                MenuButtons(title: "Make Reservation", image: "dollarsign.circle", offset: 10)
                
                MenuButtons(title: "Help", image: "questionmark.circle", offset: 0)
                
                Spacer(minLength: 10)
                
                MenuButtons(title: "Logout", image: "rectangle.portrait.and.arrow.right", offset: 0)
            }
            .padding(.trailing, 120)
            .padding()
            .padding(.top, getSafeArea().top)
            .padding(.bottom, getSafeArea().bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .clipShape(MenuShape(value: animatePath ? 150 : 0))
        .background(
            MenuShape(value: animatePath ? 150 : 0)
                .stroke(
                    .linearGradient(.init(colors: [
                        
                        Color("skyblue01"),
                        Color("skyblue01")
                            .opacity(0.7),
                        Color("skyblue01")
                            .opacity(0.5),
                        Color.clear
                        
                    ]), startPoint: .top, endPoint: .bottom),
                    lineWidth: animatePath ? 7 : 0
                )
                .padding(.leading, -50)
        )
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func MenuButtons(title: String, image: String, offset: CGFloat) -> some View {
        Button {
            
        } label: {
            HStack(spacing: 12) {
                if image == "profile" {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                }
                
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(title == "logout" ? .semibold : .medium)
                    .kerning(title == "logout" ? 1.2 : 0.8)
                    .foregroundColor(Color.white.opacity(title == "logout" ? 0.9 : 0.65))
            }
            .padding(.vertical)
        }
        .offset(x: offset)
    }
}

struct MenuShape: Shape {
    
    var value: CGFloat
    // Animate Path
    var animatableData: CGFloat {
        get { return value }
        set { value = newValue }
    }
    
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
                control1: CGPoint(x: width + value, y: height / 3),
                control2: CGPoint(x: width - value, y: height / 2))
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
