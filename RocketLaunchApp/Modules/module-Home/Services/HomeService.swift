//
//  Copyright © 2020 Vlogmi. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON

protocol HomeServiceType {
    func requestGetLaunchData() -> Observable<LaunchConnection>
    func requestLoadMoreData(dto: FetchMoreLaunchesDTO) -> Observable<LaunchConnection>
    func requestGetLaunchDetails(dto: FetchLaunchDetailsDTO) -> Observable<Rocket>
}

final class HomeService: BaseService, HomeServiceType {
    
    func requestGetLaunchData() -> Observable<LaunchConnection> {
        return secureRequest(type: .fetchLaunchList, path: "launches")
    }
    
    func requestLoadMoreData(dto: FetchMoreLaunchesDTO) -> Observable<LaunchConnection> {
        return secureRequest(type: .fetchMoreLaunches(dto: dto), path: "launches")
    }
    
    func requestGetLaunchDetails(dto: FetchLaunchDetailsDTO) -> Observable<Rocket> {
        return secureRequest(type: .fetchLaunchDetails(dto: dto), path: "launch")
    }
}
