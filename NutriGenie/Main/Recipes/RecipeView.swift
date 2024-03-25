//
//  RecipeView.swift
//  NutriGenie
//
//  Created by simge on 12.03.2024.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Bread & Egg Morning Casserole")
                    .font(.title3)
                    .foregroundColor(.black)
                Text("Egg,garlic,clove,medium onion...")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.top, 5)
            }
            Spacer()
            Image("images")
                .resizable()
                .frame(width: 120, height: 100)
                .cornerRadius(15)
        }
        .padding()
        .background(.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding([.leading, .trailing], 14)
        .padding(.bottom, 10)
    }
}

#Preview {
    RecipeView()
}
