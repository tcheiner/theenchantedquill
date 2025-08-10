//
//  ProfileCreate_MainStart.swift
//  TheEnchantedQuill
//
//  Created by Tsaiching Wong-Heiner on 8/6/25.
//
import SwiftUI

struct ProfileCreate_MainStart: View {
    @State private var isLoading = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
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
    
    private var surfaceContainerHighColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainerHigh : Color.LightAcademia.surfaceContainerHigh
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with academia gradient (adapts to light/dark mode)
                backgroundGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header with back button (no logo as requested)
                        VStack(spacing: 20) {
                            // Back button
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 16, weight: .medium))
                                        Text("Back")
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                    .foregroundColor(primaryColor)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 40)
                            .padding(.top, 20)
                            
                            Spacer().frame(height: 40)
                            
                            // Title and subtitle
                            VStack(spacing: 16) {
                                Text("Set Up Your eQuill Profile")
                                    .font(.custom("Beachwood", size: 32))
                                    .foregroundColor(onPrimaryContainerColor)
                                    .shadow(color: shadowColor.opacity(0.5), radius: 4, x: 1, y: 1)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                                
                                Text("Let's help you select the perfect avatar that represents your literary persona. Your avatar will be your identity in The Enchanted Quill community.")
                                    .font(.body)
                                    .foregroundColor(onSurfaceColor.opacity(0.85))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .lineSpacing(2)
                                
                                Text("Don't worry – you can always skip this step if you want to jump right in and get started exploring.")
                                    .font(.subheadline)
                                    .foregroundColor(onSurfaceColor.opacity(0.7))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                                    .lineSpacing(2)
                            }
                        }
                        
                        Spacer().frame(height: 20)
                        
                        // Decorative element
                        VStack(spacing: 20) {
                            // Avatar preview placeholder (decorative)
                            ZStack {
                                Circle()
                                    .fill(surfaceContainerHighColor.opacity(0.6))
                                    .frame(width: 100, height: 100)
                                    .shadow(color: shadowColor.opacity(0.2), radius: 8, x: 0, y: 4)
                                
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(primaryColor.opacity(0.7))
                            }
                            
                            Text("Choose Your Avatar")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(onSurfaceColor.opacity(0.8))
                        }
                        
                        Spacer().frame(height: 40)
                        
                        // Action Buttons
                        VStack(spacing: 20) {
                            // Primary "Avatar Me" Button
                            Button(action: avatarMeAction) {
                                HStack {
                                    if isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: onPrimaryColor))
                                            .scaleEffect(0.8)
                                    }
                                    Text(isLoading ? "Loading..." : "Avatar Me")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(onPrimaryColor)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(goldGradient)
                                .cornerRadius(12)
                                .shadow(color: primaryColor.opacity(0.3), radius: 10, x: 0, y: 5)
                            }
                            .disabled(isLoading)
                            .padding(.horizontal, 40)
                            
                            // Secondary "Maybe Later" Action
                            Button(action: maybeLaterAction) {
                                Text("Maybe Later")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(primaryColor.opacity(0.8))
                                    .underline()
                            }
                            .disabled(isLoading)
                        }
                        
                        Spacer().frame(height: 60)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Actions
    private func avatarMeAction() {
        isLoading = true
        
        // Simulate brief loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoading = false
            
            print("Avatar Me tapped - navigating to avatar selection")
            
            // TODO: Navigate to avatar selection screen
            // NavigationLink or sheet presentation to avatar selection view
        }
    }
    
    private func maybeLaterAction() {
        print("Maybe Later tapped - skipping avatar setup")
        
        // Save preference to skip avatar setup
        UserDefaults.standard.set(true, forKey: "skippedAvatarSetup")
        
        // TODO: Navigate to next onboarding step or main app
        // This would typically go to the next ProfileCreate screen or complete onboarding
    }
}

// MARK: - Preview
struct ProfileCreate_MainStart_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreate_MainStart()
            .preferredColorScheme(.dark)
        
        ProfileCreate_MainStart()
            .preferredColorScheme(.light)
    }
}
