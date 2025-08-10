# Credentials Management Setup

This document explains how to securely manage API keys and configuration in The Enchanted Quill.

## Files Created

### 1. `Credentials.swift`
Centralized configuration file with all API keys and URLs:
- Stream Chat configuration
- Backend API settings
- Third-party service keys
- Development vs Production environment handling

### 2. `.env.example`
Template file showing what environment variables are needed:
- Copy to `.env` and fill in real values
- Never commit `.env` to git

### 3. `.gitignore`
Updated to exclude sensitive files:
- `.env` files
- `Credentials.swift` files
- Screenshots directory
- Standard Xcode ignores

## Setup Instructions

### Step 1: Create Your Credentials File

Copy the example file and add your actual values:

```bash
cd TheEnchantedQuill/Config/
cp Credentials.swift.example Credentials.swift
```

Then edit `Credentials.swift` and add your actual values:

```swift
struct StreamChat {
    static let apiKey = "dz5f4d5kzrue"
    static let secret = "YOUR_ACTUAL_STREAM_SECRET" // ← Add this
}

struct Backend {
    static let baseURL = "https://your-actual-domain.com" // ← Add this
    static let apiKey = "YOUR_BACKEND_API_KEY" // ← Add this
}
```

### Step 2: Environment File (Optional)

Create `.env` file in project root:
```bash
cp .env.example .env
# Edit .env with your actual values
```

### Step 3: Update Code References

The app now uses `Credentials.currentStreamAPIKey` instead of hardcoded values:

```swift
// OLD
let config = ChatClientConfig(apiKey: .init("dz5f4d5kzrue"))

// NEW  
let config = ChatClientConfig(apiKey: .init(Credentials.currentStreamAPIKey))
```

## Security Features

### Environment-Aware Configuration
- **Development**: Uses localhost backend, debug settings
- **Production**: Uses production URLs, optimized settings
- Automatically switches based on build configuration

### Git Security
- `Credentials.swift` is gitignored (won't be committed)
- `.env` files are excluded
- Only `.env.example` template is tracked

### Best Practices
- Never commit actual API keys
- Use different keys for dev/prod environments
- Store secrets in secure credential management systems for production

## Usage in Code

```swift
// Stream Chat
let apiKey = Credentials.currentStreamAPIKey
let secret = Credentials.StreamChat.secret

// Backend API
let baseURL = Credentials.currentBackendURL
let apiKey = Credentials.Backend.apiKey

// Third-party services
let amazonKey = Credentials.ThirdParty.amazonAPIKey
let goodreadsKey = Credentials.ThirdParty.goodreadsAPIKey
```

## Team Collaboration

### For New Team Members:
1. Get `.env.example` from git
2. Ask team lead for actual API keys
3. Create local `Credentials.swift` with real values
4. Never commit these files

### For Production Deployment:
1. Set environment variables on server
2. Use secure credential management (AWS Secrets Manager, etc.)
3. Never store production keys in code

## Current Status

✅ **Credentials structure created**  
✅ **Development/Production environment handling**  
✅ **Git security configured**  
✅ **ChatScreen updated to use new system**  
⚠️ **Need to add actual API keys and secrets**  
⚠️ **Backend URL needs to be configured**  

## Next Steps

1. **Add your Stream Chat secret key** to `Credentials.swift`
2. **Set up backend URL** when you have a server
3. **Add other API keys** as you integrate more services
4. **Review security** before any production deployment

This system gives you secure, environment-aware configuration management that scales with your app's growth.