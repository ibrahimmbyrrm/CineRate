# 🎬CineRate
CineRate is an application that presents movies to you in specific categories, providing detailed information about the movies you desire. It allows you to view and leave comments related to the movies from other users. All you need to do is create an account and access a wide range of high-quality films.

In terms of technical implementation, I utilized the MVVM (Model-View-ViewModel) architecture in the project. Additionally, I employed advanced techniques such as protocol-oriented programming, SOLID principles, modularity, and testability. User authentication and registration are handled by Firebase Authentication, enabling easy account creation and login.

On the main screen, you will find categorized movie listings at the top. Depending on the selected category, movies are fetched from the API. You can explore other categories as well. Anticipating that users will be constantly on the move within the application, I implemented a caching mechanism. Once the data is fetched from the API, it is cached and reused when returning to the same page, eliminating unnecessary API calls and instantly displaying the cached data. This mechanism is consistent across all screens of the application.

When you navigate to the movie details and wish to read the comments, the comments are retrieved from the database using FirebaseFirestoreService based on the selected movie's ID. Similarly, when you want to leave a comment, your comment is easily saved in the database.

🛠️ -> MVVM (Model-View-ViewModel) Architecture
<br><br>
⚡️ -> Caching Mechanism to get rid of repetitive API calls
<br><br>
🛜 -> Generic Network Layer to decrease code repeat
<br><br>
🤝 -> Protocol Oriented Programming
<br><br>
🌅 -> SDWebImage Framework
<br><br>
👨🏻‍💻 -> Programmatic UI Design and Constraints
<br><br>
👍🏻 -> Singleton Service Instances
<br><br>
🏴‍☠️ -> Custom Views (MCAlert, MCLabel) to decrease code repeat.
<br><br>
🧩 -> Modular and Testable Architect
<br>
<img width="384" alt="Ekran Resmi 2023-06-11 17 49 30" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/ab8cb4c6-e94e-4934-bea2-c327c8f8c32f">
<img width="384" alt="Ekran Resmi 2023-06-11 17 49 33" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/89df93c9-703d-481e-aee9-9edc528824dd">
<img width="384" alt="Ekran Resmi 2023-06-11 17 49 37" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/1d9d0902-a462-4052-a7fb-5308bc392e1d">
<img width="384" alt="Ekran Resmi 2023-06-11 17 49 41" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/1c7537be-fa58-44f9-9e0a-ed34dd657b89">
<img width="384" alt="Ekran Resmi 2023-06-11 17 50 01" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/e8e8eabb-92d7-4e63-b2ca-875a198bc87f">
<img width="384" alt="Ekran Resmi 2023-06-11 17 50 09" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/e4015224-bd3e-4d45-9703-bd6c510400f7">
<img width="384" alt="Ekran Resmi 2023-06-11 17 50 13" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/357547ee-2ca8-48ec-b054-dabc343584f2">
<img width="384" alt="Ekran Resmi 2023-06-11 17 50 17" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/5b40cdec-88e0-46ff-912e-577925f5b0b1">
<img width="384" alt="Ekran Resmi 2023-06-11 17 50 29" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/677af8e0-301f-46d1-9dcb-52a7c767384d">
<img width="384" alt="Ekran Resmi 2023-06-11 17 50 33" src="https://github.com/ibrahimmbyrrm/CineRate/assets/96320314/1384f2d6-a9d9-4096-9822-0eda520dc1cf">



