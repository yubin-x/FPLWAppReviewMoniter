//
//  ReviewService.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import Alamofire

protocol ReviewServiceLayer {
    func fetchReviewData(appID: String, page: Int) -> Observable<[EntryModel]>
}

class ReviewService: ReviewServiceLayer {
    
    let baseURL = "https://itunes.apple.com/rss/customerreviews/page=%d/id=%@/sortby=mostrecent/json?l=en&&cc=cn"
    
    func fetchReviewData(appID: String, page: Int) -> Observable<[EntryModel]> {
        
        let urlString = String(format: baseURL, page, appID)
        
        return Observable<[EntryModel]>.create({ (observer) -> Disposable in
            
            Alamofire.request(urlString).responseData { response in
                
                if let data = response.result.value {
                    do {
                        let value = try JSONDecoder().decode(ReviewModel.self, from: data)
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
