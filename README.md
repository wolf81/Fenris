[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

#  Fenris

_**PLEASE NOTE: Both the library and this README as a work in progress. Not all information might be correct.**_

Fenris is a framewok to help accelerate game development for SpriteKit games. 

Included functionality:
- ServiceLocator: A singleton that is used to register and retrieve services. If a service does not exist, a dummy service is used instead.
- SceneManager: A class that can be used to transition between scenes in a game. Can be registered with the ServiceLocator.

Work in progress:
- MenuScene: A scene that can be used to setup in game menus (e.g.: main menu, settings, etc...). Can be used with the SceneManager. The controls included should be usable for all platforms (iOS, tvOS, macOS) and as such should be interactable with mouse, using the AppleTV remote or touch.

Planned functionality:
- MusicPlayer: A service to play in-game music. Not meant to be used for short audio fragments, as for those SKAudio nodes should be used instead.
- MovementGraphBuilder: For use with Tiled tilemaps that will create a movement graph based on layer, tile type and tile properties. 
- ..?

## Installation

Fenris can be installed using Carthage. 

Instructions to be added, but it's basically the same as any other Framework that supports install through Carthage.

## Menu

Fenris provides an easy way to create simple game menus. The menus are build on SpriteKit and should be usable regardless on all supported platforms, though might behave differently depending on the selected platform. For example on an iOS device touch is the expected input method, while on an AppleTV perhaps a gamepad is used instead. On macOS input with mouse and keyboard is supported.

In order to build the menu the first step is to create a configuration, for example as such: 

	let configuration = MenuBuilder.Configuration(
	    menuWidth: 460,
	    rowHeight: 40,
	    titleFont: Font(name: "Papyrus", size: 22)!,
	    labelFont: Font(name: "Papyrus", size: 18)!
	)

Using the configuration we can create a menu builder and add menu items:

	let menu = MenuBuilder(configuration: configuration)
	    .withHeader(title: "New Character")
	    .withEmptyRow()
	    .withRow(title: "Hard Mode", item: ToggleItem(enabled: true))
	    .withRow(title: "Race", item: TextChooserItem(values: ["Human", "Elf", "Dwarf"], selectedValue: "Human"))
	    .withRow(title: "Class", item: TextChooserItem(values: ["Fighter", "Mage", "Thief", "Cleric"], selectedValue: "Fighter"))
	    .withRow(title: "Strength", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12))
	    .withRow(title: "Agility", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12))
	    .withRow(title: "Mind", item: NumberChooserItem(range: (6 ... 18), selectedValue: 12))
	    .withRow(title: "Points Remaining", item: pointsRemainingLabel)
	    .build()

Finally we can create a MenuScene using the generated menu and present the scene in an SKView instance:

    let scene = MenuScene(size: self.view.bounds.size, menu: menu)
    view.presentScene(scene)

For macOS, in order to hide the focus frame on mouse move, make sure to allow the window to receive mouse move events, e.g. as such:

	@NSApplicationMain
	class AppDelegate: NSObject, NSApplicationDelegate {
	    func applicationDidFinishLaunching(_ aNotification: Notification) {
	        // Insert code here to initialize your application
	        NSApp.mainWindow?.acceptsMouseMovedEvents = true
	    }
	}
