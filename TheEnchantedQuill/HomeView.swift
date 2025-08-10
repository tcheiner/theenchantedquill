//
//  HomeView.swift
//  TheEnchantedQuill
//
//  Created by Claude on 8/9/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    let userEmail: String
    
    init(userEmail: String = "demo@theenchantedquill.com") {
        self.userEmail = userEmail
    }
    
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
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.container, edges: .top)
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Good morning,")
                              .foregroundColor(onSurfaceColor.opacity(0.8))
                                .font(.custom("Beachwood", size: 30))
                                .padding(.top, 2)
                            Text("Reader")
                                .font(.custom("Beachwood", size: 38))
                                .foregroundColor(onPrimaryContainerColor)
                                .padding(.top, 3)
                        }
                        Spacer()
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(onSurfaceColor.opacity(0.7))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Upcoming Events
                    CollectionSection(title: "Upcoming Events") {
                        VStack(spacing: 0) {
                            ScheduleEventRow(time: "4:00 PM EST", title: "Author Live Stream with J.K. Rowling", icon: "video")
                            
                            Divider()
                                .background(onSurfaceColor.opacity(0.2))
                                .padding(.horizontal, 20)
                            
                            ScheduleEventRow(time: "5:00 PM EST", title: "TikTok Book Review", icon: "star")
                            
                            Divider()
                                .background(onSurfaceColor.opacity(0.2))
                                .padding(.horizontal, 20)
                            
                            ScheduleEventRow(time: "8:00 PM EST", title: "Writing Contest Start", icon: "trophy")
                        }
                        .background(surfaceContainerColor)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Book of the Month
                    CollectionSection(title: "Book of the Month") {
                        HStack(spacing: 20) {
                            // Book cover
                            Image("seven_books_sample")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 150)
                                .clipped()
                                .cornerRadius(12)
                            
                            // Book info
                            VStack(alignment: .leading, spacing: 10) {
                                Text("The Seven Moons of Maali Almeida")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(onSurfaceColor)
                                    .multilineTextAlignment(.leading)
                                
                                Text("\"Death becomes an extraordinary literary adventure.\"")
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(onSurfaceColor.opacity(0.7))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(surfaceContainerColor.opacity(0.5))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Most Read Today
                    CollectionSection(title: "Most Read Book Today") {
                        HStack(spacing: 20) {
                            // Book cover
                            Image("project_hailmary")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 150)
                                .clipped()
                                .cornerRadius(12)
                            
                            // Book info
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Project Hail Mary")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(onSurfaceColor)
                                    .multilineTextAlignment(.leading)
                                
                                Text("by Andy Weir")
                                    .font(.subheadline)
                                    .foregroundColor(onSurfaceColor.opacity(0.8))
                                
                                Text("\"Science saves humanity with unexpected humor.\"")
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(onSurfaceColor.opacity(0.7))
                                    .multilineTextAlignment(.leading)
                                
                                Text("1,247 readers today")
                                    .font(.caption)
                                    .foregroundColor(goldColor)
                                    .fontWeight(.medium)
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(surfaceContainerColor.opacity(0.5))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Most Active Book Club Today
                    CollectionSection(title: "Most Active Book Club Today") {
                        HStack(spacing: 15) {
                            Circle()
                                .fill(surfaceContainerColor)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "person.3.fill")
                                        .foregroundColor(goldColor)
                                )
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Fantasy Lovers United")
                                    .font(.headline)
                                    .foregroundColor(onSurfaceColor)
                                Text("Currently reading: The Way of Kings")
                                    .font(.subheadline)
                                    .foregroundColor(onSurfaceColor.opacity(0.7))
                                Text("127 active members")
                                    .font(.caption)
                                    .foregroundColor(goldColor)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Most Active Community Today
                    CollectionSection(title: "Most Active Community Today") {
                        HStack(spacing: 15) {
                            Circle()
                                .fill(surfaceContainerColor)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "bubble.left.and.bubble.right.fill")
                                        .foregroundColor(goldColor)
                                )
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Mystery & Thriller")
                                    .font(.headline)
                                    .foregroundColor(onSurfaceColor)
                                Text("Hot topic: Best plot twists of 2024")
                                    .font(.subheadline)
                                    .foregroundColor(onSurfaceColor.opacity(0.7))
                                Text("89 new posts today")
                                    .font(.caption)
                                    .foregroundColor(goldColor)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Easiest Wins
                    CollectionSection(title: "Next Goals") {
                        VStack(spacing: 12) {
                            EasyWinRow(
                                icon: "book.fill",
                                task: "Read 1 more book to get your next badge",
                                badgeType: "Reading Streak"
                            )
                            
                            EasyWinRow(
                                icon: "bubble.left.fill",
                                task: "Comment on 1 book club to get your next badge",
                                badgeType: "Community Member"
                            )
                            
                            EasyWinRow(
                                icon: "star.fill",
                                task: "Review 3 more books to get your next badge",
                                badgeType: "Book Critic"
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
        }
    }
}

// MARK: - Helper Views
struct CollectionSection<Content: View>: View {
    let title: String
    let content: Content
    
    @Environment(\.colorScheme) var colorScheme
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(title)
                    .font(.custom("Beachwood Sans", size: 26))
                    .fontWeight(.semibold)
                    .foregroundColor(onSurfaceColor)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            content
        }
    }
}

struct ScheduleEventRow: View {
    let time: String
    let title: String
    let icon: String
    
    @Environment(\.colorScheme) var colorScheme
    
    private var onSurfaceColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.onSurface : Color.LightAcademia.onSurface
    }
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        Button(action: {
            // Handle event tap
        }) {
            HStack(spacing: 15) {
                // Time
                Text(time)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(goldColor)
                    .frame(width: 90, alignment: .leading)
                
                // Icon
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(goldColor)
                    .frame(width: 20)
                
                // Event title
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(onSurfaceColor)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(onSurfaceColor.opacity(0.5))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct EasyWinRow: View {
    let icon: String
    let task: String
    let badgeType: String
    
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
        Button(action: {
            // Handle easy win tap
        }) {
            HStack(spacing: 15) {
                // Icon
                Circle()
                    .fill(goldColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 18))
                            .foregroundColor(goldColor)
                    )
                
                // Task info
                VStack(alignment: .leading, spacing: 4) {
                    Text(task)
                        .font(.subheadline)
                        .foregroundColor(onSurfaceColor)
                        .multilineTextAlignment(.leading)
                    
                    Text(badgeType + " Badge")
                        .font(.caption)
                        .foregroundColor(goldColor)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(onSurfaceColor.opacity(0.5))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(surfaceContainerColor)
            .cornerRadius(12)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
        
        HomeView()
            .preferredColorScheme(.light)
    }
}
