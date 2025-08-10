//
//  ClubsView.swift
//  TheEnchantedQuill
//
//  Created by Claude on 8/9/25.
//

import SwiftUI

struct ClubsView: View {
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
    
    private var goldColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.quillGold : Color.LightAcademia.quillGold
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(.container, edges: .top)
            
            VStack {
                // Header
                Text("Book Clubs")
                    .font(.custom("Beachwood", size: 32))
                    .foregroundColor(onPrimaryContainerColor)
                    .padding(.top, 20)
                
                // Tab selector
                HStack {
                    Button("Find Clubs") {
                        selectedTab = 0
                    }
                    .font(.custom("Beachwood Sans", size: 26))
                    .foregroundColor(selectedTab == 0 ? goldColor : onSurfaceColor.opacity(0.6))
                    .fontWeight(selectedTab == 0 ? .bold : .regular)
                    
                    Spacer()
                    
                    Button("My Clubs") {
                        selectedTab = 1
                    }
                    .font(.custom("Beachwood Sans", size: 26))
                    .foregroundColor(selectedTab == 1 ? goldColor : onSurfaceColor.opacity(0.6))
                    .fontWeight(selectedTab == 1 ? .bold : .regular)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                
                if selectedTab == 0 {
                    VStack(spacing: 30) {
                        Text("Discover book clubs in your area and around the world.")
                            .font(.body)
                            .foregroundColor(onSurfaceColor.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Image(systemName: "person.3")
                            .font(.system(size: 60))
                            .foregroundColor(onSurfaceColor.opacity(0.3))
                    }
                } else {
                    VStack(spacing: 30) {
                        Text("Your joined book clubs and reading groups will appear here.")
                            .font(.body)
                            .foregroundColor(onSurfaceColor.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 60))
                            .foregroundColor(onSurfaceColor.opacity(0.3))
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ClubsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubsView()
            .preferredColorScheme(.dark)
        
        ClubsView()
            .preferredColorScheme(.light)
    }
}
