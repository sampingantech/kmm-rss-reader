//
//  App.swift
//  iosApp
//
//  Created by Ekaterina.Petrova on 13.11.2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import RssReader

@main
class RSSApp: App {
    let rss = RssReader.Companion().create(withLog: true)
    let store = FeedStore()
    lazy var engine = FeedEngine(rssReader: rss, store: store)
    lazy var viewModelFactory = ViewModelFactory(store: store)
    
    required init() {
        engine.start()
    }
  
    var body: some Scene {
        WindowGroup {
            MainFeedView(viewModel: viewModelFactory.mainFeedViewModel)
        }
    }
}

class ViewModelFactory {
    let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    var mainFeedViewModel: MainFeedView.ViewModel {
        return .init(store: store) {
            FeedsList(viewModel: .init(store: self.store))
        }
    }
}


