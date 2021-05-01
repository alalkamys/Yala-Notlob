# :sparkles: Yala Notlob

[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com) 

Yala Notlob is an Online ordering System where you can make groups of your friends and invite them to order a meal from a certain restaurant using Ruby On Rails


## Features

* Login and signup using Google authentication.
* Add your friends by their Emails.
* Create groups with your.
* Make orders with your chosen menu.
* Invite your friends to your order.
* Get activity notifications.


## Screenshots

### Add your friends and assign them to your group
  ![terminal screenshot](https://raw.githubusercontent.com/ShehabEl-DeenAlalkamy/Yala-Notlob/master/friends.gif)
  
### Create your orders  
  ![terminal screenshot](https://raw.githubusercontent.com/ShehabEl-DeenAlalkamy/Yala-Notlob/master/createOrder.gif)
  
 
## Prerequisites  

Install ruby version 2.6.6
 ```sh
    rvm install ruby-2.6.6
 ```
 ```sh
    rvm use 2.6.6 --default
 ```
reboot your system 
 ```sh
    init 6
 ```

Install rails version 6.1.3
 ```sh
    gem install rails -v 6.1.3.1
 ```

## Getting Started

After cloning the repository:

 ```sh
    cd Yala-Notlob/
 ```

 ```sh
    bundle install
 ```
 
 ```sh
    rails db:migrate
 ```
 
 ```sh
    apt install -y redis-server
 ```

 ```sh
    yarn add bootstrap-icons
 ```
 
 ```sh
    rails s
 ```
 
Using docker :

 ```sh
   docker-compose build --build-arg facebook_id=FACEBOOK_APP_ID \
                        --build-arg facebook_secret=YOUR_FACEBOOK_APP_SECRET \
                        --build-arg google_id=YOUR_GOOGLE_APP_ID  \
                        --build-arg google_secret=YOUR_GOOGLE_APP_SECRET
 ```

Now you can open the project from your browser http://127.0.0.1:3000/


## Contributors

* [Shehab El-Deen Alalkamy](https://github.com/ShehabEl-DeenAlalkamy)
* [Mohab Rabie](https://github.com/mohabrabie)
* [Mostafa Moawad](https://github.com/Mostafa-Moawad)
* [Ibrahim Magdy](https://github.com/ebrahimmagdy)
* [Ahmed Samy](https://github.com/Ahmedsamymahrous)
