
  

## Base Project Swift

  

  

### TODOs:

  

  

-  [X] Add Device Manager

  

-  [X] Target for Analytics

  

-  [X] Add App Manager

  

-  [X] Add NSAttributedString Extensions

  

-  [X] Migrate to Swift 5 and Xcode 10.2

  

-  [ ] Session Manager make more secure

  

-  [X] Add SwiftLog

  

- [ ] Complete Unit Tests

  

- [ ] Pagintable Table View

  

  

## Steps to use

  

  

Suppose your new project name is `MyApp`.

  

** Be sure not to include spaces or any special characters in the project name ** . App display name can be changed later to match any combination

  

  

1.  `git clone https://gitlab.com/tedmob/ios/base-project-swift.git MyApp`

  

  

2. Run `bash rename-project.command ` once the clone is done.

  

  

3. This will ask for the new name and a confirmation

  

  

4. Once rename is don, It will commit the new changes with a special commit message

  

  

5. Run `carthage update --platform iOS --no-use-binaries`

  

  

6. Run `pod install --verbose`

  

  

7. Open `MyApp.xcworkspace` and build

  
  

## Tests

  

This project has 2 UnitTest Targets

  

1. BaseProjectTest -> Main Test Target for project

2. SessionRepositoryTests -> Test Target for the SessionRepository Target

  

To run the tests, select the appropriate target in the target selector and press `⌘ + U `

  
  

##  Contributing

Contributions are very welcomed. If you feel that a feature mush be added or a bug should be fixed, please follow the below steps

  

1. Pull the latest master branch

2. checkout a new branch. make sure to select meaningful names. `fixing-many-bugs`  **is not**

3. Do the code

4. Commit

5. Before pushing, make sure to run the tests and have them passing on all targets

6. Submit a pull request

7.  # PLEASE HAVE SOME DOCUMENTATION, EXPLANATION, USAGE (CODE) in the merge request description. ANY empty merge request will be closed & the author has to buy the team fries from massaad
