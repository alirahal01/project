//
//  APIClient.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//

import Foundation
import RxSwift
import RxCocoa

class APIClient {
    private let baseURL = URL(string: "https://pixabay.com/")!

//    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
//        let request = apiRequest.request(with: baseURL)
//        return URLSession.shared.rx.data(request: request)
//            .map {
//                try JSONDecoder().decode(T.self, from: $0)
//            }
//    }
}
