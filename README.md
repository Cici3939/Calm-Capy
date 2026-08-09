# 🦫 Calm-Capy
**Calm Capy** is a SwiftUI mental wellness application that combines mood tracking, journaling, guided breathing exercises, speech-based emotion recognition, and an AI chatbot into a single personalized experience.

The project explores how **mobile development, machine learning, cloud infrastructure, and generative AI** can be combined to create an approachable and privacy-conscious user experience.

> **Disclaimer:** Calm Capy is an educational/student project and is not intended to diagnose, treat, or replace professional mental health care.

---

## Overview

Calm Capy was designed around a simple idea: mental wellness tools should be easy to use, approachable, and available in one place.

The application provides:

* 📊 Daily mood tracking and visualization
* 🎙️ Speech-based emotion classification
* 🤖 AI-powered conversational support
* 📓 Private journaling
* 🌬️ Guided breathing exercises
* 🔐 User authentication and individualized data
* ☁️ Cloud data storage and synchronization
* 🎨 Custom SwiftUI interface and hand-drawn assets

The application was developed in **Swift and SwiftUI** in Xcode, with Firebase providing backend services and Google's Gemini API powering the conversational AI component.

---

# ✨ Features

## 📊 Mood Tracking

Users can manually record their mood using five categories:

* Happy
* Sad
* Neutral
* Angry
* Fearful

Mood history can then be explored through multiple visualizations:

* Monthly calendar
* Mood table
* Bar chart

The calendar associates each mood entry with a normalized daily timestamp, allowing the application to correctly display moods on their corresponding days.

---

## 🎙️ Speech Emotion Recognition

Calm Capy includes an experimental voice-based emotion detection system that provides an alternative to manually selecting a mood.

### Pipeline

```text
Microphone
    │
    ▼
AVAudioEngine
    │
    ▼
Audio Buffer
    │
    ▼
SNAudioStreamAnalyzer
    │
    ▼
Core ML Audio Classifier
    │
    ▼
Emotion Prediction
    │
    ▼
Mood Entry
```

The model was trained using **Create ML** with publicly available emotional speech datasets:

* Toronto Emotional Speech Set (TESS)
* Crowd-sourced Emotional Multimodal Actors Dataset (CREMA-D)
* Surrey Audio-Visual Expressed Emotion (SAVEE)

The classifier recognizes five emotional categories and achieved over 90% accuracy during my testing.

The model runs locally using Apple's machine-learning and audio frameworks rather than requiring a server request for inference.

Because speech emotion recognition can be affected by differences in speakers, microphones, background noise, and speaking styles, this feature is treated as experimental rather than diagnostic.

---

# 🤖 Gemini AI Chatbot

One of the major components of Calm Capy is an AI chatbot designed to provide conversational support and make the application feel more personalized.

The chatbot uses **Google Gemini** to generate context-aware responses based on the user's conversation.

### Architecture

```text
User
 │
 ▼
SwiftUI Chat Interface
 │
 ▼
Chat ViewModel
 │
 ▼
Firebase / Backend Layer
 │
 ▼
Gemini API
 │
 ▼
Generated Response
 │
 ▼
SwiftUI Chat Interface
```

The Gemini integration allows Calm Capy to move beyond static responses and provide dynamic conversations.

I designed the integration so that API credentials are not hard-coded directly into the client application.

### Why Gemini?

A rule-based chatbot would require manually creating responses for every possible conversation. Gemini allows the application to generate responses dynamically and makes the interaction much more flexible.

The chatbot was also designed as an **optional feature** rather than the sole purpose of the application. Users can still use the mood tracker, breathing exercise, journal, and statistics without interacting with the AI.

---

# 🔥 Firebase Architecture

Firebase provides the backend infrastructure for Calm Capy.

### Firebase technologies

| Technology              | Purpose                              |
| ----------------------- | ------------------------------------ |
| FirebaseCore            | Firebase initialization              |
| Firebase Authentication | User registration and authentication |
| FirebaseFirestore       | Persistent application data          |
| FirebaseFirestoreSwift  | Swift/Firestore integration          |

User-specific data is associated with authenticated accounts.

