//
//  View+Extension.swift
//  Hud
//
//  Created by HOA on 2022/10/8.
//

import SwiftUI

public extension View {
    func hud<Content: View>(
    isPresented: Binding<Bool>,
    moveEdge: Edge = .top,
    alignment: Alignment = .top,
    type: SwiftUIHudType,
    @ViewBuilder content: () -> Content
  ) -> some View {
    ZStack(alignment: alignment) {
      self

      if isPresented.wrappedValue {
          SwiftUIHud<Content>(content: content(), type: .constant(type))
          .transition(AnyTransition.move(edge: moveEdge).combined(with: .opacity))
          .onAppear {
              
              var dur: TimeInterval = 3
              switch type {
              case .label(_, _, let duration):
                  dur = duration
              case .progress(_, let duration):
                  dur = duration
              }
              
            DispatchQueue.main.asyncAfter(deadline: .now() + dur) {
              withAnimation {
                isPresented.wrappedValue = false
              }
            }
          }
          .zIndex(1)
      }
    }
  }
}
