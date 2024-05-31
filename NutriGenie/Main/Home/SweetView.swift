//
//  SweetView.swift
//  NutriGenie
//
//  Created by simge on 8.03.2024.
//

import SwiftUI

struct SweetView: View {
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        CardView(viewModel: viewModel)
    }
}

#Preview {
    SweetView()
}

