# FunQuiz  

## Overview  
The Fun Quiz is a simple project to present my iOS developing skill and architecture ability in 2019.

## Orientation
I haven't any package managerment tool, like cocoapods, in this repo. You don't need to install pods before open the project. Just double click FunQuiz.xcodeproj in the folder to open the project automatically. :)  

## Devleoping Enviornment
*Xcode 10.2.1*  
*Swift 5*  
*macOS Majave Version 10.14.4*  

### Architeture

MVVM without RxSwift. This projest doesn't require complicated user interactives or event reaction, thus, we only have simple data binding and events binding.

### Model
I use Swift's own Codable to build the data model manually. 

### DataManager
I can simply use ```Bundle.main.url(forResource: fileName, withExtension: "json")``` to get json file in a couple of lines code. However, if so, the project will be hard to extend and test.   

The reason I create the ServerManager is for dependency injection, unit test and multi-services managerment.   

### Unit Test  
Use XCTest framework to test DataClient and decoding JSON data.  

### Q&A

1. Why use MVVM design pattern?   
	The MVC design pattern with Storyboard is not friendly for unit test, as the viewController will be initialized automatically. 
  In order to do unit test, we need create the ViewController's instance in unit test class. The one of the MVVM's benefits is unit test friendly. 

2. Why use MVVM without reactive?   
	RxSwift is very popular now. Most of iOS MVVM projects adapted RxSwift. I know how to use it. I might create another feature branch to intrudce RxSwift into project in the future. The reason I didn't pick RxSwift with MVVM architecture is I want to try a new way to achieve MVVM. I don't want to rely on too many third party SDK.
	
### TODO:
1. Improve the unit test coverage as much as possible.
2. Clean up and organize code even better.  

## Feedback

I would love to hear your feedback. File an issue,  send me an email: [jiang.yi@siphty.com](mailto:jiang.yi@siphty.com) or [jiang.yi.work@gmail.com](mailto:jiang.yi.work@gmail.com)


Enjoy it! 
Yi Jiang
