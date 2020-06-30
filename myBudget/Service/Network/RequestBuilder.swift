//
//  RequestBuilder.swift
//  myBudget
//
//  Created by fivecoil on 25/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class RequestBuilder {
    
    
    //MARK: - Public methods
    
    func calculateRequest(by route: Router) {
        guard let url = URL(string: route.baseURL + route.path) else {
            return
        }
        let request = URLRequest(url: url)
    }
    
}
