import SwiftUI

extension Color {
    // MARK: - Dark Academia Color Scheme
    struct DarkAcademia {
        // Primary Colors
        static let primary = Color(red: 255/255, green: 183/255, blue: 127/255) // #FFB77F - Warm golden amber
        static let onPrimary = Color(red: 78/255, green: 38/255, blue: 0/255) // #4E2600 - Deep brown text
        static let primaryContainer = Color(red: 108/255, green: 58/255, blue: 8/255) // #6C3A08 - Rich brown container
        static let onPrimaryContainer = Color(red: 255/255, green: 220/255, blue: 196/255) // #FFDCC4 - Light cream text
        
        // Secondary Colors
        static let secondary = Color(red: 237/255, green: 192/255, blue: 108/255) // #EDC06C - Warm gold
        static let onSecondary = Color(red: 65/255, green: 45/255, blue: 0/255) // #412D00 - Dark brown text
        static let secondaryContainer = Color(red: 94/255, green: 66/255, blue: 0/255) // #5E4200 - Brown container
        static let onSecondaryContainer = Color(red: 255/255, green: 222/255, blue: 167/255) // #FFDEA7 - Pale gold text
        
        // Tertiary Colors
        static let tertiary = Color(red: 255/255, green: 180/255, blue: 168/255) // #FFB4A8 - Soft coral
        static let onTertiary = Color(red: 86/255, green: 30/255, blue: 23/255) // #561E17 - Dark red-brown
        static let tertiaryContainer = Color(red: 115/255, green: 52/255, blue: 43/255) // #73342B - Muted red-brown
        static let onTertiaryContainer = Color(red: 255/255, green: 218/255, blue: 213/255) // #FFDAD5 - Light coral
        
        // Surface Colors
        static let background = Color(red: 25/255, green: 18/255, blue: 13/255) // #19120D - Deep dark brown
        static let onBackground = Color(red: 239/255, green: 223/255, blue: 214/255) // #EFDFD6 - Warm light text
        static let surface = Color(red: 23/255, green: 19/255, blue: 11/255) // #17130B - Very dark brown
        static let onSurface = Color(red: 236/255, green: 225/255, blue: 212/255) // #ECE1D4 - Light surface text
        static let surfaceContainer = Color(red: 36/255, green: 31/255, blue: 23/255) // #241F17 - Dark container
        static let surfaceContainerHigh = Color(red: 47/255, green: 41/255, blue: 33/255) // #2F2921 - Medium container
        static let surfaceContainerHighest = Color(red: 58/255, green: 52/255, blue: 43/255) // #3A342B - Highest container
        
        // Outline Colors
        static let outline = Color(red: 158/255, green: 142/255, blue: 130/255) // #9E8E82 - Muted outline
        static let outlineVariant = Color(red: 81/255, green: 68/255, blue: 59/255) // #51443B - Subtle outline
        
        // Error Colors
        static let error = Color(red: 237/255, green: 158/255, blue: 152/255) // #ED9E98 - Soft error red
        static let onError = Color(red: 87/255, green: 30/255, blue: 27/255) // #571E1B - Dark error text
        static let errorContainer = Color(red: 115/255, green: 51/255, blue: 47/255) // #73332F - Error container
        
        // Shadow and Scrim
        static let shadow = Color.black // #000000 - Pure black shadow
        static let scrim = Color.black // #000000 - Pure black scrim
        
        // Extended Colors (Custom Academia Colors)
        static let bookBlue = Color(red: 153/255, green: 204/255, blue: 250/255) // #99CCFA - Scholarly blue
        static let inkBlue = Color(red: 154/255, green: 203/255, blue: 250/255) // #9ACBFA - Writing ink blue
        static let parchmentPurple = Color(red: 227/255, green: 183/255, blue: 243/255) // #E3B7F3 - Ancient parchment
        static let leafGreen = Color(red: 135/255, green: 214/255, blue: 188/255) // #87D6BC - Library plant green
        static let quillGold = Color(red: 245/255, green: 188/255, blue: 111/255) // #F5BC6F - Golden quill
    }
    
    // MARK: - Light Academia Color Scheme (for light mode)
    struct LightAcademia {
        // Primary Colors
        static let primary = Color(red: 137/255, green: 81/255, blue: 31/255) // #89511F - Deep academic brown
        static let onPrimary = Color.white // #FFFFFF - Pure white text
        static let primaryContainer = Color(red: 255/255, green: 220/255, blue: 196/255) // #FFDCC4 - Light cream container
        static let onPrimaryContainer = Color(red: 108/255, green: 58/255, blue: 8/255) // #6C3A08 - Dark brown text
        
