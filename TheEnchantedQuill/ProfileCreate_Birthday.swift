//
//  ProfileCreate_Birthday.swift
//  TheEnchantedQuill
//
//  Created by Tsaiching Wong-Heiner on 8/6/25.
//
import SwiftUI

struct ProfileCreate_Birthday: View {
    @State private var selectedDate = Date()
    @State private var showingAgeRestriction = false
    @State private var rejectUnder21 = true
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var showingMainStart = false
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
    
    // Age calculation
    private var userAge: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: selectedDate, to: Date())
        return ageComponents.year ?? 0
    }
    
    private var isUnder21: Bool {
        return userAge < 21
    }
    
    private var canProceed: Bool {
        return !isUnder21 || !rejectUnder21
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with academia gradient (adapts to light/dark mode)
                backgroundGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header with logo and title
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
                            
                            Spacer().frame(height: 10)
                            
                            // Logo
                            if let logoImage = UIImage(named: "theenchantedquill_logo_transparent") {
                                Image(uiImage: logoImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .shadow(color: shadowColor.opacity(0.3), radius: 6, x: 0, y: 3)
                            }
                            
                            // Title and subtitle
                            VStack(spacing: 12) {
                                Text("Select Your Birthday")
                                    .font(.custom("Beachwood", size: 28))
                                    .foregroundColor(onPrimaryContainerColor)
                                    .shadow(color: shadowColor.opacity(0.5), radius: 4, x: 1, y: 1)
                                
                                Text("We need your birthday to comply with local laws and ensure age-appropriate content.")
                                    .font(.subheadline)
                                    .foregroundColor(onSurfaceColor.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                            }
                        }
                        
                        // Error Message
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(errorColor)
                                .padding(.horizontal, 40)
                                .multilineTextAlignment(.center)
                        }
                        
                        // Date Picker Section
                        VStack(spacing: 20) {
                            // Date Picker
                            VStack(spacing: 16) {
                                HStack {
                                    Text("Birthday")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .foregroundColor(onSurfaceColor)
                                    Spacer()
                                }
                                .padding(.horizontal, 40)
                                
                                DatePicker(
                                    "Select your birthday",
                                    selection: $selectedDate,
                                    in: ...Date(),
                                    displayedComponents: .date
                                )
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                                .background(surfaceContainerColor.opacity(0.6))
                                .cornerRadius(16)
                                .padding(.horizontal, 40)
                                .shadow(color: shadowColor.opacity(0.1), radius: 8, x: 0, y: 4)
                                .onChange(of: selectedDate) { _ in
                                    checkAge()
                                }
                            }
                            
                            // Age Display
                            if userAge > 0 {
                                VStack(spacing: 8) {
                                    Text("Age: \(userAge) years old")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(isUnder21 ? errorColor : primaryColor)
                                    
                                    if isUnder21 {
                                        Text("⚠️ Under 21")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundColor(errorColor)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 6)
                                            .background(errorColor.opacity(0.1))
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal, 40)
                            }
                        }
                        
                        // Age Restriction Toggle (only shown if user is under 21)
                        if isUnder21 {
                            VStack(spacing: 16) {
                                Divider()
                                    .background(outlineColor)
                                    .padding(.horizontal, 40)
                                
                                VStack(spacing: 12) {
                                    HStack {
                                        Text("Age Restriction Policy")
                                            .font(.headline)
                                            .fontWeight(.medium)
                                            .foregroundColor(onSurfaceColor)
                                        Spacer()
                                    }
                                    
                                    HStack(alignment: .top, spacing: 16) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Restrict Users Under 21")
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .foregroundColor(onSurfaceColor)
                                            
                                            Text(rejectUnder21 ? "Currently restricting access for users under 21" : "Currently allowing all users regardless of age")
                                                .font(.caption)
                                                .foregroundColor(onSurfaceColor.opacity(0.7))
                                        }
                                        
                                        Spacer()
                                        
                                        Toggle("", isOn: $rejectUnder21)
                                            .toggleStyle(SwitchToggleStyle(tint: primaryColor))
                                    }
                                    
                                    // Warning message based on toggle state
                                    if rejectUnder21 {
                                        HStack(spacing: 8) {
                                            Image(systemName: "exclamationmark.triangle.fill")
                                                .foregroundColor(errorColor)
                                                .font(.caption)
                                            
                                            Text("Access will be denied for users under 21 years old")
                                                .font(.caption)
                                                .foregroundColor(errorColor)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(errorColor.opacity(0.1))
                                        .cornerRadius(8)
                                    } else {
                                        HStack(spacing: 8) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(primaryColor)
                                                .font(.caption)
                                            
                                            Text("All users will be allowed regardless of age")
                                                .font(.caption)
                                                .foregroundColor(onSurfaceColor)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(primaryColor.opacity(0.1))
                                        .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal, 40)
                            }
                        }
                        
                        Spacer().frame(height: 30)
                        
                        // Continue Button
                        Button(action: continueToNext) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: onPrimaryColor))
                                        .scaleEffect(0.8)
                                }
                                Text(isLoading ? "Verifying..." : "Continue")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(canProceed ? onPrimaryColor : onSurfaceColor.opacity(0.6))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                Group {
                                    if canProceed {
                                        goldGradient
                                    } else {
                                        outlineColor.opacity(0.3)
                                    }
                                }
                            )
                            .cornerRadius(12)
                            .shadow(color: primaryColor.opacity(0.3), radius: canProceed ? 10 : 0, x: 0, y: canProceed ? 5 : 0)
                        }
                        .disabled(!canProceed || isLoading)
                        .padding(.horizontal, 40)
                        
                        // Age restriction message for disabled button
                        if !canProceed {
                            Text("Access restricted for users under 21")
                                .font(.caption)
                                .foregroundColor(errorColor)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showingMainStart) {
            ProfileCreate_MainStart()
        }
        .onAppear {
            // Set default date to 25 years ago to avoid under-21 initially
            let calendar = Calendar.current
            if let defaultDate = calendar.date(byAdding: .year, value: -25, to: Date()) {
                selectedDate = defaultDate
            }
        }
    }
    
    // MARK: - Functions
    private func checkAge() {
        errorMessage = ""
        if isUnder21 && rejectUnder21 {
            errorMessage = ""
        }
    }
    
    private func continueToNext() {
        guard canProceed else {
            errorMessage = "You must be 21 or older to continue, or age restrictions must be disabled."
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        // Simulate API call to save birthday
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            
            // Save birthday data
            UserDefaults.standard.set(selectedDate, forKey: "userBirthday")
            UserDefaults.standard.set(userAge, forKey: "userAge")
            UserDefaults.standard.set(rejectUnder21, forKey: "ageRestrictionEnabled")
            
            print("Birthday saved: \(selectedDate)")
            print("User age: \(userAge)")
            print("Age restriction: \(rejectUnder21 ? "Enabled" : "Disabled")")
            
            // Navigate to ProfileCreate_MainStart
            showingMainStart = true
        }
    }
}

// MARK: - Preview
struct ProfileCreate_Birthday_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreate_Birthday()
            .preferredColorScheme(.dark)
        
        ProfileCreate_Birthday()
            .preferredColorScheme(.light)
    }
}
