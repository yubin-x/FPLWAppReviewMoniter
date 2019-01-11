//
//  AppSearchService.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import Alamofire

protocol AppSearchServiceLayer {
    func searchApp(term: String, country: Country) -> Observable<[AppModel]>
}

class AppSearchService: AppSearchServiceLayer {
    
    let baseURL = "https://itunes.apple.com/search?term=%@&country=%@&entity=software"
    
    func searchApp(term: String, country: Country) -> Observable<[AppModel]> {
        let urlString = String(format: baseURL, term, country.rawValue)
        
        return Observable<[AppModel]>.create({ (observer) -> Disposable in
            
            Alamofire.request(urlString).responseData { response in
                
                if let data = response.result.value {
                    do {
                        let value = try JSONDecoder().decode(AppSearchResult.self, from: data)
                        observer.onNext(value.result)
                    } catch {
                        observer.onNext([])
                        print(error)
                    }
                } else {
                    observer.onNext([])
                }
            }
            return Disposables.create()
        })
    }
}
