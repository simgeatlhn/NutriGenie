//
//  RecipeDetailView.swift
//  NutriGenie
//
//  Created by simge on 17.03.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isRecipeViewPresented = false
    
    func adaptiveSize(size: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseWidth: CGFloat = 375 // Base width for iPhone 11
        let scaleFactor = screenWidth / baseWidth
        return size * scaleFactor
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("images")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: adaptiveSize(size: 400))
                .clipped()
                .edgesIgnoringSafeArea(.top)
            
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.white)
                    .shadow(radius: 24)
                    .frame(width: geometry.size.width - adaptiveSize(size: 200))
                    .cornerRadius(30)
                    .offset(x: adaptiveSize(size: 100), y: adaptiveSize(size: 240))
            }
            .overlay (
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Bread & Egg Morning Casserole")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .padding(.top, adaptiveSize(size: 100))
                    
                    HStack(spacing: adaptiveSize(size: 72)) {
                        VStack {
                            Image(systemName: "timer")
                                .resizable()
                                .frame(width: adaptiveSize(size: 24), height: adaptiveSize(size: 24))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                            Text("65 min")
                                .foregroundColor(.black)
                        }
                        VStack {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .frame(width: adaptiveSize(size: 24), height: adaptiveSize(size: 24))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                            Text("serves 4")
                                .foregroundColor(.black)
                        }
                        
                        VStack {
                            Image(systemName: "figure.cooldown")
                                .resizable()
                                .frame(width: adaptiveSize(size: 24), height: adaptiveSize(size: 24))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                            Text("540 kcal")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("Recipe Details: Egg, garlic, clove, medium ")
                        .foregroundColor(.black)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        //
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .padding(.trailing, adaptiveSize(size: 4))
                            Text("Watch the video")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: adaptiveSize(size: 300), height: adaptiveSize(size: 50))
                        .background(Color.black)
                        .cornerRadius(8)
                    }
                    .padding()
                }
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: adaptiveSize(size: 16), height: adaptiveSize(size: 16))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .clipShape(Circle())
                        .padding(.top, adaptiveSize(size: 32))
                },
            trailing:
                HStack {
                    Button(action: {
                        //
                    }) {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: adaptiveSize(size: 16), height: adaptiveSize(size: 16))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding(.top, adaptiveSize(size: 32))
                }
        )
    }
}




#Preview {
    RecipeDetailView()
}
