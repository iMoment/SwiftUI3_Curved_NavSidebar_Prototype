//
//  HomeView.swift
//  CurvedNavBar
//
//  Created by Stanley Pan on 2022/02/03.
//

import SwiftUI

struct HomeView: View {
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
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 25) {
                        
                    }
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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
