//
//  CardView.swift
//  NutriGenie
//
//  Created by simge on 16.03.2024.
//

import SwiftUI

struct CardView: View {
    @State private var showsIndicator: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(items) { item in
                                CardView(item)
                                    .padding(.horizontal, 75)
                                    .frame(width: size.width)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                            .offset(x: minX(geometryProxy))
                                            .offset(x: excessMinX(geometryProxy, offset: 1))
                                    }
                                    .zIndex(items.zIndex(item))
                                    .overlay(
                                        VStack (alignment: .trailing) {
                                            Button(action: {
                                                print("bookmark")
                                            }) {
                                                Image(systemName: "bookmark")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .background(.white.opacity(0.6))
                                                    .clipShape(Circle())
                                            }
                                            .padding(.top, 16)
                                            Spacer()
                                            Text("Bread & Egg Morning Casserole")
                                                .foregroundColor(.white)
                                                .bold()
                                                .padding(.vertical)
                                        }
                                    )
                            }
                        }
                    }
                    .scrollIndicators(showsIndicator ? .visible: .hidden)
                }
                .frame(width: 480, height: 450)
                
            }
        }
    }
    
    //Card View
    @ViewBuilder
    func CardView(_ item: Item) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(item.color.gradient)
    }
    
    //Stacked Cards Animation
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .global).minX
        return minX < 0 ? 0 : -minX
    }
    
    func progress(_ proxy: GeometryProxy, limit: CGFloat = 3) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        //Converting into progress
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        return  cappedProgress
    }
    
    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        return progress * offset
    }
}

#Preview {
    CardView()
}
