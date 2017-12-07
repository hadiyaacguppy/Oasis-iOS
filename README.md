## Base Project iOS/Swift

This is going to be the starting point  for iOS apps written in Swift at TEDMOB

Dependencies are handled via Carthage and Cocoapods

 - Carthage :
	 - Alamofire
	 - RxSwift
	 - ObjectMapper
	 - Moya/RxSwift
 - Cocoapods
	 - WIP

It's also going to include a Utilities file with functions that are commonly used.


### TODOS:
- [ ] Sample API Client
- [ ] Gather Extensions from team 
- [ ] **Document Everything **
- [ ] Nib File of common views
- [ ] Integrate MBProgressHUD
- [ ] Sample Views ( Loading Button, Animatable Label..)
- [ ] R.Swift Integration
- [ ] Add Script for renaming the base project
- [ ] Multiple Targets

### Steps to use 
Suppose your new project name is `MyApp`. Be sure not to include spaces or any special characters in the project name. App display name can be changed later to match any combination

1. `git clone https://gitlab.com/tedmob/ios/base-project-swift.git   MyApp`

2. Run `bash rename-project.command ` once the clone is done.
	3. This will ask for the new name and a confirmation
	4. Once rename is don, It will commit the new changes with a special commit message
3. Run `carthage update --platform iOS`
4. Run `pod install --verbose`
5. Open `MyApp.xcworkspace` and build