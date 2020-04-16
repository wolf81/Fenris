//
//  LoadingScene.swift
//  Demo macOS
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Fenris
import SpriteKit

final class LoadingScene: MenuScene {
    private let progressBarItem = ProgressBarItem()

    init(size: CGSize) {
        
        let menu = LabeledMenuBuilder()
            .withHeader(title: "Loading")
            .withFooter(items: [self.progressBarItem])
            .build()
        
        super.init(size: size, configuration: DefaultMenuConfiguration(), menu: menu)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        loadData()
    }
    
    private func loadData() {
        print("start load data ...")
            
        DispatchQueue.global(qos: .background).async {
            var finished = false
            
            for i in 0 ... 100 {
                usleep(arc4random() % 800 + 800)
                DispatchQueue.main.async {
                    self.progressBarItem.value = Float(i) / 100
                }
            
                finished = i == 100
            }
            
            if finished {
                print("load data finished")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let scene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.5))
                }
            }
        }
    }
}

