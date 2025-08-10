//
//  ChatView.swift
//  TheEnchantedQuill
//
//  Created by Claude on 8/9/25.
//

import SwiftUI

struct ChatView: View {
    let userEmail: String
    
    init(userEmail: String = "demo@theenchantedquill.com") {
        self.userEmail = userEmail
    }
    
    var body: some View {
        ChatScreen(userEmail: userEmail)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}