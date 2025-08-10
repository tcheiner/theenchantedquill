//
//  ChatScreenWorking.swift
//  TheEnchantedQuill
//
//  Created by Claude on 8/8/25.
//
import SwiftUI
import StreamChat

// MARK: - ChatManager
class ChatManager: ObservableObject {
    let chatClient: ChatClient
    @Published var isConnected: Bool = false
    @Published var currentUser: CurrentChatUser?
    @Published var channel: ChatChannel?
    
    init() {
        // Configure StreamChat with API key
        let config = ChatClientConfig(apiKey: .init(Credentials.currentStreamAPIKey))
        self.chatClient = ChatClient(config: config)
    }
    
    func connectUser(email: String) {
        print("🔄 Attempting to connect user: \(email)")
        // For demo, just mark as connected without actual StreamChat connection
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isConnected = true
            print("✅ Demo chat connection successful")
        }
    }
    
    func disconnect() {
        isConnected = false
        currentUser = nil
        channel = nil
    }
}

struct ChatScreen: View {
    @StateObject private var chatManager = ChatManager()
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(id: 1, text: "Welcome to The Enchanted Quill! How can I assist you with your literary journey today?", isFromUser: false, timestamp: Date()),
        ChatMessage(id: 2, text: "Hello! I'm excited to explore this literary community.", isFromUser: true, timestamp: Date().addingTimeInterval(-300))
    ]
    @State private var isTyping: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    // User email for authentication
    let userEmail: String
    
    // Flag to determine if this is shown in a sheet (true) or tab (false)
    var isSheetPresentation: Bool = false
    
    init(userEmail: String = "demo@theenchantedquill.com", isSheetPresentation: Bool = false) {
        self.userEmail = userEmail
        self.isSheetPresentation = isSheetPresentation
    }
    
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
    
    private var outlineColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.outline : Color.LightAcademia.outline
    }
    
    private var onPrimaryColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onPrimary : Color.LightAcademia.onPrimary
    }
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var surfaceContainerHighColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainerHigh : Color.LightAcademia.surfaceContainerHigh
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.shadow : Color.LightAcademia.shadow
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with academia gradient
                backgroundGradient
                    .ignoresSafeArea(.container, edges: .top)
                
                if chatManager.isConnected {
                    // Show chat interface when connected
                    chatInterfaceView(geometry: geometry)
                } else {
                    // Show loading state while connecting
                    loadingView()
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            // Connect user when view appears
            chatManager.connectUser(email: userEmail)
        }
        .onDisappear {
            // Disconnect when view disappears
            chatManager.disconnect()
        }
    }
    
    private func chatInterfaceView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 0) {
                // Status bar spacer
                Color.clear
                    .frame(height: geometry.safeAreaInsets.top)
                
                // Navigation header
                HStack(alignment: .center, spacing: 16) {
                    // Back button (only when shown as sheet)
                    if isSheetPresentation {
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
                    
                    // Chat title
                    VStack(spacing: 2) {
                        Text("Private Chat")
                            .font(.custom("Beachwood", size: isSheetPresentation ? 20 : 24))
                            .foregroundColor(onPrimaryContainerColor)
                        
                        Text("Online")
                            .font(.caption)
                            .foregroundColor(onSurfaceColor.opacity(0.7))
                    }
                    .frame(maxWidth: isSheetPresentation ? nil : .infinity)
                    
                    if isSheetPresentation {
                        Spacer()
                    }
                    
                    // Menu button
                    Button(action: {
                        // TODO: Add menu functionality
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(primaryColor)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    surfaceContainerColor.opacity(0.9)
                        .shadow(color: shadowColor.opacity(0.1), radius: 2, x: 0, y: 1)
                )
            }
            
            // Messages area
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                        
                        // Typing indicator
                        if isTyping {
                            TypingIndicator()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 100) // Space for input area
                }
                .onChange(of: messages.count) { _ in
                    // Auto-scroll to bottom when new message arrives
                    if let lastMessage = messages.last {
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .overlay(
            // Message input area (floating at bottom)
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    // Input container
                    HStack(alignment: .bottom, spacing: 12) {
                        // Text input
                        HStack {
                            TextField("Write a message...", text: $messageText, axis: .vertical)
                                .lineLimit(1...4)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(surfaceContainerColor.opacity(0.9))
                                .foregroundColor(onSurfaceColor)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(outlineColor.opacity(0.3), lineWidth: 1)
                                )
                            
                            // Send button
                            Button(action: sendMessage) {
                                Image(systemName: messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "paperplane" : "paperplane.fill")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? onSurfaceColor.opacity(0.5) : goldColor)
                                    .frame(width: 36, height: 36)
                                    .background(
                                        Circle()
                                            .fill(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 
                                                  surfaceContainerHighColor.opacity(0.5) : goldColor.opacity(0.15))
                                    )
                            }
                            .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 16)
                    .background(
                        surfaceContainerColor.opacity(0.95)
                            .shadow(color: shadowColor.opacity(0.1), radius: 8, x: 0, y: -2)
                    )
                }
            }
        )
    }
    
    private func loadingView() -> some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(goldColor)
            
            Text("Connecting to Literary Companion...")
                .font(.custom("Beachwood", size: 18))
                .foregroundColor(onPrimaryContainerColor)
        }
    }
    
    // MARK: - Actions
    private func sendMessage() {
        let trimmedText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        // Add user message to local array (UI demo - will integrate with StreamChat later)
        let userMessage = ChatMessage(
            id: messages.count + 1,
            text: trimmedText,
            isFromUser: true,
            timestamp: Date()
        )
        messages.append(userMessage)
        
        // Clear input
        messageText = ""
        
        // Simulate literary companion response
        simulateCompanionResponse()
    }
    
    private func simulateCompanionResponse() {
        // Simulate typing and response from literary companion
        isTyping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isTyping = false
            
            let responses = [
                "That's a fascinating perspective! Literature has such a unique way of connecting us across time and space.",
                "I love how you're thinking about this. What other literary themes resonate with you?",
                "Your insight reminds me of some wonderful passages from classic literature. Have you explored any particular genres lately?",
                "The beauty of literary discussion is how each reader brings their own experience to the text. What draws you to this topic?",
                "Thank you for sharing that thought. The world of literature is so rich with perspectives like yours."
            ]
            
            // Add companion response to local array (UI demo)
            let botMessage = ChatMessage(
                id: self.messages.count + 1,
                text: responses.randomElement() ?? "Thank you for sharing that with me!",
                isFromUser: false,
                timestamp: Date()
            )
            self.messages.append(botMessage)
        }
    }
}

