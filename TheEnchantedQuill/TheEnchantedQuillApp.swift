import SwiftUI
import AVKit

@main
struct TheEnchantedQuillApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var userEmail = ""
    
    var body: some View {
        if isLoggedIn {
            MainTabView(userEmail: userEmail)
        } else {
            WorkingLoginScreen(onLoginSuccess: { email in
                userEmail = email
                isLoggedIn = true
            })
        }
    }
}

struct WorkingLoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingCreateAccount: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    let onLoginSuccess: (String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Video
                WorkingBackgroundVideoView()
                    .ignoresSafeArea()
                
                // Academia overlay - reduced opacity to show video better
                (colorScheme == .dark ? Color.DarkAcademia.background : Color.LightAcademia.background)
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Logo with fallback
                    if let logoImage = UIImage(named: "theenchantedquill_logo_transparent") {
                        Image(uiImage: logoImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    } else {
                        Image(systemName: "book.closed")
                            .font(.system(size: 60))
                            .foregroundColor(colorScheme == .dark ? Color.DarkAcademia.onPrimaryContainer : Color.LightAcademia.onPrimaryContainer)
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    
                    
                    Spacer().frame(height: 40)
                    
                    // Login Form
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .textFieldStyle(DarkAcademiaTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(DarkAcademiaTextFieldStyle())
                        
                        // Login Button
                        Button(action: loginAction) {
                            Text("Login")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? Color.DarkAcademia.onPrimary : Color.LightAcademia.onPrimary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold)
                                .cornerRadius(12)
                                .shadow(color: (colorScheme == .dark ? Color.DarkAcademia.primary : Color.LightAcademia.primary).opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .disabled(email.isEmpty || password.isEmpty)
                        .opacity(email.isEmpty || password.isEmpty ? 0.6 : 1.0)
                        
                        // Create Account Button
                        Button(action: createAccountAction) {
                            Text("Create Account")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(colorScheme == .dark ? Color.DarkAcademia.primary : Color.LightAcademia.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background((colorScheme == .dark ? Color.DarkAcademia.onPrimaryContainer : Color.LightAcademia.onPrimaryContainer).opacity(0.9))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(colorScheme == .dark ? Color.DarkAcademia.outline : Color.LightAcademia.outline, lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    // Copyright
                    Text("Copyright 2025 eQuill")
                        .font(.caption)
                        .foregroundColor((colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface).opacity(0.6))
                        .padding(.top, 20)
                    
                    Spacer()
                    Spacer()
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $showingCreateAccount) {
            CreateAccountScreen()
        }
    }
    
    private func loginAction() {
        print("Login tapped with email: \(email)")
        onLoginSuccess(email.isEmpty ? "demo@theenchantedquill.com" : email)
    }
    
    private func createAccountAction() {
        showingCreateAccount = true
    }
}

// Working BackgroundVideoView using AVPlayerViewController
struct WorkingBackgroundVideoView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        guard let videoURL = Bundle.main.url(forResource: "teaser", withExtension: "mp4") else {
            print("❌ Teaser video file not found")
            let emptyController = AVPlayerViewController()
            emptyController.view.backgroundColor = UIColor.black
            return emptyController
        }
        
        print("✅ Video file found: \(videoURL)")
        
        let player = AVPlayer(url: videoURL)
        let controller = AVPlayerViewController()
        
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        controller.view.backgroundColor = UIColor.black
        
        // Auto-play and loop
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
            print("🔄 Video looped")
        }
        
        player.play()
        print("▶️ AVPlayerViewController started playback")
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Updates handled automatically by AVPlayerViewController
    }
}