//
//  LoadingScene.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 17/04/2020.
//  Copyright © 2020 Wolftrail. All rights reserved.
//

import Foundation

/// A  simple scene that can be used to show the loading process of some data.
public class LoadingScene: MenuScene {
    private let progressBarItem = ProgressBarItem()

    private let dataLoader: DataLoaderProtocol
    
    public init(size: CGSize, configuration: MenuConfiguration, dataLoader: DataLoaderProtocol) {
        self.dataLoader = dataLoader
        
        let menu = LabeledMenuBuilder()
            .withHeader(title: "Loading")
            .withFooter(items: [self.progressBarItem])
            .build()
                
        super.init(size: size, configuration: configuration, menu: menu)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        
        DispatchQueue.global(qos: .default).async {
            self.dataLoader.loadData { (progress) in
                DispatchQueue.main.async {
                    self.progressBarItem.value = progress
                    
                    if (progress == 1.0) {
                        self.dataLoader.loadDataFinished()
                    }
                }
            }
        }
    }
}
