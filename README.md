# RocketLaunchApp-RxSwift-Moya-GraphQL 🚀
![Header](https://www.linkpicture.com/q/Screenshot-2021-06-03-at-11.49.27-PM_3.png) 

**RxSwift** - Using RxSwift, you can react to changes on different threads. You do this with a lot less code, less complexity, less bugs. You can listen to an event on the main thread and react in background. Finally you can go back to the main thread to show the results.

**Moya** - It's Swift Network Abstraction Library. It provides us with an abstraction to make network calls without directly communicating with Alamofire.

**GarphQL** - GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

This is an example project for showing how to implement RxSwift, Moya and GraphQL based APIs. These three things together provide an awesome ViewModel-based structure. Apolo provides the webservice for fetching rocket and launch details. These webservices and UI components are updated with the observable events already provided by RxSwift.

Three functional APIs are binded for these events.
- Fetch the launch details
- Fetch load more launch details, for pagination
- Fetch selected Rocket details

![GIF](https://media.giphy.com/media/xzuBwdgJETtUpF8EAp/giphy.gif) 

These are the pod details which are required to run the project.

**pod 'Moya/RxSwift', '~> 14.0'**                            _# network abstraction_

**pod 'Action', '~> 4.0'**                                   _# observable abstraction_

Action library is used with RxSwift to provide an abstraction on top of observables: actions. 

**pod 'RxSwiftExt', '~> 5.2'**                               _# Reactive Extensions_

RxSwiftExt library provides additional convenience operators and Reactive Extensions.


**REFERENCES:**

https://github.com/Moya/Moya

https://github.com/ReactiveX/RxSwift

https://github.com/RxSwiftCommunity/Action

https://github.com/RxSwiftCommunity/RxSwiftExt




