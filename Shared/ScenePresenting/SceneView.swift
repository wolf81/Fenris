//
//  SceneView.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 19/06/2019.
//  Copyright © 2019 Wolftrail. All rights reserved.
//

import SpriteKit

/// A subclass of SKView that mainly makes it easier to return back on a view stack of sorts by
/// keeping track of presented scenes. When presenting scenes in SceneView, make sure these scenes
/// conform to ScenePresentable.
public class SceneView: SKView {
    private var scenes: [(scene: ScenePresentable.Type, transition: SceneTransition)] = []
    
    public override func presentScene(_ scene: SKScene?) {
        // It seems this method _needs_ to be called once for SKView to prevent a crash, so we
        // allow that to happen.
        guard self.scenes.count == 0 else {
            fatalError("Use presentScene<T: PresentableScene>(_ scene: T.Type) instead")
        }

        if let presentableScene = scene as? ScenePresentable {
            self.scenes.append((type(of: presentableScene), SceneTransition.dummy()))
        }
        
        super.presentScene(scene)
    }

    public override func presentScene(_ scene: SKScene, transition: SKTransition) {
        fatalError("Use presentScene<T: PresentableScene>(_ scene: T.Type) instead")
    }
    
    // MARK: - Public
    
    /// Present a scene based on class.
    ///
    /// - Parameter scene: The scene type to present.
    public func presentScene<T: ScenePresentable>(_ scene: T.Type) {
        presentScene(scene, transition: SceneTransition.dummy())
    }
    
    // MARK: - Internal
    
    internal func presentScene<T: ScenePresentable>(_ scene: T.Type, transition: SceneTransition) {
        presentSceneInternal(scene, transition.present)
        self.scenes.append((scene, transition))
    }
    
    internal func dismissScene() {
        guard self.scenes.count >= 1, let transition = self.scenes.last?.transition else {
            return
        }
        
        let sceneType = self.scenes[self.scenes.count - 2].scene
        presentSceneInternal(sceneType, transition.dismiss)
        self.scenes.removeLast()
    }
    
    // MARK: - Private
    
    private func presentSceneInternal(_ sceneType: ScenePresentable.Type, _ transition: SKTransition) {
        let skScene = (sceneType as SKScene.Type).init(size: self.bounds.size)
        super.presentScene(skScene, transition: transition)
    }
}
