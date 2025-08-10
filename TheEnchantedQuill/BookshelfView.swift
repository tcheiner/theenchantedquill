//
//  BookshelfView.swift
//  TheEnchantedQuill
//
//  Created by Claude on 8/9/25.
//

import SwiftUI
import UIKit

struct BookshelfView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var customLists: [BookList] = []
    @State private var showingAddListSheet = false
    @State private var newListName = ""
    
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
                VStack(spacing: 8) {
                    Text("My Bookshelf")
                        .font(.custom("Beachwood", size: 38))
                        .foregroundColor(onPrimaryContainerColor)
                        .padding(.top, 10)
                    
                    Text("Your personal collection of books - currently reading, want to read, and finished.")
                        .font(.custom("Beachwood Sans", size: 20))
                        .foregroundColor(onSurfaceColor.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    // Bookshelf Images
                    VStack(spacing: 8) {
                        Button(action: {
                            // Handle read bookshelf tap
                        }) {
                            VStack(spacing: 8) {
                                if let _ = UIImage(named: "read_bookshelf") {
                                    Image("read_bookshelf")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 130)
                                        .cornerRadius(8)
                                } else {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(surfaceContainerColor)
                                        .frame(height: 130)
                                        .overlay(
                                            VStack {
                                                Image(systemName: "book.fill")
                                                    .font(.title)
                                                    .foregroundColor(goldColor)
                                                Text("Read Books")
                                                    .font(.caption)
                                                    .foregroundColor(onSurfaceColor)
                                            }
                                        )
                                }
                                
                                Text("Books I own")
                                    .fontWeight(.medium)
                                    .font(.custom("Beachwood Sans", size: 20))
                                    .foregroundColor(onSurfaceColor.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            // Handle ebook bookshelf tap
                        }) {
                            VStack(spacing: 8) {
                                if let _ = UIImage(named: "ebook_bookshelf") {
                                    Image("ebook_bookshelf")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 130)
                                        .cornerRadius(8)
                                } else {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(surfaceContainerColor)
                                        .frame(height: 130)
                                        .overlay(
                                            VStack {
                                                Image(systemName: "ipad")
                                                    .font(.title)
                                                    .foregroundColor(goldColor)
                                                Text("E-Books")
                                                    .font(.caption)
                                                    .foregroundColor(onSurfaceColor)
                                            }
                                        )
                                }
                                
                                Text("Ebooks I own")
                                    .fontWeight(.medium)
                                    .font(.custom("Beachwood Sans", size: 20))
                                    .foregroundColor(onSurfaceColor.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            // Handle wish bookshelf tap
                        }) {
                            VStack(spacing: 8) {
                                if let _ = UIImage(named: "wish_bookshelf") {
                                    Image("wish_bookshelf")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 130)
                                        .cornerRadius(8)
                                } else {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(surfaceContainerColor)
                                        .frame(height: 130)
                                        .overlay(
                                            VStack {
                                                Image(systemName: "heart")
                                                    .font(.title)
                                                    .foregroundColor(goldColor)
                                                Text("Wishlist")
                                                    .font(.caption)
                                                    .foregroundColor(onSurfaceColor)
                                            }
                                        )
                                }
                                
                                Text("Books: Desired")
                                    .fontWeight(.medium)
                                    .font(.custom("Beachwood Sans", size: 20))
                                    .foregroundColor(onSurfaceColor.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 30)
                    
                    // Custom Lists Section
                    if !customLists.isEmpty {
                        VStack(spacing: 15) {
                            Text("My Custom Lists")
                                .font(.custom("Beachwood", size: 24))
                                .foregroundColor(onPrimaryContainerColor)
                                .padding(.top, 20)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 15) {
                                ForEach(customLists) { list in
                                    CustomListCard(list: list) {
                                        // Handle list tap
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Add New List Button
                    Button(action: {
                        showingAddListSheet = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(goldColor)
                            
                            Text("Add New List")
                                .font(.custom("Beachwood Sans", size: 24))
                                .fontWeight(.medium)
                                .foregroundColor(onSurfaceColor)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(surfaceContainerColor)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(goldColor.opacity(0.3), lineWidth: 1.5)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, customLists.isEmpty ? 40 : 20)
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .sheet(isPresented: $showingAddListSheet) {
            AddListSheet(
                isPresented: $showingAddListSheet,
                listName: $newListName,
                onSave: { name in
                    addNewList(name: name)
                }
            )
        }
    }
    
    private func addNewList(name: String) {
        let newList = BookList(
            id: UUID(),
            name: name,
            bookCount: 0,
            createdDate: Date()
        )
        customLists.append(newList)
        newListName = ""
    }
}

// MARK: - Supporting Data Structures
struct BookList: Identifiable {
    let id: UUID
    let name: String
    let bookCount: Int
    let createdDate: Date
}

// MARK: - Supporting Views
struct CustomListCard: View {
    let list: BookList
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
            VStack(spacing: 12) {
                // List Icon
                Circle()
                    .fill(goldColor.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "list.bullet")
                            .font(.title2)
                            .foregroundColor(goldColor)
                    )
                
                VStack(spacing: 4) {
                    Text(list.name)
                        .font(.custom("Beachwood", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(onSurfaceColor)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    Text("\(list.bookCount) books")
                        .font(.caption)
                        .foregroundColor(onSurfaceColor.opacity(0.7))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(surfaceContainerColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(goldColor.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AddListSheet: View {
    @Binding var isPresented: Bool
    @Binding var listName: String
    let onSave: (String) -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
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
    
    private var primaryColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.primary : Color.LightAcademia.primary
    }
    
    private var outlineColor: Color {
        colorScheme == .dark ? Color.DarkAcademia.outline : Color.LightAcademia.outline
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(goldColor)
                        
                        Text("Create New List")
                            .font(.custom("Beachwood", size: 28))
                            .foregroundColor(onPrimaryContainerColor)
                        
                        Text("Give your new book list a memorable name")
                            .font(.body)
                            .foregroundColor(onSurfaceColor.opacity(0.8))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 40)
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("List Name")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(onSurfaceColor)
                            
                            TextField("Enter list name...", text: $listName)
                                .font(.body)
                                .foregroundColor(onSurfaceColor)
                                .padding(15)
                                .background(surfaceContainerColor)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(outlineColor, lineWidth: 1)
                                )
                        }
                        
                        // Save Button
                        Button(action: {
                            let trimmedName = listName.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !trimmedName.isEmpty {
                                onSave(trimmedName)
                                isPresented = false
                            }
                        }) {
                            Text("Create List")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? Color.DarkAcademia.onPrimary : Color.LightAcademia.onPrimary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(goldColor)
                                .cornerRadius(12)
                                .shadow(color: primaryColor.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .disabled(listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .opacity(listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                        listName = ""
                    }
                    .foregroundColor(goldColor)
                }
            }
        }
    }
}

struct BookshelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookshelfView()
            .preferredColorScheme(.dark)
        
        BookshelfView()
            .preferredColorScheme(.light)
    }
}
