//
//  Copyright © 2020 Vlogmi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON

class BaseService {
    private var disposeBag = DisposeBag()
    
    @discardableResult
    func secureRequest<T: Codable>(type: Cloud, path: String) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let provider = MoyaProvider<Cloud>(plugins: [CompleteUrlLoggerPlugin()])
            provider.request(type) { result in
                switch result {
                case let .success(response):
                    let json = try? JSON(data: response.data, options: .mutableContainers)
                    if let data = try? json?["data"][path].rawData() {
                        do {
                            let decoded = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(decoded)
                            observer.onCompleted()
                            return
                        } catch let error {
                            debugPrint(error)
                        }
                    }
                    observer.onError(AppError.unprocessableRequest)
                    
                case let .failure(error):
                    if let body = try? error.response?.mapJSON() {
                        let json = JSON(body)
                        if let statusCode = json["errors"].first?.1["status"].intValue {
                            switch statusCode {
                            case 400 ... 499:
                                observer.onError(error)
                                return
                            default:
                                break
                            }
                        } else {
                            // no status code found
                            observer.onError(error)
                        }
                    } else {
                        // no body found
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
