//
//  FPReviewViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

let url = "https://itunes.apple.com/rss/customerreviews/page=%d/id=414478124/sortby=mostrecent/json?l=en&&cc=cn"

class FPReviewViewModel {
    
    var complete: (()->())?
    
    private var page = 1
    
    func fetchData() {
        SVProgressHUD.showProgress(Float(page)/10)
        
        let urlString = String(format: url, page)
        
        print(urlString)
        
        Alamofire.request(urlString).responseData { response in

            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                do {
                    let value = try JSONDecoder().decode(ReviewModel.self, from: data)
                    debugPrint(value)
                } catch {
                    print(error)
                }
            }

            if self.page == 10 {
                self.complete?()
                return
            }
            self.page += 1
            self.fetchData()
        }
        
            
//            Alamofire.request(String(format: urlString, Int(page))).responseJSON { response in
//            if let json = response.result.value as? [String: Any] {
//                print("JSON: \(json)") // serialized json response
//
//
//            }
//            if self.page == 10 {
//                self.complete?()
//                return
//            }
//            self.page += 1
//            self.fetchData()
//        }
    }
}
