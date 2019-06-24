# Fenris

## Introduction

Fenris is a framework built on top of SpriteKit. The aim of Fenris is to make game development easier. My personal aim is to use this framework for a tiled, turn-based RPG that is currently a work-in-progress. 

Currently Fenris is still very much a work in progress. At the same time, one of the goals is to release early and often and make sure most of the released work is tested and documented.

As of version 0.1.3 the following functionality is provided:

- Several components to ease the creation of in-game menus.

- Several components to ease interaction with the mouse, keyboard, gamepad or touch.

- A ServiceLocator that can be used to prevent creating a lot of singletons in an app. 

Some of the above components are not yet fully completed, but are mostly in a usable state.

A simple macOS demo app is provided to showcase the above functionality. In the near future I hope to add at least 1 very small game that makes use of the framework.

## Guides

### The Service Locator

The ServiceLocator is very easy to use, but it's important to keep 1 rule in mind: for every type, only 1 instance can be added to the ServiceLocator. Adding multiple instances of the same type to the ServiceLocator will raise an exception.

#### Registering a Service

Only classes that conform to the `LocatableService` marker protocol can be registered with the ServiceLocator. A simple service could be created as such:

	class HelloService: LocatableService {
		private var name: String 
		
		init(name: String) {
			self.name = name
		}

		func sayHello() {
			print "Hello, \(self.name)"
		}
	}

In order to register a `LocatableService` with the ServiceLocator, just call the `add(service:)` function with an instance of a class:

	do {
		let service = HelloService(name: "Peter")
        try ServiceLocator.shared.add(service: service)
	} catch let error {
		print(error)
	}

#### Retrieving a Service

In order to retrieve a service from the ServiceLocator, call the `get(service:)` function with the class type you want to retrieve, i.e. as such:

	do {
		let service = try ServiceLocator.shared.get(service: HelloService.self)	
		service.sayHello // --> "Hello, Peter"
	} catch let error {
		print(error)
	}

For performance reasons on could consider to ignore the error handling as such:

	let service = try! ServiceLocator.shared.get(service: HelloService.self)

Though please be aware this will cause an app to crash if the service was not registered. 

#### Removing a Service

Finally it's possible to remove a service, by calling the `remove(service:)` function with the class type you want to remove, i.e. as such:

	do {
		try ServiceLocator.shared.remove(service: HelloService.self)
	} catch let error {
		print(error)
	}

### Menu Creation

_... To be added ..._

### Interaction Through Input Devices

_... To be added ..._
