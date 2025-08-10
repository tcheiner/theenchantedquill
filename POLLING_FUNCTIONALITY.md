# Polling and Meetups Implementation Guide

This document outlines how to implement polling and meetup features for book clubs using Stream Chat as the foundation.

## Polling Implementation

### Using Stream's Custom Messages

Stream Chat allows custom message types that we can leverage for polls:

```swift
// Custom poll message type
struct PollMessage {
    let question: String
    let options: [String]
    let votes: [String: String] // userId: selectedOption
    let createdBy: String
    let endTime: Date?
}

// Send poll as custom message
let pollData: [String: Any] = [
    "type": "poll",
    "question": "Which book should we read next?",
    "options": ["Dune", "Foundation", "Neuromancer"],
    "end_time": Date().addingTimeInterval(86400) // 24 hours
]

channel.sendMessage(text: "📊 New Poll", extraData: pollData)
```

### Custom UI Components

Create specialized SwiftUI views for poll rendering:

```swift
struct PollMessageView: View {
    let poll: PollMessage
    @State private var selectedOption: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(poll.question)
                .font(.headline)
            
            ForEach(poll.options, id: \.self) { option in
                PollOptionView(
                    option: option,
                    votes: poll.votes.values.filter { $0 == option }.count,
                    isSelected: selectedOption == option,
                    onTap: { vote(for: option) }
                )
            }
        }
    }
}
```

## Meetups Implementation

### Database Schema

Backend database structure for meetup management:

```swift
struct Meetup {
    let id: String
    let clubId: String
    let title: String
    let description: String
    let location: String? // "Virtual" or address
    let dateTime: Date
    let maxAttendees: Int?
    let attendees: [String] // userIds
    let createdBy: String
}
```

### Stream Integration

Integrate meetups with Stream Chat for announcements:

```swift
// Create meetup announcement in chat
func createMeetup(_ meetup: Meetup) {
    let meetupData: [String: Any] = [
        "type": "meetup",
        "meetup_id": meetup.id,
        "title": meetup.title,
        "date": meetup.dateTime.iso8601,
        "location": meetup.location ?? "Virtual"
    ]
    
    channel.sendMessage(
        text: "📅 New Meetup: \(meetup.title)",
        extraData: meetupData
    )
}
```

## Backend Requirements

### Additional Services Needed

```swift
// Polling Service
class PollService {
    func createPoll(in channelId: String, poll: Poll) async throws
    func vote(pollId: String, userId: String, option: String) async throws
    func getPollResults(pollId: String) async throws -> PollResults
}

// Meetup Service  
class MeetupService {
    func createMeetup(_ meetup: Meetup) async throws
    func joinMeetup(meetupId: String, userId: String) async throws
    func getUpcomingMeetups(for clubId: String) async throws -> [Meetup]
}
```

### Database Tables

SQL schema for supporting database infrastructure:

```sql
-- Polls
CREATE TABLE polls (
    id UUID PRIMARY KEY,
    channel_id VARCHAR NOT NULL,
    question TEXT NOT NULL,
    options JSONB NOT NULL,
    created_by UUID NOT NULL,
    end_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Poll Votes
CREATE TABLE poll_votes (
    poll_id UUID REFERENCES polls(id),
    user_id UUID NOT NULL,
    selected_option VARCHAR NOT NULL,
    voted_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (poll_id, user_id)
);

-- Meetups
CREATE TABLE meetups (
    id UUID PRIMARY KEY,
    club_id UUID NOT NULL,
    title VARCHAR NOT NULL,
    description TEXT,
    location VARCHAR,
    date_time TIMESTAMP NOT NULL,
    max_attendees INTEGER,
    created_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Meetup Attendees
CREATE TABLE meetup_attendees (
    meetup_id UUID REFERENCES meetups(id),
    user_id UUID NOT NULL,
    joined_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (meetup_id, user_id)
);
```

## Implementation Phases

### Phase 1 (MVP) - 1-2 weeks
**Polling:**
- Basic polls in chat channels
- Simple voting mechanism
- Real-time vote counting
- Poll expiration handling

**Meetups:**
- Simple meetup announcements
- RSVP functionality
- Basic attendee list

### Phase 2 (Enhanced) - 2-3 weeks
**Polling:**
- Poll analytics and insights
- Anonymous voting options
- Multiple choice polls
- Poll templates for common book club questions

**Meetups:**
- Calendar integration (EventKit)
- Location services and maps
- Push notifications for upcoming events
- Waitlist functionality for full meetups

### Phase 3 (Advanced) - 3-4 weeks
**Polling:**
- Scheduled polls (auto-post at specific times)
- Poll history and trends
- Integration with reading progress

**Meetups:**
- Recurring meetup templates
- Breakout room creation for large meetups
- Integration with video calling APIs (Zoom, Google Meet)
- Meetup feedback and ratings

## Technical Considerations

### Stream Chat Integration
- Leverage Stream's real-time capabilities for live poll updates
- Use custom message types to maintain chat flow
- Implement proper message rendering for different content types

### Data Synchronization
- Ensure poll votes sync across all clients in real-time
- Handle offline voting with conflict resolution
- Cache meetup data for quick access

### User Experience
- Seamless integration with existing chat interface
- Clear visual distinction between regular messages and interactive content
- Proper loading states and error handling

### Performance
- Optimize for large book clubs (1000+ members)
- Implement pagination for poll history
- Use efficient database queries for vote counting

## Development Time Estimate

**Total MVP Implementation:** 2-3 weeks
- Backend API development: 1 week
- iOS UI components: 1 week  
- Integration and testing: 1 week

**Prerequisites:**
- Existing Stream Chat integration
- Backend infrastructure (database, API)
- User authentication system

## Next Steps

1. **Start with Polling MVP**: Simpler to implement and test
2. **Create custom Stream message types**: Foundation for both features
3. **Design database schema**: Plan for future enhancements
4. **Build UI components**: Reusable across different chat contexts
5. **Add meetup functionality**: Build on polling infrastructure

Would you like to begin with the polling feature implementation, or focus on the meetup system architecture?