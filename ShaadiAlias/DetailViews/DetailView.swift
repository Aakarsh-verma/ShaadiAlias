//
//  DetailView.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 18/12/24.
//

import SwiftUI


struct DetailView: View {
    @Binding var model: ContentModel
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(alignment: .leading) {
                CardAysncImageView(viewModel: AsyncImageViewModel(imageAssest: model.image ?? ""))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .scaledToFill()
                    .matchedGeometryEffect(id: model.image ?? "", in: namespace)
                    .background(.shaadiRed)
                
                Text(model.fullName ?? "")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.leading)
                
                Text(model.address ?? "")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                Spacer()
                if let isAccepted = model.isAccepted {
                    VStack(spacing: 8) {
                        Divider()
                            .background(.white)
                            .padding(.horizontal)
                        
                        Text(isAccepted ? "Accepted" : "Declined")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .transition(.opacity.combined(with: .scale))
                            .padding(.bottom)
                    }
                    .background(isAccepted ? .green : .red)
                }
            }
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .opacity(0.5)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                        .padding()
                        .onTapGesture {
                            withAnimation(.hero) {
                                show.toggle()
                            }
                        }
                }

                Spacer()
                
            }
            .padding(.top, 10)
            .padding(.horizontal, 16)
        }
        .background(ignoresSafeAreaEdges: .all)
    }
}

extension Animation {
    static var hero: Animation {
        .interactiveSpring(response: 0.6, dampingFraction: 0.85, blendDuration: 0.6)
    }
}
