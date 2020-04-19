//
//  LoadingScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 19/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation
import Fenris

class LoadingScene: MenuSceneBase {
    override var configuration: MenuConfiguration { return DefaultMenuConfiguration.shared }

    private let progressBarItem = ProgressBarItem()

    override func getMenu() -> Menu {
        return LabeledMenuBuilder()
            .withHeader(title: "Loading")
            .withFooter(items: [self.progressBarItem])
            .build()
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        loadData()
    }
    
    func loadData() {
        DispatchQueue.global(qos: .background).async {
            for i in 0 ... 100 {
                usleep(arc4random() % 800 + 800)
                DispatchQueue.main.async {
                    self.progressBarItem.value = Float(i) / 100
                    
                    if i == 100 {
                        try! ServiceLocator.shared.get(service: SceneManager.self).fade(to: GameScene.self)
                    }
                }
            }
        }
    }
}
