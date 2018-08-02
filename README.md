#  Fenris

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