        // Secondary Colors
        static let secondary = Color(red: 122/255, green: 89/255, blue: 12/255) // #7A590C - Warm brown
        static let onSecondary = Color.white // #FFFFFF - White text
        static let secondaryContainer = Color(red: 245/255, green: 235/255, blue: 225/255) // #F5EBE1 - Light container
        static let onSecondaryContainer = Color(red: 94/255, green: 66/255, blue: 0/255) // #5E4200 - Dark container text
        
        // Tertiary Colors
        static let tertiary = Color(red: 144/255, green: 74/255, blue: 64/255) // #904A40 - Muted red-brown
        static let onTertiary = Color.white // #FFFFFF - White text
        static let tertiaryContainer = Color(red: 255/255, green: 218/255, blue: 213/255) // #FFDAD5 - Light coral
        static let onTertiaryContainer = Color(red: 115/255, green: 52/255, blue: 43/255) // #73342B - Dark coral text
        
        // Surface Colors
        static let background = Color(red: 255/255, green: 248/255, blue: 245/255) // #FFF8F5 - Warm white background
        static let onBackground = Color(red: 34/255, green: 26/255, blue: 20/255) // #221A14 - Dark text on background
        static let surface = Color(red: 255/255, green: 248/255, blue: 243/255) // #FFF8F3 - Paper white surface
        static let onSurface = Color(red: 32/255, green: 27/255, blue: 19/255) // #201B13 - Dark surface text
        static let surfaceContainer = Color(red: 247/255, green: 236/255, blue: 223/255) // #F7ECDF - Light container
        static let surfaceContainerHigh = Color(red: 242/255, green: 231/255, blue: 217/255) // #F2E7D9 - Higher container
        static let surfaceContainerHighest = Color(red: 236/255, green: 225/255, blue: 212/255) // #ECE1D4 - Highest container
        
        // Outline Colors
        static let outline = Color(red: 132/255, green: 116/255, blue: 105/255) // #847469 - Medium outline
        static let outlineVariant = Color(red: 214/255, green: 195/255, blue: 182/255) // #D6C3B6 - Subtle outline
        
        // Error Colors
        static let error = Color(red: 144/255, green: 74/255, blue: 69/255) // #904A45 - Error brown-red
        static let onError = Color.white // #FFFFFF - White error text
        static let errorContainer = Color(red: 255/255, green: 218/255, blue: 214/255) // #FFDAD6 - Light error container
        static let onErrorContainer = Color(red: 115/255, green: 51/255, blue: 47/255) // #73332F - Dark error container text
        
        // Shadow and Scrim
        static let shadow = Color.black // #000000 - Pure black shadow
        static let scrim = Color.black // #000000 - Pure black scrim
        
        // Extended Colors (Custom Light Academia Colors)
        static let bookBlue = Color(red: 44/255, green: 99/255, blue: 139/255) // #2C638B - Deep scholarly blue
        static let inkBlue = Color(red: 45/255, green: 98/255, blue: 140/255) // #2D628C - Writing ink blue
        static let parchmentPurple = Color(red: 117/255, green: 80/255, blue: 133/255) // #755085 - Academic purple
        static let leafGreen = Color(red: 18/255, green: 107/255, blue: 86/255) // #126B56 - Library plant green
        static let quillGold = Color(red: 128/255, green: 86/255, blue: 17/255) // #805611 - Golden quill
    }
}

// MARK: - Gradient Extensions
extension LinearGradient {
    // Dark Academia Gradients
    static let darkAcademiaPrimary = LinearGradient(
        colors: [Color.DarkAcademia.primary, Color.DarkAcademia.secondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let darkAcademiaGold = LinearGradient(
        colors: [Color.DarkAcademia.quillGold, Color.DarkAcademia.primary],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let darkAcademiaBackground = LinearGradient(
        colors: [Color.DarkAcademia.background, Color.DarkAcademia.surfaceContainer],
        startPoint: .top,
        endPoint: .bottom
    )
    
    // Light Academia Gradients
    static let lightAcademiaPrimary = LinearGradient(
        colors: [Color.LightAcademia.primary, Color.LightAcademia.secondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let lightAcademiaGold = LinearGradient(
        colors: [Color.LightAcademia.quillGold, Color.LightAcademia.primary],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let lightAcademiaBackground = LinearGradient(
        colors: [Color.LightAcademia.background, Color.LightAcademia.surfaceContainer],
        startPoint: .top,
        endPoint: .bottom
    )
}