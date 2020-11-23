//
//  NetworkManager.swift
//  Api+Moya
//
//  Created by HongNhan on 11/23/20.
//

import Foundation
import Moya

protocol Networkable {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

struct NetworkManager: Networkable {    
    
    // themoviedb.org
    static let MovieAPIKey = "d5149a13cdd679c02b01d67fc8a9a884"
    static let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
    static let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
    
    let provider = MoyaProvider<MovieApi>(plugins: [networkLogger])
    
    func getNewMovies(page: Int, completion: @escaping ([MovieModel])->()){
        provider.request(.newMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getDetailMovie(id: Int, completion: @escaping (MovieModel)->()){
        provider.request(.video(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(MovieModel.self, from: response.data)
                    completion(result)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

