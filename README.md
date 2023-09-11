# EffectivDevice-iOS
A repository containing the cocoapod podspec file for seamless integration of the 'EffectivDeviceiOS' SDK into iOS projects.

## Pre-requisites

Before you can start using EffectivDeviceiOS, you must have **CocoaPods** installed. CocoaPods is a dependency manager for Swift and Objective-C projects, which makes it easy to integrate third-party libraries and frameworks into your Xcode projects. To start with CocoaPods, please refer to their official [documentation](https://guides.cocoapods.org/using/index.html). 

## Minimum Requirements

- XCode >= 13
- iOS Deployment Target >= 12
- Swift 5

## Integration Steps

### Add EffectivDeviceiOS Pod

1. Add the source at the top of your Podfile

`source 'https://github.com/effectivai/EffectivDevice-iOS.git'`

2. Add the below cocoapods cdn source as well if other public pods are used

`source 'https://cdn.cocoapods.org/'`

2. Add Pod to your app target

`pod 'EffectivDeviceiOS', '1.0'`

3. Run `pod install` in the same directory where Podfile exists

### Options

Options use builder-pattern to create the options required by DeviceIntel to work. The `Options` class has initialiser parameters and builder functions which are explained below

#### Initialiser Parameter

`apiKey`(required, string):  API Key is provided by Effectiv. API keys would be different for Sandbox and Production.

`customerSessionID`(required, string): Customer-managed session ID for the current session. If the session ID is not present, Effectiv's proxy session ID can be used from [Supporting functions for proxying the session](#supporting-functions-for-proxying-the-session).

#### Builder Functions

| Name                  | Required/Optional | Data Type                     | Description                                                                            |
| :-------------------- | :---------------- | :---------------------------- | :------------------------------------------------------------------------------------- |
| withCustomerSessionID | Required          | string                        | Customer-managed session ID for the current session                                    |
| withCustomerUserID    | Optional          | string                        | Customer-managed user ID                                                               |
| withEnv               | Optional          | enum - [.SANDBOX, .PROD]      | Default ".PROD". If set to ".SANDBOX", data is sent to Sandbox servers.                |
| withEvent             | Optional          | string                        | Event name for current integration screen, such as "login", "signup", or "transaction" |
| withMode              | Optional          | enum - [.LITE, .EXPERIMENTAL] | Default ".LITE". If set to ".EXPERIMENTAL", the beta features will be enabled, for example: gathering location information if access is enabled.<br/>_Please use experimental features carefully and stay mindful of any potential changes or limitations._

### Supporting functions for proxying the session

```swift

// Generates the new session id
func generateSessionID() -> String {...}

// Retrives the value of the session id
func getSessionID() -> String {...}
```

### SDK Execution

In your Swift file, add the below code snippet to execute the SDK.

```swift
import EffectivDeviceiOS
...

let effectivDevice = EffectivDevice()
let sessionID = "<your-session-id>"
// If you don't have concept of sessions, please use our proxy API getSessionID()
// let sessionID = effectivDevice.getSessionID()

// Use generateSessionID() to regenerate a new session ID for subsequent interactions in the session.
// let newSessionID = effectivDevice.generateSessionID();

let options = Options(apiKey: "<your-api-key>", customerSessionID: sessionID)

effectivDevice.execute(options) { response in // optional callback
  print(response)
}
```
> ℹ️ If you are getting "Sandbox: rsync.samba" related errors, open **Build Settings** and search for "user script sandboxing" and change it "No".

***

### Example Response

#### Success

```json
{
  "request_id": "c5578e9f-022c-4b49-a14d-f44fa4ab7645",
  "session_id": "14a64a29-c94b-4701-9162-17a8327a2e3c",
  "success": true,
  "status_code": 200
}
```

#### Failure

```json
{
  "request_id": "c5578e9f-022c-4b49-a14d-f44fa4ab7645",
  "session_id": "14a64a29-c94b-4701-9162-17a8327a2e3c",
  "success": false,
  "status_code": 500,
  "error_message": "device computation failed with error: device generation failed"
}
```

- `request_id` (string): The unique identifier for the request.

- `session_id` (string): The session identifier associated with the device.

- `success` (boolean): Whether the execution was successful or not

- `status_code`(number): Response status code.
  - 200 = Response is success
  - 500 = Failed to execute device intelligence. The error message provides more details.

- `error_message` (string): Error message if any error occurred, i.e. `status_code = 500`
