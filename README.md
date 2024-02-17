# tr_cart

A flutter test project as an assignment for Trans Media


# Technology

Flutter has been used for developing the application

# PLatforms

1. Android (Over API 23)
2. iOS

# Features

1. Internet check
2. Localization (Only English is available now)
3. Fetch Product List
4. Preview network images
5. Cached images
6. Show grid layout for listview images
7. Available on multiple platforms
8. Cart page for checking out
9. Check the product detail page

# Architecture

I have used MVVM for the whole project. Didn't implement clean architecture cause the application is simple, implementing clean architecture seems over-engineering & will lead to complexity in maintaining. Though I tried to follow SOLID principles. For state management, I have used Getx. Bloc can also be used but for smaller projects, Getx is good in terms of simplicity.  

# Scope of improvements

1. UI => UI can be more beautiful & user-friendly, but I have tried my best here
2. test cases => There is scope for improvement in testing

## Basic instructions on how to use

This project fetches data from online resources & shows based on. Product images will be shown in the product page list.
Click on any images from the list to preview the detail section. Users can add items & quantities from the list & detail page. Then they can go to the cart from the top page.
