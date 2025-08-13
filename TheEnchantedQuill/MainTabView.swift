//
//  MainTabView.swift
//  TheEnchantedQuill
//
//  Created by Claude on 8/8/25.
//
import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    // User email for chat authentication
    let userEmail: String
    
    init(userEmail: String = "demo@theenchantedquill.com") {
        self.userEmail = userEmail
    }
    
    // Color scheme-aware colors
    private var tabBarColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var selectedColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    private var unselectedColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface.opacity(0.6) : Color.LightAcademia.onSurface.opacity(0.6)
    }
    
    var body: some View {
        TabView {
            // Home Tab
            HomeView(userEmail: userEmail)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            // Clubs Tab
            ClubsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Clubs")
                }
            
            // Bookshelf Tab
            BookshelfView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Bookshelf")
                }
            
            // Chat Tab
            ChatScreen(userEmail: userEmail)
                .tabItem {
                    Image(systemName: "message")
                    Text("Chats")
                }
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(selectedColor)
        .onChange(of: colorScheme) { _ in
            updateTabBarAppearance()
        }
        .onAppear {
            updateTabBarAppearance()
        }
    }
    
    private func updateTabBarAppearance() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(tabBarColor)
        
        // Configure tab bar item appearance
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(selectedColor)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(selectedColor),
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(unselectedColor)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(unselectedColor),
            .font: UIFont.systemFont(ofSize: 10, weight: .regular)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - Preview
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .preferredColorScheme(.dark)
        
        MainTabView()
            .preferredColorScheme(.light)
    }
}

