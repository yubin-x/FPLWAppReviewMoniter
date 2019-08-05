//
//  AppSearchService.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import Alamofire
import ReviewHelperKit

public protocol AppSearchAPILayer {
    func searchApp(term: String, country: Country) -> Observable<[AppSearchResponse]>
}

class AppSearchAPIService: AppSearchAPILayer {
    
    let baseURL = "https://itunes.apple.com/search?term=%@&country=%@&entity=software"
    
    func searchApp(term: String, country: Country) -> Observable<[AppSearchResponse]> {
        
        let urlString: String
        
        if let encodingString = String(format: baseURL, term, country.rawValue).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString = encodingString
        } else {
            urlString = ""
        }
        
        return Observable<[AppSearchResponse]>.create({ (observer) -> Disposable in
            
            Alamofire.request(urlString).responseData { response in
                
                if let data = response.result.value {
                    do {
                        let value = try JSONDecoder().decode(AppSearchResult.self, from: data)
                        observer.onNext(value.results)
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
