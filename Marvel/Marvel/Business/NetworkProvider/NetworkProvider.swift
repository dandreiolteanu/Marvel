//
//  NetworkProvider.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit
import Alamofire
import Moya

struct NetworkProvider<Target: TargetType> {

    // MARK: - Private Properties
    
    private let provider: MoyaProvider<Target>
    
    // MARK: - Init
    
    init() {
        self.provider = MoyaProvider<Target>(plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
        ])
    }
    
    // MARK: - Public Methods
    
    @discardableResult func request(_ target: Target, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    completion(.success(try response.filterSuccessfulStatusCodes().data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult func request<M>(_ target: Target, for objectType: M.Type, completion: @escaping (Result<M, Error>) -> Void) -> Cancellable where M: Decodable {
        request(target) { result in
            switch result {
            case .success(let data):
                DispatchQueue.global().async {
                    do {
                        let object = try JSONDecoder().decode(objectType, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(object))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
