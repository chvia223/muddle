# Overview

This started as an in class UI programming exercise and has snowballed into a personal project. In a nut shell it is a Wordle-clone, but it's done in SwiftUI. 

As it functions currently, the user is able to launch the game and it starts exactly how Wordle would except there is no tutorial pop up to help you. A random word is selected at midnight every day from a word list contained in the app itself so everything is self contained. The UI is reactive to input as well. Based on how the input guess compares to the solution the gameboard and keyboard UI elements will change color to reflect how they compare against each other. If you use all 6 guesses and you still don't have the correct word you are given a game over message and if you get the right word a win message is displayed instead. This is all expected as it can be found in Wordle itself.

What I have been most proud of has been getting a custom keyboard to reatively resize based on screen space and have it not look horribly ugly. This brings me into the next feature of this being a native app programmed in Swift using the SwiftUI library. You can compile it to MacOS native and it will work as expected. You can also resize the window to your heart's content and you will still be able to use the keyboard. The biggest downside I've found is that you can't use a hardware keyboard to interact with the app. This may be implemented in the future.

[Muddle Demo Video - Not Made Yet](https://link)

# Development Environment

* Target OS: iOS 15.4 & MacOS 12.4
* Swift 5.6
* SwiftUI 3
* Xcode 13.4.1

# Useful Websites

* [Swift Documentation](https://www.swift.org/documentation/)
* [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
* [Apple Official SwiftUI Tutorial](https://developer.apple.com/tutorials/swiftui)
* [Wordle Official](https://www.nytimes.com/games/wordle/index.html)

# Future Work

* Add haptic feedback to the keyboard.
* Add physical keyboard support.
* Track and store player statistics on device.
* Add animations to gameboard elements.
* Add win/gameover message to a popup sheet instead of janky printed text.

I'm taking suggestions so if you have any ideas feel free to fork this project or post an issue ticket!
