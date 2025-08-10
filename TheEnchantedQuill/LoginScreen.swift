//
//  LoginScreen.swift
//  TheEnchantedQuill
//
//  Created by Tsaiching Wong-Heiner on 8/6/25.
//
import SwiftUI
import AVKit

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingCreateAccount: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    // Color scheme-aware colors - use solid color instead of gradient
    private var backgroundColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.background : Color.LightAcademia.background
    }
    
    private var primaryColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.primary : Color.LightAcademia.primary
    }
    
    private var onPrimaryContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onPrimaryContainer : Color.LightAcademia.onPrimaryContainer
    }
    
    private var onPrimaryColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onPrimary : Color.LightAcademia.onPrimary
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.shadow : Color.LightAcademia.shadow
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    private var outlineColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.outline : Color.LightAcademia.outline
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Video
                BackgroundVideoView()
                    .ignoresSafeArea()
                
                // Academia overlay (adapts to light/dark mode)
                backgroundColor
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    // Logo - make it optional and don't crash if missing
                    if let logoImage = UIImage(named: "theenchantedquill_logo_transparent") {
                        Image(uiImage: logoImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 240, height: 240)
                            .shadow(color: shadowColor.opacity(0.5), radius: 10, x: 0, y: 5)
                    } else {
                        // Fallback - simple icon if logo is missing
                        Image(systemName: "book.closed")
                            .font(.system(size: 60))
                            .foregroundColor(onPrimaryContainerColor)
                            .shadow(color: shadowColor.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    Text("Login")
                        .fontWeight(.medium)
                        .font(.custom("Beachwood", size:38))
                        .foregroundColor(onPrimaryContainerColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Spacer().frame(height: 20)
                    
                    // Login Form
                    VStack(spacing: 20) {
                        // Email Field
                        TextField("Email", text: $email)
                            .textFieldStyle(DarkAcademiaTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        // Password Field
                        SecureField("Password", text: $password)
                            .textFieldStyle(DarkAcademiaTextFieldStyle())
                        
                        // Login Button
                        Button(action: loginAction) {
                            Text("Login")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(onPrimaryColor)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(goldColor)
                                .cornerRadius(12)
                                .shadow(color: primaryColor.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .disabled(email.isEmpty || password.isEmpty)
                        .opacity(email.isEmpty || password.isEmpty ? 0.6 : 1.0)
                        
                        // Create Account Button
                        Button(action: createAccountAction) {
                            Text("Create Account")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(primaryColor)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(onPrimaryContainerColor.opacity(0.9))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(outlineColor, lineWidth: 1)
                                )
                                .shadow(color: shadowColor.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                       
                    }
                    .padding(.horizontal, 40)
                    
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
    }
    
    private func createAccountAction() {
        showingCreateAccount = true
    }
}

// MARK: - Background Video View
struct BackgroundVideoView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        // Try to load the video file, but don't crash if it's missing
        guard let videoURL = Bundle.main.url(forResource: "teaser", withExtension: "mp4") else {
            print("Warning: Teaser video file not found, using solid background")
            view.backgroundColor = UIColor.black
            return view
        }
        
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        // Store player layer to update frame later
        view.tag = 999
        
        // Play the video on loop
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }
        player.play()
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update video layer frame
        if let playerLayer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            playerLayer.frame = uiView.bounds
        }
    }
}

// MARK: - Visual Effect Blur
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Preview
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
