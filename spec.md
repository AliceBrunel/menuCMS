# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
-------- Using Sinatra to set up routes
- [x] Use ActiveRecord for storing information in a database
-------- Using ActiveRecord to link the application and the database db/development.sqlite
- [x] Include more than one model class (e.g. User, Post, Category)
-------- The Model Classes are User, Menu, Meal, and a the model for the join between Menu and Meal
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
-------- There are several has_many relationships. A user can have many Menus and many Meals.
-------- A Menu is composed of many meals.
-------- A Meal can be part of many different menus.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
-------- Meal and Menu belong to User.
- [x] Include user accounts with unique login attribute (username or email)
-------- When creating a user, the application will refuse to create a new user if the username or the email is already in the database.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
-------- While it is not possible to delete a user, the Menu and Meal resources can be created, read, updated and destroyed. These functionalities are implemented in each resource's controller.
- [x] Ensure that users can't modify content created by other users
-------- The application controllers will not allow a user to modify other users' resource, and the UI simply doesn't show these possibilies when they are not necessary.
- [x] Include user input validations
-------- In forms and within the controllers, with the use of Flash messages, the input are validated only if they are right, otherwise the application will redirect the user to another page or print out a flash message. In some form, required input are also constrained in the HTML form. For forms using the parameters of an input as a slug URL, ASCII caracters are delete within the slug method.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
-------- The user gets a failing message when the surname or email in the registering form for users already exists.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code


Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
