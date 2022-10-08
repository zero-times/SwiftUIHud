//
//  SwiftUIHudState.swift
//  Hud
//
//  Created by HOA on 2022/10/8.
//

import SwiftUI

public enum SwiftUIHudType: Equatable {
    case label(title: String, systemImage: String? = nil, duration: TimeInterval = 3)
    case progress(title: String? = nil, duration: TimeInterval = 3)
}

public class SwiftUIHudState: ObservableObject {
    
    @Published public var isPresented: Bool = false
    private(set) public var title: String? = ""
    private(set) public var systemImage: String? = ""
    private(set) public var type: SwiftUIHudType = .progress()
    
    public init() {}
    
    public var alignment: Alignment {
        switch type {
        case .progress: return .center
        default: return .top
        }
    }
    
    public func show(_ type: SwiftUIHudType) {
        self.type = type
        
        switch type {
        case .label(let title, let systemImage, _):
            self.title = title
            self.systemImage = systemImage
        case .progress(let title, _):
            self.title = title
        }
        
        withAnimation {
            isPresented = true
        }
    }
    
    public func dismiss() {
        withAnimation {
            isPresented = false
        }
    }
}
