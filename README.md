  

## Oasis iOS Project

  

  

### TODOs:

  

  

-  [X] Setup project

  

-  [X] Kickoff design dev (Parent flow mainly)

  

-  [ ] Start implementing services

  

-  [ ] Adding animations

  

-  [ ] Create AppStore account

  

-  [ ] Create development certificates and provisioning profiles

  

-  [ ] Add analytics & crashlytics

  

- [ ] Complete Unit Tests

  
  

  

## Steps to use

  

  

1.  `git clone https://github.com/HadiYaac/Oasis-iOS.git`

  

  

2. *Carthage Removed for now *
Run `carthage update --platform iOS --no-use-binaries`
<details>
  <summary>Solution for Carthage failure on Xcode 12.0.1 mainly</summary>
  
  ## Workaround that works with both Xcode 11 and 12
  Works with all versions of Xcode 12 (except beta 1 and 2; but no-one should be using those anymore). Once XCFrameworks support lands in Carthage this workaround won’t be needed. However not that XCFrameworks puts some strict requirements on projects that most projects don’t comply with.

Note: This is a change from before where the script excluded arm64 for simulators by individual Xcode 12 version. It now removes it from all Xcode 12 based builds.

How to use
Save the script (👇) to your project (e.g. as a carthage.sh file).
Make the script executable chmod +x carthage.sh
Instead of calling carthage ... call ./carthage.sh ...
E.g. ./carthage.sh build or ./carthage.sh update --use-submodules
Script
```
#!/usr/bin/env bash

# carthage.sh
# Usage example: ./carthage.sh build --platform iOS

set -euo pipefail

xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

# For Xcode 12 make sure EXCLUDED_ARCHS is set to arm architectures otherwise
# the build will fail on lipo due to duplicate architectures.
echo 'EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64__XCODE_1200 = arm64 arm64e armv7 armv7s armv6 armv8' >> $xcconfig
echo 'EXCLUDED_ARCHS = $(inherited) $(EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_$(EFFECTIVE_PLATFORM_SUFFIX)__NATIVE_ARCH_64_BIT_$(NATIVE_ARCH_64_BIT)__XCODE_$(XCODE_VERSION_MAJOR))' >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"
carthage "$@"
```
[Click here to view original Answer](https://github.com/Carthage/Carthage/issues/3019#issuecomment-665136323)
</details>

  


3. Run `pod install --verbose`





4. Open `Oasis.xcworkspace` and build


  
  

## Tests

  

This project has 2 UnitTest Targets

  

1. OasisProjectTest -> Main Test Target for project

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

7.  # PLEASE HAVE SOME DOCUMENTATION, EXPLANATION, USAGE (CODE) in the merge request description.