Conceptually:

```text
                    Calm Capy
                        │
              ┌─────────┴─────────┐
              │                   │
       Authentication         Application
              │                   │
              ▼                   ▼
        Firebase Auth        ViewModels
                                  │
                    ┌─────────────┼─────────────┐
                    │             │             │
                    ▼             ▼             ▼
                  Moods        Journals      User Data
                    │             │             │
                    └─────────────┼─────────────┘
                                  ▼
                             Firestore
```

This architecture allows users to maintain separate mood and journal data.

Firestore also provides local caching/offline behavior, allowing the application to remain responsive when network connectivity is unavailable and synchronize data when connectivity returns.

---

# 📓 Journaling

Users can create, edit, and review private journal entries.

Each entry contains information such as:

* Title
* Content
* Timestamp

Journal functionality is implemented using SwiftUI views and a dedicated view model, while Firestore handles persistence.

The architecture separates UI state from data-management logic, making it easier to modify or extend the journal functionality independently.

---

# 🌬️ Guided Breathing

Calm Capy includes a custom breathing exercise based on the **4-7-8 breathing technique**.

A hand-drawn capybara is incorporated into the animation to provide visual pacing:

```text
        Inhale
          ↓
     ┌──────────┐
     │          │
     │  🦫      │
     │  Expand  │
     │          │
     └──────────┘
          │
       Hold
          │
          ▼
        Exhale
```

The animation was implemented using SwiftUI rather than relying on a third-party animation library.

---

# 📈 Statistics

The statistics screen transforms raw mood entries into visual information that users can understand quickly.

It includes:

* Calendar-based mood history
* Mood counts
* Tabular data
* Bar charts

The **Charts** framework is used for data visualization.

The interface is designed so that the same underlying data can be represented in several ways depending on what the user wants to understand.

---

# 🎨 UI / UX

I designed the interface around three principles:

### 1. Low cognitive load

The application uses simple navigation and focused screens so users do not have to work through a complicated interface to access a feature.

### 2. Approachable visual design

I created the capybara illustrations myself and incorporated them throughout the application.

The visual system uses muted colors, rounded components, and simple layouts to create a calm and consistent interface.

### 3. User control

AI and machine-learning features are optional. Users can manually record their mood instead of relying on the speech classifier, and the core self-care tools remain usable without the chatbot.

---

# 🏗️ Project Architecture

A simplified project structure:

```text
Calm-Capy/
│
├── App/
│   └── Calm_CapyApp.swift
│
├── Views/
│   ├── ContentView.swift
│   ├── MoodCalendarView.swift
│   ├── MoodView.swift
│   ├── StatisticsView.swift
│   ├── JournalView.swift
│   ├── ChatView.swift
│   ├── BreathingView.swift
│   └── ...
│
├── ViewModels/
│   ├── MoodViewModel.swift
│   ├── JournalViewModel.swift
│   ├── ChatViewModel.swift
│   └── AudioClassifierViewModel.swift
│
├── Models/
│   ├── Mood.swift
│   ├── JournalEntry.swift
│   └── ...
│
├── ML/
│   └── MoodClassifier.mlmodel
│
├── Services/
│   ├── FirebaseService.swift
│   ├── GeminiService.swift
│   └── ...
│
└── Assets/
    ├── Capybara illustrations
    ├── App icons
    └── Color assets
```

The actual organization may differ depending on the current version of the repository.

---

# 🧠 Engineering Challenges

## Calendar Data Modeling

One of the most significant bugs I encountered involved the mood calendar.

Initially, I grouped mood information by month. While this worked for aggregate statistics, it made it impossible to reliably associate individual mood data with a specific calendar day.

I eventually traced the problem to the way timestamps were being stored and compared.

I changed the data model so mood entries were normalized to the beginning of their corresponding day. This allowed calendar queries to reliably compare `Date` values and associate each mood with the correct day.

This was an important lesson in designing data structures around **how information will actually be queried**, rather than only how it is initially stored.

---

## Audio Processing

The audio classifier required continuously processing microphone input without blocking the UI.

Audio buffers are passed through an analysis queue before being processed by SoundAnalysis.

