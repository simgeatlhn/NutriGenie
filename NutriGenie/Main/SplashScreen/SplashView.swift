//
//  SplashView.swift
//  NutriGenie
//
//  Created by simge on 21.05.2024.
//

import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Scan Cook")
                    .font(.custom("Arial", size: 40))
                    .bold()
                    .foregroundColor(.white)
                
                Text("Discover")
                    .font(.custom("Arial", size: 40))
                    .bold()
                    .foregroundColor(.white)
                
                Image("nutrigenie-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 420, height: 420)
                
                Button(action: {
                    withAnimation {
                        showSplash = false
                    }
                }) {
                    Text("✨  AI Magic")
                        .font(.custom("Arial", size: 23))
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(26)
                        .padding(.top, 20)
                }
            }
            .padding(.leading, 32)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    SplashView(showSplash: .constant(true))
}
