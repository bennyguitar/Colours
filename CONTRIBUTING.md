## Mic Check, 1 2, 1 2

You should **always** run the test suite in the demo app before submitting a pull-request to the Master branch. You can do this by opening the <code>ColoursDemo.xcodeproj</code> project in Xcode and tapping <code>cmd-u</code> on the keyboard. This will run the tests and let you know if they pass or not. Sometimes Xcode can be finicky regarding testing and you may have to run it a couple times when it says it fails but there are no red diamonds that indicate failure.

This also means that if you add functionality that can be tested, you should add a test case for it! If not, it's no big deal - I usually will refactor the test cases every now and then as I think of ways to test certain methods. It would be a huge help however.

## Issue Tissue

Issues are for bugs or feature requests, not for examples or how-to-use questions. There is no StackOverflow tag specifically for this library, but you should go there with questions if at all possible. You can email me at **brgordon [at] ua.edu** if you can't get answers anywhere else and I'll be glad to help if I can.

## Code Style

Try to retain the code style inherent in the project. This means not using <code>UIColor</code> or <code>NSColor</code> but rather <code>[self class]</code> or <code>instancetype</code> anywhere for Class methods or instances of a {UI/NS}Color. I personally like double returns before <code>#pragma marks</code> and spaces after the scope of a method.
