import SwiftUI

struct DarkAcademiaTextFieldStyle: TextFieldStyle {
    @Environment(\.colorScheme) var colorScheme
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var outlineColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.outline : Color.LightAcademia.outline
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.shadow : Color.LightAcademia.shadow
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(surfaceContainerColor.opacity(0.8))
            .foregroundColor(onSurfaceColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(outlineColor, lineWidth: 1)
            )
            .shadow(color: shadowColor.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}