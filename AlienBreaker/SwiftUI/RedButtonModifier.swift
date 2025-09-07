import SwiftUI

struct RedButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)       // White text
            .padding(3)
            .background(Color.red)         // Red background
            .cornerRadius(10)              // Rounded corners
            .shadow(radius: 3)             // Subtle shadow
    }
}

extension View {
    func redButtonStyle() -> some View {
        self.modifier(RedButtonModifier())
    }
}

// Useage: .redButtonStyle() // 👈 Custom modifier applied
