![transformers logo](https://upload.wikimedia.org/wikipedia/commons/e/ed/Logo_of_Transformers.png)

# Transformers Battle: Legacy version

### Build and start

To build an run the project, you'll need `CocoaPods` installed and **Xcode 10.3**.
- After cloning the repo, run
     ```bash
     $ pod install
     ```
- Open `TransformersBattle.xcworkspace` and run the project.
- Install a legacy iOS simulator runtime. This was tested on iOS 10.3.1 and 12.4.

> **NOTE:** Xcode 10.3 **does not run on macOS Big Sur.**

##### Compatibility changelog

The code was made compatible with Xcode 10.3. Here is a list of changes:

- Generate explicit core data model classes.
  > Observation: A bug during the process caused the files to be inside a folder called "emplate".
- Remove @propertyWrappers. 
- Changing `Self` to explicit class for static access.
- Reverting implicit return syntax from newer Swift version. 
- Removing iOS 13 references.
- Removed `AccentColor` from XCAssets.
- Further storyboard changes: remove system color references, remove `insetGrouped` tableView style.
- Custom styling for segmentedControl.
- Removing unused tests with new methods.
- Remove automatic optional `enum` unwrapping from tests.

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
