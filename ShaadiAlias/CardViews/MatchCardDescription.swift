//
//  MatchCardDescription.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 17/12/24.
//

import SwiftUI

struct MatchCardDescription: View {
    @Binding var model: ContentModel
    
    var body: some View {
        ZStack {
            CardAysncImageView(viewModel: AsyncImageViewModel(imageAssest: model.image ?? ""))
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 5)
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(model.fullName ?? "")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                    
                    Text(model.address ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    if let isAccepted = model.isAccepted {
                        VStack(spacing: 8) {
                            Rectangle()
                                .frame(height: 12)
                                .opacity(0)
                            
                            Divider()
                                .background(.white)
                                .padding(.horizontal)
                            
                            Text(isAccepted ? "Accepted" : "Declined")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(isAccepted ? .green : .red)
                                .padding()
                                .background(.clear)
                                .transition(.opacity.combined(with: .scale))
                                .padding(.bottom)
                        }
                    } else {
                        MatchCardBottomView(model: $model)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                )
            }
        }
        .animation(.easeInOut, value: model.isAccepted)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
