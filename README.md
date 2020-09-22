![transformers logo](https://upload.wikimedia.org/wikipedia/commons/e/ed/Logo_of_Transformers.png)

# Transformers Battle

### Build and start

To build an run the project, you'll need `CocoaPods` installed and a recent version of Xcode. 
- After cloning the repo, run
     ```bash
     $ pod install
     ```
- Open  `TransformersBattle.xcworkspace` and run the project.

##### Compatibility issues

The code is compatible with iOS 10.0, but a device is required to run the app (iOS 10 and 11 simulators might not be supported).

> The project was created using Xcode 12.0 with Swift 5.3. Older versions might present issues.


### Development

To enable linting and formatting in your workspace, use
```bash
$ git config core.hooksPath githooks
```

### Assumptions

- The architecture is _MVVM_.
- The UI is built on Interface Builder. Almost no views are created or configured programmatically. The controllers are separated into different storyboards.
- The tests are not made using `XCTestCase`, but a framework called `Quick`. There are 3 testing targets:
   - One for testing the controller integration. 
   - One for logic only, which is faster since it does not have a host application.
   - One for UI testing.
   
  Only the logic one has real tests. The others are deactivated.
