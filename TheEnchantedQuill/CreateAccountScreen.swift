//
//  CreateAccountScreen.swift
//  TheEnchantedQuill
//
//  Created by Tsaiching Wong-Heiner on 8/6/25.
//
import SwiftUI
import AuthenticationServices

struct CreateAccountScreen: View {
    @State private var displayName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var agreeToTerms: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showingTerms: Bool = false
    @State private var showingPrivacy: Bool = false
    @State private var showingProfileCreate: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    // Color scheme-aware colors
    private var backgroundGradient: LinearGradient {
        colorScheme == .dark ? LinearGradient.darkAcademiaBackground : LinearGradient.lightAcademiaBackground
    }
    
    private var primaryColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.primary : Color.LightAcademia.primary
    }
    
    private var onPrimaryContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onPrimaryContainer : Color.LightAcademia.onPrimaryContainer
    }
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var errorColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.error : Color.LightAcademia.error
    }
    
    private var outlineColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.outline : Color.LightAcademia.outline
    }
    
    private var onPrimaryColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onPrimary : Color.LightAcademia.onPrimary
    }
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.shadow : Color.LightAcademia.shadow
    }
    
    private var goldGradient: LinearGradient {
        colorScheme == .dark ? LinearGradient.darkAcademiaGold : LinearGradient.lightAcademiaGold
    }
    
    // Validation states
    @State private var displayNameError: String = ""
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with academia gradient (adapts to light/dark mode)
                backgroundGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
                        Spacer().frame(height: 10)
                        
                        // Logo
                        if let logoImage = UIImage(named: "theenchantedquill_logo_transparent") {
                            Image(uiImage: logoImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160, height: 160)
                                .shadow(color: shadowColor.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        
                        // Title
                        Text("Create Account")
                            .font(.custom("Beachwood", size: 32))
                            .foregroundColor(onPrimaryContainerColor)

                        // Error Message
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(errorColor)
                                .padding(.horizontal, 40)
                                .multilineTextAlignment(.center)
                        }
                        
                        // Form Fields
                        VStack(spacing: 20) {
                            // Display Name Field
                            VStack(alignment: .leading, spacing: 5) {
                                TextField("Display Name", text: $displayName)
                                    .textFieldStyle(DarkAcademiaTextFieldStyle())
                                    .onChange(of: displayName) { _ in
                                        validateDisplayName()
                                    }
                                
                                if !displayNameError.isEmpty {
                                    Text(displayNameError)
                                        .font(.caption)
                                        .foregroundColor(errorColor)
                                        .padding(.leading, 16)
                                }
                            }
                            
                            // Email Field
                            VStack(alignment: .leading, spacing: 5) {
                                TextField("Email", text: $email)
                                    .textFieldStyle(DarkAcademiaTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .onChange(of: email) { _ in
                                        validateEmail()
                                    }
                                
                                if !emailError.isEmpty {
                                    Text(emailError)
                                        .font(.caption)
                                        .foregroundColor(errorColor)
                                        .padding(.leading, 16)
                                }
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 5) {
                                SecureField("Password", text: $password)
                                    .textFieldStyle(DarkAcademiaTextFieldStyle())
                                    .onChange(of: password) { _ in
                                        validatePassword()
                                    }
                                
                                if !passwordError.isEmpty {
                                    Text(passwordError)
                                        .font(.caption)
                                        .foregroundColor(errorColor)
                                        .padding(.leading, 16)
                                }
                            }
                            
                            // Terms and Conditions Checkbox
                            HStack(alignment: .top, spacing: 12) {
                                Button(action: {
                                    agreeToTerms.toggle()
                                }) {
                                    Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                                        .foregroundColor(agreeToTerms ? primaryColor : outlineColor)
                                        .font(.system(size: 20))
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("I agree to the")
                                        .font(.caption)
                                        .foregroundColor(onSurfaceColor)
                                    
                                    HStack(spacing: 4) {
                                        Button("Terms and Conditions") {
                                            showingTerms = true
                                        }
                                        .font(.caption)
                                        .foregroundColor(primaryColor)
                                        
                                        Text("and")
                                            .font(.caption)
                                            .foregroundColor(onSurfaceColor)
                                        
                                        Button("Privacy Policy") {
                                            showingPrivacy = true
                                        }
                                        .font(.caption)
                                        .foregroundColor(primaryColor)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.horizontal, 40)
                        
                        // Sign Up Button
                        Button(action: signUpWithEmail) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: onPrimaryColor))
                                        .scaleEffect(0.8)
                                }
                                Text(isLoading ? "Creating Account..." : "Sign Up with Email")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(onPrimaryColor)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                Group {
                                    if isSignUpEnabled {
                                        goldGradient
                                    } else {
                                        outlineColor.opacity(0.5)
                                    }
                                }
                            )
                            .cornerRadius(12)
                            .shadow(color: primaryColor.opacity(0.3), radius: isSignUpEnabled ? 10 : 0, x: 0, y: isSignUpEnabled ? 5 : 0)
                        }
                        .disabled(!isSignUpEnabled || isLoading)
                        .padding(.horizontal, 40)
                        
                        // Divider
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(outlineColor)
                            
                            Text("or")
                                .font(.caption)
                                .foregroundColor(onSurfaceColor)
                                .padding(.horizontal, 16)
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(outlineColor)
                        }
                        .padding(.horizontal, 40)
                        
                        // Social Sign-In Buttons
                        VStack(spacing: 16) {
                            // Apple Sign In
                            SignInWithAppleButton(
                                onRequest: { request in
                                    configureAppleSignIn(request)
                                },
                                onCompletion: { result in
                                    handleAppleSignIn(result)
                                }
                            )
                            .signInWithAppleButtonStyle(.whiteOutline)
                            .frame(height: 50)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                            
                            // Google Sign In
                            Button(action: signInWithGoogle) {
                                HStack {
                                    Image(systemName: "globe")
                                        .font(.system(size: 18))
                                    Text("Continue with Google")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                }
                                .foregroundColor(onSurfaceColor)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(surfaceContainerColor)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(outlineColor, lineWidth: 1)
                                )
                            }
                            .padding(.horizontal, 40)
                            
                            // Facebook Sign In
                            Button(action: signInWithFacebook) {
                                HStack {
                                    Image(systemName: "person.2.fill")
                                        .font(.system(size: 18))
                                    Text("Continue with Facebook")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(12)
                            }
                            .padding(.horizontal, 40)
                        }
                        
                        Spacer().frame(height: 30)
                    }
                }
            }
        }
        .sheet(isPresented: $showingTerms) {
            TermsAndConditionsView()
        }
        .sheet(isPresented: $showingPrivacy) {
            PrivacyPolicyView()
        }
        .fullScreenCover(isPresented: $showingProfileCreate) {
            ProfileCreate_Birthday()
        }
    }
    
    // MARK: - Validation
    private var isSignUpEnabled: Bool {
        return !displayName.isEmpty &&
               !email.isEmpty &&
               !password.isEmpty &&
               agreeToTerms &&
               displayNameError.isEmpty &&
               emailError.isEmpty &&
               passwordError.isEmpty
    }
    
    private func validateDisplayName() {
        if displayName.count < 2 && !displayName.isEmpty {
            displayNameError = "Display name must be at least 2 characters"
        } else {
            displayNameError = ""
        }
    }
    
    private func validateEmail() {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !email.isEmpty && !emailPredicate.evaluate(with: email) {
            emailError = "Please enter a valid email address"
        } else {
            emailError = ""
        }
    }
    
    private func validatePassword() {
        if password.isEmpty {
            passwordError = ""
            return
        }
        
        var errors: [String] = []
        
        if password.count < 8 {
            errors.append("at least 8 characters")
        }
        
        if !password.contains(where: { $0.isUppercase }) {
            errors.append("one uppercase letter")
        }
        
        if !password.contains(where: { $0.isLowercase }) {
            errors.append("one lowercase letter")
        }
        
        if !password.contains(where: { $0.isNumber }) {
            errors.append("one number")
        }
        
        if !errors.isEmpty {
            passwordError = "Password must contain " + errors.joined(separator: ", ")
        } else {
            passwordError = ""
        }
    }
    
    // MARK: - Sign Up Actions
    private func signUpWithEmail() {
        isLoading = true
        errorMessage = ""
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            // Handle successful account creation
            print("Account created for: \(email)")
            
            // Navigate to ProfileCreate flow
            showingProfileCreate = true
        }
    }
    
    private func configureAppleSignIn(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    private func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                print("Apple Sign In successful: \(appleIDCredential.user)")
                // Navigate to ProfileCreate flow
                showingProfileCreate = true
            }
        case .failure(let error):
            print("Apple Sign In failed: \(error.localizedDescription)")
            errorMessage = "Apple Sign In failed. Please try again."
        }
    }
    
    private func signInWithGoogle() {
        // TODO: Add Google Sign In SDK implementation
        print("Google Sign In tapped")
        errorMessage = "Google Sign In coming soon!"
    }
    
    private func signInWithFacebook() {
        // TODO: Add Facebook Login SDK implementation  
        print("Facebook Sign In tapped")
        errorMessage = "Facebook Sign In coming soon!"
    }
}

// MARK: - Supporting Views
struct TermsAndConditionsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Terms and Conditions")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Your terms and conditions content goes here...")
                    .padding()
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct PrivacyPolicyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Your privacy policy content goes here...")
                    .padding()
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// MARK: - Preview
struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
