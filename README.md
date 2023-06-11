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
