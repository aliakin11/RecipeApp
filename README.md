# RecipeApp - Modern iOS Development Showcase 📱

## Proje Vizyonu
Modern iOS geliştirme pratiklerini ve endüstri standartlarını uygulayarak geliştirdiğim kapsamlı bir yemek tarifi uygulaması. Bu proje, MVVM mimarisi, SOLID prensipler ve en güncel iOS teknolojilerini kullanarak geliştirilmiştir.

### Temel Teknolojiler ve Yaklaşımlar
- **MVVM Architecture**
- **%100 Programmatic UI**
- **Protocol-Oriented Programming**
- **iOS 13.0+ Support**
- **CoreData Integration**
- **RESTful API Integration**

## Teknik Detaylar ve Implementasyon 🛠

### 1. Modern iOS Development Practices
- **Swift 5**
  - Protocol-Oriented Programming (POP)
  - Value & Reference Types
  - Modern Swift Features (Result type, Codable)
  - Advanced Error Handling
  
- **Architectural Approach**
  - SOLID Principles
  - Dependency Injection
  - Interface Segregation
  - Single Responsibility
  - Modular Design

### 2. MVVM Implementation
```swift
final class RecipeViewModel {
    private let recipeService: RecipeServiceProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    init(
        recipeService: RecipeServiceProtocol = RecipeService(),
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.recipeService = recipeService
        self.coreDataManager = coreDataManager
    }
}
```

### 3. Network Layer
```swift
// Generic & Protocol-Based Network Layer
protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}
```
- Type-safe network katmanı
- Generic response handling
- Custom error types
- RESTful API entegrasyonu

### 4. Persistence Layer (CoreData)
```swift
// Protocol-Based CoreData Implementation
protocol CoreDataManagerProtocol {
    func addFavorite(meal: Meal)
    func removeFavorite(mealID: String)
    func fetchFavorites() -> [Meal]
    func isFavorite(mealID: String) -> Bool
}
```
- Thread-safe data management
- CRUD operations
- Efficient data persistence
- Memory management

### 5. UI/UX Implementation
- **Modern UI Practices**
  - Programmatic Auto Layout
  - Custom Components
  - Reusable Views
  - Dark Mode Support
  - Responsive Design

## Proje Yapısı ve Organizasyon 📁

```
RecipeApp/
├── App/
│   └── [Application Lifecycle]
├── Core/
│   ├── Network/
│   │   ├── Manager
│   │   ├── Models
│   │   └── Protocols
│   └── CoreData/
│       ├── Manager
│       └── Entities
├── Features/
│   ├── Categories/
│   │   ├── View
│   │   ├── ViewModel
│   │   └── Model
│   ├── RecipeDetail/
│   └── Favorites/
├── Common/
│   ├── Extensions
│   ├── Protocols
│   └── Utilities
└── Resources/
```

## Teknik Kazanımlar 

### Uygulanan Best Practices
- ✅ SOLID Principles
- ✅ MVVM Architecture
- ✅ Protocol-Oriented Programming
- ✅ Dependency Injection
- ✅ Unit Testable Code
- ✅ Memory Management
- ✅ Thread Safety

### Kullanılan Design Patterns
-  MVVM
-  Dependency Injection
-  Protocol-Delegate Pattern
-  Singleton (CoreData Manager)

## Geliştirme Ortamı ve Araçlar

- **IDE**: Xcode 14+
- **Dil**: Swift 5
- **Minimum iOS**: 13.0
- **Dependency Management**: SPM
- **Version Control**: Git & GitHub
- **API**: RESTful (TheMealDB)

https://github.com/user-attachments/assets/c1c71650-3427-4f6f-b03f-b41716895dd3
