//
//  ReviewService.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import Alamofire

public protocol ReviewAPILayer {
    func fetchReviewData(appID: String, page: Int) -> Observable<[ReviewResponse]>
}

class ReviewAPIService: ReviewAPILayer {
    
    let baseURL = "https://itunes.apple.com/rss/customerreviews/page=%d/id=%@/sortby=mostrecent/json?l=en&&cc=cn"
    
    func fetchReviewData(appID: String, page: Int) -> Observable<[ReviewResponse]> {
        
        let urlString = String(format: baseURL, page, appID)
        
        return Observable<[ReviewResponse]>.create({ (observer) -> Disposable in
            
            Alamofire.request(urlString).responseData { response in
                
                if let data = response.result.value {
                    do {
                        let value = try JSONDecoder().decode(ReviewSearchResult.self, from: data)
                        observer.onNext(value.feed.entrys)
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
