# test_three

A new Flutter project.

## Getting Started

lib/
├─ core/                            # Common utilities, constants, themes, and shared services
├─ features/
│  ├─ auth/                         # Authentication feature
│  │   ├─ domain/                   # Business logic
│  │   ├─ data/                     # AuthProvider implementations (e.g., Google, Email)
│  │   ├─ presentation/             # UI and state management for authentication (e.g., Sign In page)
│  │   └─ auth_di.dart              # DI setup for auth feature
│  ├─ payments/                     # Payment processing feature
│  │   ├─ domain/                   # Business logic
│  │   ├─ data/                     # Momo, PayPal, other gateway SDK
│  │   ├─ presentation/             # UI and state management for payments (e.g., Payment page)
│  │   └─ payments_di.dart          # DI setup for payment feature
│  └─ notification/                 # Notification (third-party integration)
│      ├─ domain/                   # Business logic
│      ├─ data/                     # Email, SMS, or other notification service
│      ├─ presentation/             # Notification-related UI
│      └─ notification_di.dart      # DI setup for notification feature
└─ main.dart                        # App entry point with app DI (from DI features) setup