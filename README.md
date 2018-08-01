#  Fenris

Fenris is a framewok to help accelerate game development for SpriteKit games.

Included functionality:
- ServiceLocator: A singleton that is used to register and retrieve services. If a service does not exist, a dummy service is used instead.
- SceneManager: A class that can be used to transition between scenes in a game. Can be registered with the ServiceLocator.

Planned functionality:
- MenuScene: A scene that can be used to setup in game menus (e.g.: main menu, settings, etc...). Can be used with the SceneManager.
- MusicPlayer: A service to play in-game music. Not meant to be used for short audio fragments, as for those SKAudio nodes should be used instead.
- ..?



