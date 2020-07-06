<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
![Hireable](https://cdn.rawgit.com/hiendv/hireable/master/styles/default/yes.svg)

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/euqueme/tracker-api">
    <img src="https://raw.githubusercontent.com/euqueme/toy-app/master/app/assets/images/mLogo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Exercise Tracker API Final Capstone project</h3>

  <p align="center">
    This project is part of the Microverse Ruby on Rails curriculum!
    <br />
    <a href="https://github.com/euqueme/tracker-api"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/euqueme/tracker-api/issues">Report Bug</a>
    ·
    <a href="https://github.com/euqueme/tracker-api/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Documentation](#documentation)
  * [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Setup](#setup)
  * [Usage](#usage)
  * [Run Test](#run-test)
  * [Deployment](#deployment)
  * [Built With](#built-with)
* [Authors](#authors)
* [Contributing](#contributing)
* [Show your support](#show-support)
* [Acknowledgements](#acknowledgements)
* [License](#license)

<!-- ABOUT THE PROJECT -->
## About The Project

[![asciicast][product-screenshot]](https://www.loom.com/share/1fa671b5e0584f3f82b0c27e9640cc54)

This is a tracker API, and has been given an individual theme to keep track of workout measurements of the login users, also only the administrator users can manage the exercises.

This is the final Capstone project of the Microverse Curriculum.

### Documentation

Watch the walkthrough video to see how to use it in your computer

https://www.loom.com/share/1fa671b5e0584f3f82b0c27e9640cc54

The documentation was built using raddocs and swagger

### Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7.0
Rails: 5.2.4

### Setup

Install gems with:

```
bundle install
```

Setup database with:

```
rails db:migrate
```

### Usage

Start server with:

```
rails server
```

Install the HTTP client of your preference to use it, I used [httpie](https://httpie.org/)

#### Signup

The following command will create an login a new user in the database

```bash
$ http :3000/signup name=maru email=maru@email.com password=foobar password_confirmation=foobar
```

![screenshot](app/assets/images/signup.png)

#### Login

Users Log in with their email and password

```bash
$ http :3000/login email=maru@email.com password=foobar
```

![screenshot](app/assets/images/login.png)

#### Create Exercise

to create a new Exercise you first have to create an admin user to do that you have to do the following:

Open a rails console and update the user you want to set as admin this way:

```bash
$ rails c
> User.find_by(email: 'maru@email.com').update(admin: true)
> exit
```
![screenshot](app/assets/images/user-admin.png)

After that you have to first login the user and copy the auth_token somewhere

```bash
$ http :3000/login email=maru@email.com password=foobar
```
![screenshot](app/assets/images/login-admin.png)

Finally we'll create a new exercise this way (paste the auth_token in the Authorization header)

```bash
$ http :3000/exercises name=Squats user_id=1 \
Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1OTEzMzMzOTl9.XLb1MX7E4293U6GzUi_lFxxBmAMcAZpcmapO7h8X92E'
```
![screenshot](app/assets/images/exercise-c.png)

#### Exercises index

To see all the exercises created in the database you don't need to be logged in just type the following command

```bash
$ http :3000/exercises
```
![screenshot](app/assets/images/exercises-index.png)

#### Exercises show

No authentication is needed to see an specific exercise

```bash
$ http :3000/exercises/2
```

![screenshot](app/assets/images/exercise-show.png)

#### Create Measurement 

To create a measurement an user has to be logged in and that user can only create his/her own measurement

Login the user (admin or not) and copy the auth_token somewhere
```bash
$ http :3000/login email=audrey@email.com password=123456
```
![screenshot](app/assets/images/measure-login.png)

Now we'll paste it in the Authentication header for creating measurement

```bash
$ http :3000/users/2/measurements description=Repetitions amount=10 exercise_id=1 \ Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTEzMzQ5MDJ9.fUepRH8o6Me08UUhK5ZlRIGGkUDssBTUvDE4a2dD7TE'
```
![screenshot](app/assets/images/measure-c.png)

#### All Measurements

To see all the measurements a user must be logged in and its only possible to see the measurements created by the logged in user, we'll use the same authentication as the step before

```bash
$ http :3000/users/2/measurements Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTEzMzQ5MDJ9.fUepRH8o6Me08UUhK5ZlRIGGkUDssBTUvDE4a2dD7TE'
```
![screenshot](app/assets/images/measure-all.png)

#### Show Measurement

Same as the step before only difference is we have to specify the measurement id just like we did in the Exercise one

```bash
$ http :3000/users/2/measurements/1 Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTEzMzQ5MDJ9.fUepRH8o6Me08UUhK5ZlRIGGkUDssBTUvDE4a2dD7TE'
```
![screenshot](app/assets/images/measure-show.png)

### Run tests

to run the test cases do:

```
rspec spec/ --exclude-pattern integration/*
```

to update the raddocs documentation run:

```
rake docs:generate
```

to update the swagger documentation run:

```
rake rswag:specs:swaggerize
```

- and go to localhost:3000/api_docs with your browser to get to the raddocs documentation
- or go to localhost:300/api-docs with your browser to get to the swagger documentation

### Deployment

- The project raddocs documentation was deployed in [Heroku](https://extracker-api.herokuapp.com/api_docs/) 
- The project swagger documentation was deployed in [Heroku](https://extracker-api.herokuapp.com/api-docs/) 

### Built With
This project was built using these technologies.
* Ruby 2.6.3
* Rails 6.0.2.1
* Rspec
* rspec_api_documentation
* raddocs
* swagger
* Rubocop
* Ubuntu 18.4+
* Stickler
* VsCode

<!-- CONTACT -->
## Authors

María Eugenia Quemé - [@MaruKK](https://twitter.com/MaruKK) - [@euqueme](https://github.com/euqueme) - euqueme@gmail.com

Project [Link](https://github.com/euqueme/tracker-api/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Microverse](https://www.microverse.org/)
* [Heroku](https://www.heroku.com/)
* [The Best readme Template](https://github.com/othneildrew/Best-README-Template)
* [Austin Kabiru](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one)
* [A D Vishnu Prasad](https://advishnuprasad.com/blog/2016/02/07/api-docs-using-rspecs/)
* [How to document REST APIs with Swagger and Ruby on Rails](https://medium.com/@sushildamdhere/how-to-document-rest-apis-with-swagger-and-ruby-on-rails-ae4e13177f5d)
* [Versioning a Rails API](https://chriskottom.com/blog/2017/04/versioning-a-rails-api/)


<!-- LICENSE -->
## 📝 License

This project is [MIT](https://opensource.org/licenses/MIT) licensed.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/euqueme/tracker-api.svg?style=flat-square
[contributors-url]: https://github.com/euqueme/tracker-api/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/euqueme/tracker-api.svg?style=flat-square
[forks-url]: https://github.com/euqueme/tracker-api/network/members
[stars-shield]: https://img.shields.io/github/stars/euqueme/tracker-api.svg?style=flat-square
[stars-url]: https://github.com/euqueme/tracker-api/stargazers
[issues-shield]: https://img.shields.io/github/issues/euqueme/tracker-api.svg?style=flat-square
[issues-url]: https://github.com/euqueme/tracker-api/issues
[product-screenshot]: /app/assets/images/exercises-index.png


