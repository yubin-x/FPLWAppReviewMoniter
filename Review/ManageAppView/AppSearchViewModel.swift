//
//  AppSearchViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift

protocol AppSearchViewable {
    func searchApp(term: String) -> Observable<[AppModel]>
}

class AppSearchViewModel: AppSearchViewable {
    
    let searchService: AppSearchServiceLayer
    
    init(searchService: AppSearchServiceLayer = AppSearchService()) {
        self.searchService = searchService
    }
    
    func searchApp(term: String) -> Observable<[AppModel]> {
        return searchService.searchApp(term: term, country: .china)
    }
}
