# EasyCartApp

EasyCartApp is an iOS application designed to provide a seamless shopping experience. The app is structured using the MVVM (Model-View-ViewModel) architecture pattern, ensuring scalability and maintainability.

## Features
- **Category Browsing**: View and explore product categories.
- **Home Screen**: Displays featured products and categories.
- **Item Details**: Detailed view of individual products.
- **Reusable Components**: Custom UI components for consistent design.
- **Error Handling**: Graceful handling of network and API errors.
- **Offline Support**: Displays appropriate messages when offline.

## Project Structure
The project is organized into the following layers:

### 1. **AppBase**
- `AppDelegate.swift`: Handles app lifecycle events.
- `SceneDelegate.swift`: Manages scene lifecycle and initializes the app's root coordinator.

### 2. **AppUtility**
- `AppConstants.swift`: Contains static constants used throughout the app.
- `CustomError.swift`: Defines custom error types for better error handling.
- `DataLoadState.swift`: Represents the state of data loading (e.g., loading, success, error).
- `String+Extensions.swift`: String utilities and extensions.

### 3. **Data Layer**
- `DataSources/NetworkManager.swift`: Handles network requests.
- `MockData/MockData.json`: Contains mock data for testing.

### 4. **Domain Layer**
- `Entities/NetworkResponseModel.swift`: Models for API responses.
- `Workers/NetworkingManager.swift`: Manages network operations.

### 5. **Presentation Layer**
#### Coordinators
- **Assembly**: Contains `Assembly.swift` and `BaseAssembly.swift` for dependency injection.
- **BaseCoordinator**: Base classes for coordinators.
- **CategoryCoordinator**: Manages navigation for the Categories screen.
- **HomeCoordinator**: Manages navigation for the Home screen.

#### Screens
- **Categories**: `CategoriesViewController.swift` and `CategoriesViewModel.swift`.
- **Home**: `HomeViewController.swift` and `HomeViewModel.swift`.
- **ItemDetail**: `ItemDetailViewController.swift`.
- **ReusableComponent**: Custom UI components like `CustomImageView`, `CustomTableCell`, and `ProductItemView`.

### 6. **Resources**
- `Assets.xcassets`: Contains app icons and other assets.

## Getting Started
### Prerequisites
- Xcode 13.0 or later
- iOS 15.0 or later

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Open the project in Xcode:
   ```bash
   open EasyCartApp.xcodeproj
   ```
3. Build and run the app on a simulator or device.

## Authors
- **Shivam Gupta**

## License
This project is licensed under the MIT License. See the LICENSE file for details.
