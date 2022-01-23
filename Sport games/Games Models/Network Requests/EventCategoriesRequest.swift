//
//  EventCategoriesRequest.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation
import Fetch
import UIKit

struct EventCategoriesRequest: Request {
    let url: URL
    let headers: [String : String]?
    let method = HTTPMethod.get
    let body: Data? = nil
    
    init() {
        let endpointUrl = API.sports.endpoint(path: nil).url
        url = endpointUrl
        headers = ["accept" : "application/json"]
    }
}
