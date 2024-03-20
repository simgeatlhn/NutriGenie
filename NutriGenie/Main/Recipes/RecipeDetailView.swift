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
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("images")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 400)
                .clipped()
                .edgesIgnoringSafeArea(.top)
            
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 40)
                    .fill(.white)
                    .shadow(radius: 24)
                    .frame(width: geometry.size.width - 200)
                    .cornerRadius(30)
                    .offset(x:100, y: 240)
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
                        .padding(.top, 100)
                    
                    HStack(spacing: 72) {
                        VStack {
                            Image(systemName: "timer")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                                .padding()
                                .background(.gray.opacity(0.1))
                                .cornerRadius(6)
                            Text("65 min")
                                .foregroundColor(.black)
                        }
                        VStack {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                                .padding()
                                .background(.gray.opacity(0.1))
                                .cornerRadius(6)
                            Text("serves 4")
                                .foregroundColor(.black)
                        }
                        
                        VStack {
                            Image(systemName: "figure.cooldown")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                                .padding()
                                .background(.gray.opacity(0.1))
                                .cornerRadius(6)
                            Text("540 kcal")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("Recipe Details: Egg,garlic,clove, medium")
                        .foregroundColor(.black)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        //
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .padding(.trailing, 4)
                            Text("Watch the video")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black)
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
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                        .padding()
                        .background(.white.opacity(0.6))
                        .clipShape(Circle())
                        .padding(.top, 32)
                },
            trailing:
                HStack {
                    Button(action: {
                        //
                    }) {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding()
                            .background(.white.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding(.top, 32)
                }
        )
    }
}



#Preview {
    RecipeDetailView()
}
