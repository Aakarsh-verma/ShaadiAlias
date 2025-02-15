//
//  HeaderView.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 18/12/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HeaderTopSection()
                .padding(.horizontal, 16)
                .background(.shaadiRed)
                .foregroundStyle(.white)
        }
    }
}

struct HeaderTopSection: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Text("Profile Matches")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                }
                .padding(.vertical)
            }
            Spacer()
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .clipped()
        }
    }
}

#Preview {
    HeaderView()
}