```text
Main Thread
    │
    ├── SwiftUI updates
    │
    └── User interaction

Analysis Queue
    │
    ├── Audio buffers
    ├── SoundAnalysis
    └── ML inference
```

Separating audio processing from UI updates helps keep the interface responsive while classification is occurring.

---

## Firebase Integration

I encountered several issues while integrating Firebase, including authentication, Firestore data modeling, timestamp queries, and configuration.

Working through these issues required understanding how the Firebase SDK interacts with Swift's data types and asynchronous operations rather than treating Firebase as a black box.

---

## Gemini API Integration

Integrating a generative AI API introduced a different class of engineering challenges.

Unlike a static local model, the chatbot depends on:

* API authentication
* Network requests
* Request/response handling
* Asynchronous execution
* Error handling
* Prompt construction
* API usage limitations
* Protecting credentials

I used a backend-oriented architecture rather than exposing sensitive API credentials directly in the application's source code.

---

# 🧰 Technology Stack

### Frontend

* Swift
* SwiftUI
* Charts

### Backend

* Firebase Authentication
* Firebase Firestore
* FirebaseCore
* FirebaseFirestoreSwift

### Machine Learning

* Create ML
* Core ML
* SoundAnalysis
* AVFoundation

### Generative AI

* Google Gemini API

### Development

* Xcode
* Git
* GitHub

---

# 🤖 AI-Assisted Development

AI tools, including ChatGPT, were used during development as programming assistants.

I primarily used AI to:

* Debug difficult Swift errors
* Understand unfamiliar framework APIs
* Troubleshoot Firebase integration
* Investigate SoundAnalysis and audio-processing issues
* Explore possible implementations
* Diagnose bugs after attempting my own solutions

AI-generated code was reviewed, adapted, tested, and integrated into the project. I remained responsible for the application's architecture, UI/UX decisions, feature implementation, debugging, and final code.

The project demonstrates my ability to use AI as a development tool while still understanding and validating the resulting implementation.

---

# 🔐 Privacy & Security Considerations

Because Calm Capy handles potentially sensitive information, privacy was an important design consideration.

The application:

* Separates user data through authentication.
* Stores user-specific mood and journal information in Firestore.
* Performs speech emotion inference locally using Core ML.
* Avoids embedding Gemini API credentials directly in the client.
* Provides the core application functionality independently of the AI chatbot.

For a production application, additional security measures and professional privacy review would be necessary.

---

# 🚧 Future Development

There are several directions I would explore in a future version.

### More personalized AI

The chatbot could optionally use recent mood trends and journal sentiment to provide more context-aware conversations, with explicit user consent.

### Improved emotion recognition

The audio model could be retrained using a larger and more diverse dataset and evaluated against speakers and recording conditions that were not present during training.

### On-device intelligence

More AI functionality could be moved on-device to reduce network dependence and improve privacy.

### Accessibility

Future versions could include more extensive Dynamic Type support, VoiceOver testing, improved contrast options, and more adaptive layouts.

### Analytics

Mood, journal, and activity data could be combined into privacy-preserving trend analysis to help users identify patterns over time.

---

# 📚 Third-Party Software & Data

Calm Capy uses third-party frameworks, services, APIs, and datasets.

Major dependencies include:

* Firebase
* Google Gemini API
* Apple's AVFoundation
* Apple's SoundAnalysis
* Apple's Core ML
* Apple's Charts
* Public emotional speech datasets used for ML training

See the repository's license/attribution documentation for the applicable licenses and acknowledgments.

---

# 👩‍💻 About the Project

Calm Capy began as an exploration of how technology could make mental wellness tools more approachable.

Over time, it evolved into a larger engineering project involving:

**SwiftUI → Firebase → machine learning → audio processing → generative AI**

Rather than building each feature independently, I used the project to explore how different parts of a modern software stack interact—from frontend state management and cloud databases to local ML inference and external AI services.

## Author

**Cici Xing**

Interested in:

* Software Engineering
* Human-Computer Interaction
* Artificial Intelligence
* Machine Learning
* Mobile Development
* Accessible Technology