// MARK: - Supporting Views
struct MessageBubble: View {
    let message: ChatMessage
    @Environment(\.colorScheme) var colorScheme
    
    private var bubbleColor: Color {
        if message.isFromUser {
            return colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
        } else {
            return colorScheme == .dark ? Color.DarkAcademia.surfaceContainerHigh : Color.LightAcademia.surfaceContainerHigh
        }
    }
    
    private var textColor: Color {
        if message.isFromUser {
            return colorScheme == .dark ? Color.DarkAcademia.onPrimary : Color.LightAcademia.onPrimary
        } else {
            return colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
        }
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.shadow : Color.LightAcademia.shadow
    }
    
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer(minLength: 60)
            }
            
            VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.body)
                    .foregroundColor(textColor)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(bubbleColor)
                    .cornerRadius(18)
                    .shadow(color: shadowColor.opacity(0.1), radius: 2, x: 0, y: 1)
                
                Text(formatTimestamp(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(textColor.opacity(0.6))
                    .padding(.horizontal, 4)
            }
            
            if !message.isFromUser {
                Spacer(minLength: 60)
            }
        }
    }
    
    private func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TypingIndicator: View {
    @State private var animationAmount: Double = 0
    @Environment(\.colorScheme) var colorScheme
    
    private var bubbleColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainerHigh : Color.LightAcademia.surfaceContainerHigh
    }
    
    private var dotColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.shadow : Color.LightAcademia.shadow
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(dotColor.opacity(0.6))
                        .frame(width: 6, height: 6)
                        .scaleEffect(animationAmount == Double(index) ? 1.0 : 0.5)
                        .animation(
                            Animation.easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                            value: animationAmount
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(bubbleColor)
            .cornerRadius(18)
            .shadow(color: shadowColor.opacity(0.1), radius: 2, x: 0, y: 1)
            
            Spacer(minLength: 60)
        }
        .onAppear {
            animationAmount = 1
        }
    }
}

// MARK: - Data Models
struct ChatMessage: Identifiable {
    let id: Int
    let text: String
    let isFromUser: Bool
    let timestamp: Date
}

// MARK: - Preview
struct ChatScreenWorking_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(userEmail: "preview@theenchantedquill.com")
            .preferredColorScheme(.dark)
        
        ChatScreen(userEmail: "preview@theenchantedquill.com")
            .preferredColorScheme(.light)
    }
}
