//
//  ProfileView.swift
//  TheEnchantedQuill
//
//  Created by Claude on 8/9/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = 0
    
    private var backgroundGradient: LinearGradient {
        colorScheme == .dark ? LinearGradient.darkAcademiaBackground : LinearGradient.lightAcademiaBackground
    }
    
    private var onPrimaryContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onPrimaryContainer : Color.LightAcademia.onPrimaryContainer
    }
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    private let tabs = ["Stats", "Achievements", "Creations", "Settings"]
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.container, edges: .top)
            
            VStack(spacing: 0) {
                // Header
                Text("Your Profile")
                    .font(.custom("Beachwood", size: 32))
                    .foregroundColor(onPrimaryContainerColor)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                
                // Tab selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(0..<tabs.count, id: \.self) { index in
                            Button(tabs[index]) {
                                selectedTab = index
                            }
                            .foregroundColor(selectedTab == index ? goldColor : onSurfaceColor.opacity(0.6))
                            .fontWeight(selectedTab == index ? .bold : .regular)
                            .scaleEffect(selectedTab == index ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: selectedTab)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                
                // Tab content
                ScrollView {
                    switch selectedTab {
                    case 0:
                        StatsTabView()
                    case 1:
                        AchievementsTabView()
                    case 2:
                        CreationsTabView()
                    case 3:
                        SettingsTabView()
                    default:
                        StatsTabView()
                    }
                }
            }
        }
    }
}

// MARK: - Profile Tab Views
struct StatsTabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Reading Stats
            VStack(spacing: 15) {
                Text("Reading Statistics")
                    .font(.custom("Beachwood Sans", size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(onSurfaceColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    StatCard(title: "Books Read", value: "47", subtitle: "This year", icon: "book.fill")
                    StatCard(title: "Reading Streak", value: "23", subtitle: "Days", icon: "flame.fill")
                    StatCard(title: "Pages Read", value: "12,847", subtitle: "Total", icon: "doc.text.fill")
                    StatCard(title: "Time Reading", value: "142h", subtitle: "This month", icon: "clock.fill")
                }
                .padding(.horizontal, 20)
            }
            
            // Community Stats
            VStack(spacing: 15) {
                Text("Community Activity")
                    .font(.custom("Beachwood Sans", size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(onSurfaceColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    StatCard(title: "Reviews Written", value: "23", subtitle: "Total", icon: "star.fill")
                    StatCard(title: "Clubs Joined", value: "5", subtitle: "Active", icon: "person.3.fill")
                    StatCard(title: "Comments Made", value: "89", subtitle: "Total", icon: "bubble.left.fill")
                    StatCard(title: "Books Shared", value: "31", subtitle: "Recommended", icon: "square.and.arrow.up.fill")
                }
                .padding(.horizontal, 20)
            }
            
            Spacer(minLength: 50)
        }
        .padding(.top, 10)
    }
}

struct AchievementsTabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Literary Achievements")
                .font(.custom("Beachwood Sans", size: 20))
                .fontWeight(.semibold)
                .foregroundColor(onSurfaceColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 15) {
                AchievementBadge(title: "First Book", description: "Read your first book", icon: "book.fill", isEarned: true)
                AchievementBadge(title: "Bookworm", description: "Read 10 books", icon: "books.vertical.fill", isEarned: true)
                AchievementBadge(title: "Speed Reader", description: "Finish a book in one day", icon: "bolt.fill", isEarned: true)
                AchievementBadge(title: "Reviewer", description: "Write 5 reviews", icon: "star.fill", isEarned: true)
                AchievementBadge(title: "Social Reader", description: "Join your first book club", icon: "person.3.fill", isEarned: true)
                AchievementBadge(title: "Genre Explorer", description: "Read 3 different genres", icon: "compass.drawing", isEarned: false)
                AchievementBadge(title: "Marathon Reader", description: "Read 50 books in a year", icon: "trophy.fill", isEarned: false)
                AchievementBadge(title: "Night Owl", description: "Read past midnight 10 times", icon: "moon.fill", isEarned: false)
                AchievementBadge(title: "Classic Connoisseur", description: "Read 10 classic novels", icon: "building.columns.fill", isEarned: false)
            }
            .padding(.horizontal, 20)
            
            Spacer(minLength: 50)
        }
        .padding(.top, 10)
    }
}

