# The Enchanted Quill ✨📚

An elegant dark academia-themed iOS app for book lovers, featuring beautiful typography and immersive reading experiences.

## Features

### 🏠 Home Feed
- Personalized reading recommendations
- Upcoming literary events and author streams
- Book of the Month highlights
- Most read books and active communities
- Reading goals and achievement tracking

### 📚 Digital Bookshelf
- Organize books by categories (Want to Read, Currently Reading, Finished)
- Create custom reading lists
- Beautiful book cover displays
- Track reading progress

### 👥 Book Clubs
- Discover local and online book clubs
- Join reading communities
- Participate in discussions
- Track club activities

### 💬 Chat & Community
- Connect with fellow readers
- Share book recommendations
- Join literary discussions
- Real-time messaging

### 👤 Reader Profile
- Reading statistics and streaks
- Literary achievements and badges
- Community activity tracking
- Personal reading creations
- Account management

## Design Philosophy

The Enchanted Quill embraces **Dark Academia** aesthetics with:
- Rich, warm color palettes in both light and dark themes
- Elegant typography using custom fonts (Beachwood, Beachwood Sans, Parisienne)
- Sophisticated layouts inspired by classic libraries
- Ambient lighting effects and subtle gradients

## Screenshots

### Dark Theme
![Home Screen Dark](screenshots/home-dark.png)
![Bookshelf Dark](screenshots/bookshelf-dark.png)
![Profile Dark](screenshots/profile-dark.png)

### Light Theme  
![Home Screen Light](screenshots/home-light.png)
![Bookshelf Light](screenshots/bookshelf-light.png)
![Profile Light](screenshots/profile-light.png)

## Build & Run Instructions

### Prerequisites
- **Xcode 15.0+**
- **iOS 17.0+** deployment target
- **macOS Sonoma** or later recommended

### Setup Steps

1. **Clone or download** this repository
   ```bash
   git clone <repository-url>
   cd TheEnchantedQuill
   ```

2. **Open the project**
   ```bash
   open TheEnchantedQuill.xcodeproj
   ```

3. **Select target device**
   - Choose iPhone simulator or connected device
   - Recommended: iPhone 15 Pro simulator for optimal experience

4. **Build and run**
   - Press `Cmd + R` or click the Play button
   - Wait for build to complete and app to launch

### Font Installation
Custom fonts are included in the project bundle:
- Beachwood (headers)
- Beachwood Sans (body text)
- Parisienne (decorative)

Fonts are automatically loaded via `Info.plist` configuration.

### Troubleshooting

**Build Errors:**
- Clean build folder: `Cmd + Shift + K`
- Reset simulator: Device → Erase All Content and Settings

**Font Issues:**
- Verify fonts are in the project bundle
- Check `Info.plist` UIAppFonts array

**Simulator Performance:**
- Use iPhone 15 Pro simulator for best performance
- Enable "GPU Frame Capture" in scheme for graphics debugging

## Architecture

- **SwiftUI** for declarative UI
- **Dark Academia** custom color system
- **Modular view structure** with reusable components
- **Environment-based** light/dark theme switching
- **Custom font system** with graceful fallbacks

## Development

The app follows SwiftUI best practices with:
- Environment-based theme management
- Reusable custom components
- Clean separation of concerns
- Responsive layout design
- Custom styling systems

## Future Enhancements

- [ ] Book scanning with camera
- [ ] Integration with Goodreads API
- [ ] Social sharing features
- [ ] Reading analytics dashboard
- [ ] Offline reading mode
- [ ] Push notifications for events

---

*Built with ❤️ for the literary community*