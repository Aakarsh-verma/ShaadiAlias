//
//  MatchCard.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 17/12/24.
//

import SwiftUI

struct MatchCard: View {
    @Binding var model: ContentModel
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack(spacing: 16) {
            MatchCardDescription(model: $model)
        }
        .frame(width: UIScreen.main.bounds.width - 48, height: UIScreen.main.bounds.height / 2.8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        )
        .padding()
    }
}

//#Preview {
////    MatchCard()
//}
