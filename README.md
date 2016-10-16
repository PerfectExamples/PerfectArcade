# Arcade API Example

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a> 
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>

Arcade API backend example

Using Perfect, this example demonstrates JSON API interactions with GET and POST methods, storing and retrieving data via the [SQLite3 version of StORM](https://github.com/SwiftORM/SQLite-StORM) (a Swift ORM). HTTP Requests are logged using [Perfect-RequestLogger](https://github.com/dabfleming/Perfect-RequestLogger) by David Fleming.

###Compatibility with Swift

This project works only with the Swift 3.0 toolchain available with Xcode 8.0+ or on Linux via [Swift.org](http://swift.org/).

## Swift version note:

Due to a late-breaking bug in Xcode 8, if you wish to run directly within Xcode, we recommend installing swiftenv and installing the Swift 3.0.1 preview toolchain.

```
# after installing swiftenv from https://swiftenv.fuller.li/en/latest/
swiftenv install https://swift.org/builds/swift-3.0.1-preview-1/xcode/swift-3.0.1-PREVIEW-1/swift-3.0.1-PREVIEW-1-osx.pkg
```

Alternatively, add to the "Library Search Paths" in "Project Settings" $(PROJECT_DIR), recursive.

## Building & Running

The following will clone and build an empty starter project and launch the server on port 8181.

```
git clone https://github.com/PerfectExamples/PerfectArcade.git
cd PerfectArcade
swift build
.build/debug/PerfectArcade
```

**If you see a build error concerning OpenSSL, please see the swift version or Library Search Paths recommendations above.**

You should see the following output:

```
Starting HTTP server on 0.0.0.0:8181 with document root ./webroot
```

This means the server is running and waiting for connections.

## Available Routes


```
POST http://localhost:8181/api/v1/save
Params: 
	user, ideally 3 letters, i.e. AAA
	score, an integer.
```
The save method returns a status of the action.

```
GET http://localhost:8181/api/v1/highscores
```
The highscores method returns the top 10 high scores, and the associated user.

## Issues

If you find a mistake, bug, or any other helpful suggestion you'd like to make on the docs please head over to [http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1) and raise it.

A comprehensive list of open issues can be found at [http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)



## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