struct CreationsTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedCreationType: CreationType? = nil
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    enum CreationType: String, CaseIterable {
        case reviews = "Reviews"
        case posts = "Posts"
        case messages = "Messages"
        case videos = "Videos"
        
        var icon: String {
            switch self {
            case .reviews: return "star.fill"
            case .posts: return "doc.text.fill"
            case .messages: return "message.fill"
            case .videos: return "video.fill"
            }
        }
        
        var count: Int {
            switch self {
            case .reviews: return 23
            case .posts: return 8
            case .messages: return 156
            case .videos: return 3
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if selectedCreationType == nil {
                // List view
                Text("Your Literary Creations")
                    .font(.custom("Beachwood Sans", size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(onSurfaceColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 15) {
                    ForEach(CreationType.allCases, id: \.self) { creationType in
                        CreationTypeRow(
                            type: creationType,
                            onTap: { selectedCreationType = creationType }
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer(minLength: 50)
            } else {
                // Detail view
                CreationDetailView(
                    type: selectedCreationType!,
                    onBack: { selectedCreationType = nil }
                )
            }
        }
        .padding(.top, 10)
        .animation(.easeInOut(duration: 0.3), value: selectedCreationType)
    }
}

struct SettingsTabView: View {
    @Environment(\.colorScheme) var colorScheme
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Account Settings")
                .font(.custom("Beachwood Sans", size: 20))
                .fontWeight(.semibold)
                .foregroundColor(onSurfaceColor)
            
            Text("Manage your account preferences, privacy settings, and app configurations.")
                .font(.body)
                .foregroundColor(onSurfaceColor.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Image(systemName: "gearshape.fill")
                .font(.system(size: 60))
                .foregroundColor(onSurfaceColor.opacity(0.3))
            
            Spacer(minLength: 100)
        }
        .padding(.top, 50)
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    
    @Environment(\.colorScheme) var colorScheme
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(goldColor)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(onSurfaceColor)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(onSurfaceColor.opacity(0.8))
                
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(goldColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(15)
        .background(surfaceContainerColor)
        .cornerRadius(12)
    }
}

struct AchievementBadge: View {
    let title: String
    let description: String
    let icon: String
    let isEarned: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // Badge Icon
            Circle()
                .fill(isEarned ? goldColor.opacity(0.2) : surfaceContainerColor)
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(isEarned ? goldColor : onSurfaceColor.opacity(0.4))
                )
                .scaleEffect(isEarned ? 1.0 : 0.8)
                .saturation(isEarned ? 1.0 : 0.3)
            
            VStack(spacing: 2) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isEarned ? onSurfaceColor : onSurfaceColor.opacity(0.6))
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(.caption2)
                    .foregroundColor(isEarned ? onSurfaceColor.opacity(0.7) : onSurfaceColor.opacity(0.4))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .padding(12)
        .background(surfaceContainerColor.opacity(isEarned ? 1.0 : 0.5))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isEarned ? goldColor.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }
}

struct CreationTypeRow: View {
    let type: CreationsTabView.CreationType
    let onTap: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 15) {
                // Icon
                Circle()
                    .fill(goldColor.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: type.icon)
                            .font(.title3)
                            .foregroundColor(goldColor)
                    )
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(type.rawValue)
                        .font(.headline)
                        .foregroundColor(onSurfaceColor)
                    
                    Text("\(type.count) items")
                        .font(.caption)
                        .foregroundColor(onSurfaceColor.opacity(0.7))
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(onSurfaceColor.opacity(0.5))
            }
            .padding(16)
            .background(surfaceContainerColor)
            .cornerRadius(12)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CreationDetailView: View {
    let type: CreationsTabView.CreationType
    let onBack: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: onBack) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                        Text("Back")
                            .font(.subheadline)
                    }
                    .foregroundColor(goldColor)
                }
                
                Spacer()
                
                Text("Your \(type.rawValue)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(onSurfaceColor)
                
                Spacer()
                
                // Placeholder for balance
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.caption)
                    Text("Back")
                        .font(.subheadline)
                }
                .opacity(0)
            }
            .padding(.horizontal, 20)
            
            // Content
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(getMockContent(), id: \.id) { item in
                        ContentItemView(item: item)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Spacer(minLength: 20)
        }
    }
    
    private func getMockContent() -> [ContentItem] {
        switch type {
        case .reviews:
            return [
                ContentItem(id: 1, title: "The Seven Husbands of Evelyn Hugo", content: "A captivating story that kept me turning pages until 3am. Taylor Jenkins Reid has crafted a masterpiece about love, ambition, and the price of fame...", date: "2 days ago", rating: 5),
                ContentItem(id: 2, title: "Project Hail Mary", content: "Andy Weir does it again! This sci-fi thriller combines humor with hard science in the most entertaining way possible. Grace is an unforgettable protagonist...", date: "1 week ago", rating: 4),
                ContentItem(id: 3, title: "The Midnight Library", content: "Matt Haig explores the concept of parallel lives with beautiful prose and deep philosophical questions. Though sometimes heavy-handed...", date: "2 weeks ago", rating: 4)
            ]
        case .posts:
            return [
                ContentItem(id: 1, title: "Top 10 Books That Changed My Perspective", content: "Here are the books that fundamentally shifted how I see the world. From philosophy to fiction, each one left an indelible mark...", date: "3 days ago"),
                ContentItem(id: 2, title: "Why Dark Academia Aesthetics Matter in Literature", content: "The dark academia trend isn't just about aesthetics—it's about creating atmosphere that enhances the reading experience...", date: "1 week ago"),
                ContentItem(id: 3, title: "Building the Perfect Reading Nook", content: "After months of experimentation, I've finally created the ultimate reading space. Here's what worked and what didn't...", date: "2 weeks ago")
            ]
        case .messages:
            return [
                ContentItem(id: 1, title: "Re: Book Club Discussion - Dune", content: "I completely agree with your analysis of Paul's character arc. Herbert's treatment of the hero's journey is subversive...", date: "1 hour ago"),
                ContentItem(id: 2, title: "Thanks for the recommendation!", content: "Just finished 'The Invisible Bridge' - absolutely stunning. Your description didn't do it justice. Have you read her other works?", date: "4 hours ago"),
                ContentItem(id: 3, title: "Fantasy Book Club Meeting", content: "Looking forward to tomorrow's discussion about The Name of the Wind. I have so many thoughts about Kvothe's storytelling style...", date: "1 day ago")
            ]
        case .videos:
            return [
                ContentItem(id: 1, title: "My Cozy Reading Vlog - October TBR", content: "Join me as I share my October reading list and create the perfect autumn reading atmosphere with candles, tea, and fairy lights.", date: "5 days ago"),
                ContentItem(id: 2, title: "BookTok Review: Fourth Wing", content: "Diving into the BookTok phenomenon that is Fourth Wing. Is it really as good as everyone says? Let's find out together!", date: "2 weeks ago"),
                ContentItem(id: 3, title: "Bookshelf Tour & Organization Tips", content: "Take a tour of my newly organized bookshelf and learn my favorite tips for categorizing and displaying your collection.", date: "1 month ago")
            ]
        }
    }
}

struct ContentItemView: View {
    let item: ContentItem
    
    @Environment(\.colorScheme) var colorScheme
    
    private var surfaceContainerColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.surfaceContainer : Color.LightAcademia.surfaceContainer
    }
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(item.title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(onSurfaceColor)
                
                Spacer()
                
                if let rating = item.rating {
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .font(.caption)
                                .foregroundColor(goldColor)
                        }
                    }
                }
            }
            
            Text(item.content)
                .font(.body)
                .foregroundColor(onSurfaceColor.opacity(0.8))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            Text(item.date)
                .font(.caption)
                .foregroundColor(goldColor)
        }
        .padding(15)
        .background(surfaceContainerColor)
        .cornerRadius(12)
    }
}

struct ContentItem {
    let id: Int
    let title: String
    let content: String
    let date: String
    let rating: Int?
    
    init(id: Int, title: String, content: String, date: String, rating: Int? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.rating = rating
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
        
        ProfileView()
            .preferredColorScheme(.light)
    }
}
