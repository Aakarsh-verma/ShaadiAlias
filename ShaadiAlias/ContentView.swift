//
//  ContentView.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 17/12/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: ContentViewModel
    @State var showNavigation: Bool = false
    @State var selected: ContentModel = ContentModel(fullName: "", image: "")
    @Namespace private var namespace
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HeaderView()
                ScrollView(showsIndicators: false) {
                    ForEach($viewModel.content, id: \.identifier) { content in
                        MatchCard(model: content)
                            .padding(.vertical)
                            .transition(.scale(scale: 0.5, anchor: .center))
                            .onTapGesture {
                                withAnimation(.hero) {
                                    showNavigation.toggle()
                                    selected = content.wrappedValue
                                }
                            }
                            .matchedGeometryEffect(id: content.wrappedValue.identifier, in: namespace)
                    }
                }
            }
            .background(.gray.opacity(0.05))
            .onReceive(NotificationCenter.default.publisher(for: .networkDidChange), perform: { object in
                if let status = object.object as? String, status == "online" {
                    self.getData()
                }
            })
            .onAppear {
                viewModel.getSavedContent()
            }
            
            if showNavigation {
                DetailView(model: $selected, namespace: namespace, show: $showNavigation)
                    .matchedGeometryEffect(id: $selected.wrappedValue.identifier, in: namespace)
                    .transition(.scale(scale: 0.5, anchor: .center))
                    .opacity(showNavigation ? 1 : 0)
            }
        }
    }
    
    private func getData() {
        Task {
            await viewModel.fetchAndSetContent()
        }
    }
}
