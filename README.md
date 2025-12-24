# Flutter Clean MVVM Template

🚀 **Production-ready Flutter starter template built with Clean Architecture + MVVM**

[![Flutter](https://img.shields.io/badge/Flutter-3.7+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📌 Overview

This template demonstrates **professional Flutter development** with:

- ✅ **Clean Architecture** + **MVVM Pattern**
- ✅ **Repository Pattern** (via Service Layer)
- ✅ **Dependency Injection** (GetIt)
- ✅ **State Management** (Provider)
- ✅ **Error Handling** & Network Management
- ✅ **Unit & Widget Tests** Setup
- ✅ **Material 3** with Light/Dark Theme Support

## 🏗️ Architecture

### MVVM Hierarchy

```
Screen (StatefulWidget)
    ↓
BaseView (Loading wrapper + State Management)
    ↓
ViewModel (Business Logic + State Management)
    ↓
Service (API calls + Data operations)
    ↓
NetworkService (HTTP operations)
```

### Folder Structure

```
lib/
├── core/                      # Core/Base structures
│   ├── constants/            # AppColors, AppSizes, AppTheme, etc.
│   ├── enums/                # ViewState, RequestType
│   ├── models/               # ServiceResponse, NetworkResponseModel
│   ├── services/             # NetworkService (Singleton)
│   ├── viewmodels/           # BaseViewModel
│   ├── views/                # BaseView
│   └── di/                   # Dependency Injection
│
├── screens/                   # Feature-based screens
│   └── [feature_name]/
│       ├── [feature]_screen.dart
│       ├── [feature]_service.dart
│       ├── viewmodels/
│       │   └── [feature]_view_model.dart
│       └── views/
│           └── [feature]_view.dart
│
├── domain/                    # Data layer
│   ├── dtos/                 # Data Transfer Objects
│   ├── enums/                # Domain enums
│   └── models/               # Domain models (BaseModel)
│
├── common_widgets/            # Reusable widgets
│   ├── button_widget.dart
│   ├── text_field_widget.dart
│   └── alert_dialog_widget.dart
│
├── utils/                     # Utilities
│   ├── extensions/           # Context, String, Widget extensions
│   ├── navigation_util.dart
│   ├── network_config.dart
│   ├── network_urls.dart
│   ├── shared_preferences_util.dart
│   └── validators_util.dart
│
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7+
- Dart SDK 3.7+

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_clean_mvvm_template
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 📚 Key Features

### 1. BaseViewModel

All ViewModels extend `BaseViewModel` which provides:

- **ViewState Management**: `initial`, `loading`, `completed`, `error`
- **Automatic Loading**: `init()` method called automatically
- **State Updates**: `reloadState()` for UI updates
- **Error Handling**: Built-in error state management

```dart
class ProductListViewModel extends BaseViewModel {
  @override
  FutureOr<void> init() async {
    await loadProducts();
  }
  
  Future<void> loadProducts() async {
    isLoading = true;
    // ... API call
    isLoading = false;
  }
}
```

### 2. BaseView

Automatic loading state management:

```dart
BaseView<ProductListViewModel>(
  vmBuilder: (_) => ProductListViewModel(service: ProductListService()),
  builder: (context, viewModel) => ProductListView(viewModel: viewModel),
)
```

### 3. Network Layer

- **Singleton NetworkService** with Dio
- **Request/Response Models**
- **Centralized URL Management**
- **Environment Configuration** (Dev/Staging/Prod)

### 4. Constants & Theme

- **AppColors**: Centralized color management
- **AppSizes**: Responsive sizing with ScreenUtil
- **AppTheme**: Material 3 light/dark themes
- **AppEdgeInsets**: Responsive padding/margin
- **AppBorderRadius**: Consistent border radius

### 5. Common Widgets

- **ButtonWidget**: Customizable button with loading state
- **TextFieldWidget**: Form-ready text field
- **AlertDialogWidget**: Success/Error/Confirmation dialogs

### 6. Extensions

- **BuildContext**: Navigation, snackbar, theme shortcuts
- **String**: Email/phone validation, capitalization
- **Widget**: Padding, sizing, visibility helpers

---

## 🧪 Testing

### Unit Tests

Test ViewModels and business logic:

```bash
flutter test test/unit/
```

### Widget Tests

Test UI components:

```bash
flutter test test/widget/
```

### Integration Tests

Test full feature flows:

```bash
flutter test test/integration/
```

---

## 📝 Usage Example

### Creating a New Feature

1. **Create Service** (`lib/screens/my_feature/my_feature_service.dart`)

```dart
class MyFeatureService {
  Future<NetworkResponseModel> getData() async {
    var url = NetworkUrls().myFeatureUrl;
    var response = await NetworkService.instance.makeRequest(
      url,
      type: RequestType.get,
    );
    return response;
  }
}
```

2. **Create ViewModel** (`lib/screens/my_feature/viewmodels/my_feature_view_model.dart`)

```dart
class MyFeatureViewModel extends BaseViewModel {
  final MyFeatureService service;
  
  MyFeatureViewModel({required this.service});
  
  @override
  FutureOr<void> init() async {
    await loadData();
  }
  
  Future<void> loadData() async {
    isLoading = true;
    var response = await service.getData();
    // Handle response
    isLoading = false;
  }
}
```

3. **Create View** (`lib/screens/my_feature/views/my_feature_view.dart`)

```dart
class MyFeatureView extends StatelessWidget {
  final MyFeatureViewModel viewModel;
  
  const MyFeatureView({required this.viewModel});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Your UI here
      ],
    );
  }
}
```

4. **Create Screen** (`lib/screens/my_feature/my_feature_screen.dart`)

```dart
class MyFeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Feature')),
      body: BaseView<MyFeatureViewModel>(
        vmBuilder: (_) => MyFeatureViewModel(
          service: MyFeatureService(),
        ),
        builder: (context, viewModel) => MyFeatureView(
          viewModel: viewModel,
        ),
      ),
    );
  }
}
```

---

## 🎨 Theming

The app supports **Material 3** with automatic light/dark theme switching:

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
  // ...
)
```

---

## 🔧 Configuration

### Environment Setup

Configure API environments in `lib/utils/network_config.dart`:

```dart
NetworkConfig.setEnvironment(Environment.dev); // or staging, prod
```

### SharedPreferences

Access local storage via `SharedPreferencesUtil`:

```dart
// Save token
await SharedPreferencesUtil.instance.setToken('your-token');

// Get token
String? token = SharedPreferencesUtil.instance.getToken();
```

---

## 📦 Dependencies

### Core Packages

- **provider**: State management
- **get_it**: Dependency injection
- **dio**: HTTP client
- **flutter_screenutil**: Responsive design
- **shared_preferences**: Local storage

### Dev Packages

- **flutter_test**: Testing framework
- **mockito**: Mocking for tests
- **build_runner**: Code generation

---

## 🏆 Best Practices

1. **Always extend BaseViewModel** for ViewModels
2. **Use BaseView** for automatic loading state
3. **Service layer** for API calls only
4. **DTOs** for API request/response
5. **Constants** for all hardcoded values
6. **Extensions** for reusable code
7. **Test coverage** for ViewModels and widgets

---

## 🤝 Contributing

Contributions are welcome! Please follow the existing code style and architecture patterns.

---

## 📄 License

This project is licensed under the MIT License.

---

## 🙏 Acknowledgments

## 📧 Contact

For questions or suggestions, please open an issue or create a pull request.

---

**⭐ If you find this template useful, please give it a star!**
