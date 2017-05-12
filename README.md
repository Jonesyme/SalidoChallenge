# SalidoChallenge
iOS Coding Challenge
Author: Mike Jones

## Update: May 12, 2017
Requested changes committed to the "ShoppingCart" branch.  Shopping Cart functionality is now fully working - including the ability to increment/decrement item quantities from the search screen and the shopping cart screen.  Category filters are also working and the results are pre-sorted by product name.  NOTE: I made the ShoppingCart a singleton for simplicity purposes.  In a production app I would generally try to avoid the use of singletons if possible and retain references to the object only by those views that require it. Just FYI - I'm generally not a big proponent of singletons...  

## Compilation Notes
- Compiles on: XCode 8.3.2
- Language: Objective-C
- Target Device Family: iPad Only
- Target Orientation: Landscape Only
- Target OS: iOS 10.3

## What Features are Working
- Almost all the Employee Account/PIN features
    - Create account
    - Search accounts
    - Login with PIN
- The Wine Search and Filter Screen
    - Tap filter button to filter by any Category using slide-out menu
    - Use the search bar to query wines via text
- The Shopping Cart screen

## Whats Not fully complete
- Sorting/paging of search results
- Query employee PIN via email
- Unit Tests

## 3rd Party Libraries Used
- JSONJoy for mapping data models to JSON responses
- SWRevealViewController for slide-out master-detail like view hierarchy on search screen


