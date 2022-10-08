import SwiftUI

public struct SwiftUIHud<Content: View>: View {
    
    @ViewBuilder public let content: Content
    
    @Binding public var type: SwiftUIHudType
    
    public init(content: Content, type: Binding<SwiftUIHudType>) {
        self.content = content
        self._type = type
    }
    
    public var body: some View {
        switch type {
        case .progress(let title, _):
            if let _ = content as? EmptyView {
                VStack(spacing: 15) {
                    ProgressView()
                        .progressViewStyle(.circular)
                    if let title = title, title.count > 0 {
                        Text(title)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                    .padding(20)
                    .background(
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(Color.white)
                            .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
                    )
            }
            else {
                content
                    .padding(20)
                    .background(
                        Rectangle()
                            .cornerRadius(12)
                            .foregroundColor(Color.white)
                            .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
                    )
            }
        case .label(title: let title, let systemImage, _):
            if let _ = content as? EmptyView {
                HStack {
                    if let systemImage = systemImage {
                        Label(title, systemImage: systemImage)
                    }
                    else {
                        Text(title)
                    }
                }
                .padding(.horizontal, 12)
                .padding(16)
                .background(
                    Capsule()
                        .foregroundColor(Color.white)
                        .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
                )
            }
            else {
                content
                    .padding(.horizontal, 12)
                    .padding(16)
                    .background(
                        Capsule()
                            .foregroundColor(Color.white)
                            .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
                    )
                
            }
        }
    }
}
