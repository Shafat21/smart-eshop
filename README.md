# Smart EShop

A mini e‑commerce Flutter app demonstrating state management with Provider, persistence with SharedPreferences, theme toggling, navigation, RESTful API integration (FakeStore API) and a polished UI with glassy cards, blur effects, and slide‑to‑pay checkout.

---

## 🚀 Features

- **Splash Screen**: Automatically checks login status and routes accordingly.  
- **Authentication**  
  - Registration (Name, Address, Phone, Email, Username, Password)  
  - Login (with Demo‑login button)  
  - Persistent login state via SharedPreferences  
- **Home**  
  - Search products in real time  
  - Filter & sort: price ↑/↓, rating ↑/↓, max‑price slider  
  - Category carousel for quick filtering  
  - “New Arrival” horizontal product slider + “See All” auto‑scroll  
  - “All Products” full grid view  
- **Product Detail**  
  - Large product image with custom back/favorite buttons  
  - Details card: title, price, description, selectable colors  
  - Add to Favorites & Add to Cart  
- **Cart**  
  - Grouped items with quantity controls  
  - Subtotal display  
  - “Checkout” button  
- **Checkout**  
  - Select delivery address (Home/Office)  
  - Billing breakdown (delivery fee, subtotal, total)  
  - Payment method icons  
  - Slide‑to‑pay confirmation  
- **Favourites**  
  - Grid of saved products  
  - Pull‑to‑refresh  
- **Profile**  
  - Display username & toggle Dark/Light mode  
- **App Drawer & Bottom Navigation**  
  - Side menu with user initials, routes, logout, and logo  
  - Persistent bottom nav bar for Home, Cart, Favourites, Profile  
- **Theming**  
  - Dark/light toggle saved in SharedPreferences  
  - Glassy cards & blur effects throughout UI  

---

## 📸 Screenshots

| Splash Screen | Register Screen | Login Screen | Home Screen |
|:-------------:|:---------------:|:------------:|:-----------:|
| ![](https://i.postimg.cc/ZKThnYTQ/Screenshot-1753037352.png) | ![](https://i.postimg.cc/NjFq8N27/Screenshot-1753037361.png) | ![](https://i.postimg.cc/wjrKwhhK/Screenshot-1753037367.png) | ![](https://i.postimg.cc/nzv6VgNZ/Screenshot-1753037372.png) |

| Search | Filter & Sort | Category | App Drawer |
|:------:|:-------------:|:--------:|:----------:|
| ![](https://i.postimg.cc/Bb4RjNGF/Screenshot-1753037376.png) | ![](https://i.postimg.cc/Y9c5HMnb/Screenshot-1753037378.png) | ![](https://i.postimg.cc/NFxqDSxb/Screenshot-1753037388.png) | ![](https://i.postimg.cc/FKfvvP9s/Screenshot-1753037392.png) |

| Profile | Cart | Checkout | Favourites |
|:-------:|:----:|:--------:|:----------:|
| ![](https://i.postimg.cc/5tZV2w05/Screenshot-1753037395.png) | ![](https://i.postimg.cc/vBfdgcgJ/Screenshot-1753037416.png) | ![](https://i.postimg.cc/yxKCFs0k/Screenshot-1753037418.png) | ![](https://i.postimg.cc/T2j6T5Xm/Screenshot-1753037426.png) |

| Product Detail |
|:--------------:|
| ![](https://i.postimg.cc/k5R0zBc2/Screenshot-1753037428.png) |

---

## 🎥 Demo Video

<div style="position: relative; padding-bottom: 56.25%; height: 0;">
  <iframe
    id="js_video_iframe"
    src="https://jumpshare.com/embed/uhaK3ns1PYcVMC6UlCD7"
    frameborder="0"
    webkitallowfullscreen
    mozallowfullscreen
    allowfullscreen
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
  </iframe>
</div>

---
## 🛠 Installation

1. **Clone the repo:**  
   ```bash
    git clone https://github.com/shafat21/smart_eshop.git
    cd smart_eshop
    ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```
3. **Run on device/emulator:**

   ```bash
   flutter run
   ```

---

## ⚙️ Configuration

* **API**: Uses [FakeStore API](https://fakestoreapi.com).
* **Storage**: SharedPreferences for login state, favourites, and theme.
* **State Management**: Provider package.
* **Key Packages**:

  * `provider`
  * `shared_preferences`
  * `slide_to_act` (checkout slider)
  * `badges` (cart & favourite badges)

---

## 📂 Project Structure

```
lib/
├── main.dart
├── models/
│   ├── product.dart
│   └── user.dart
├── providers/
│   ├── auth_provider.dart
│   ├── cart_provider.dart
│   ├── product_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── home_screen.dart
│   ├── cart_screen.dart
│   ├── checkout_screen.dart
│   ├── favourites_screen.dart
│   ├── profile_screen.dart
│   └── product_detail_screen.dart
├── services/
│   ├── api_service.dart
│   └── auth_service.dart
├── utils/
│   ├── shared_prefs.dart
│   └── constants.dart
└── widgets/
    ├── app_bottom_nav_bar.dart
    ├── app_drawer.dart
    ├── badge_icon.dart
    ├── category_carousel.dart
    ├── filter_button.dart
    ├── glassy_text_field.dart
    └── product_card.dart
```

---

## 🤝 Contributing

Feel free to open issues or submit PRs to add new features, improve UI/UX, or optimize performance.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
