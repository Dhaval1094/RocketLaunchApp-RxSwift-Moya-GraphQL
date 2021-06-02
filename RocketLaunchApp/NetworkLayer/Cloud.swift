
//  Created by Dhaval Trivedi on 11/04/21.
//

import Foundation
import Moya

private enum Mode: String {
    case offline
    case dev
}

private var CURRENT_MODE = Mode.dev

enum Cloud {
    case fetchLaunchList
    case fetchMoreLaunches(dto: FetchMoreLaunchesDTO)
    case fetchLaunchDetails(dto: FetchLaunchDetailsDTO)
}

// MARK: - MoyaProviderType

extension Cloud: TargetType {
    
    var baseURL: URL {
        switch CURRENT_MODE {
        case .offline:
            return URL(string: API.baseURL)!
        case .dev:
            return URL(string: API.baseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .fetchLaunchList, .fetchMoreLaunches, .fetchLaunchDetails:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchLaunchList, .fetchMoreLaunches, .fetchLaunchDetails:
            return .post
        }
    }
    
    var sampleData: Data {
        fatalError()
    }
    
    var task: Task {
        var body: Data!
        switch self {
        case .fetchLaunchList:
            body = GraphQLQueryBuilder.build(.fetchLaunchList)
        case .fetchMoreLaunches(let dto):
            body = GraphQLQueryBuilder.build(.fetchMoreLaunches(dto: dto))
        case .fetchLaunchDetails(let dto):
            body = GraphQLQueryBuilder.build(.fetchLaunchDetails(dto: dto))
        }
        return .requestData(body)
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchLaunchList,.fetchMoreLaunches,.fetchLaunchDetails:
            return ["Content-Type": "application/json"]
        }
    }
}

// MARK: - Queries
private struct GraphQLQueryBuilder {
    
    static func build(_ type: Cloud) -> Data? {
        switch type {
        case .fetchLaunchList:
            let resultObj = [
                "query": """
                query LaunchList($cursor: String) {
                launches(after: $cursor) {
                  __typename
                  hasMore
                  cursor
                  launches {
                    __typename
                    id
                    site
                    mission {
                      __typename
                      name
                      missionPatch(size: SMALL) 
                    }
                  }
                }
              }
        """.trimmingCharacters(in: .whitespacesAndNewlines)
            ] as [String : Any]
            
            return try? JSONSerialization.data(withJSONObject: resultObj, options: .prettyPrinted)
            
        // -------------------------------------------
        
        case .fetchMoreLaunches(let dto):
            let resultObj = [
                "query": """
                    query LaunchList($cursor: String) {
                      launches(after: $cursor) {
                        __typename
                        hasMore
                        cursor
                        launches {
                          __typename
                          id
                          site
                          mission {
                            __typename
                            name
                            missionPatch(size: SMALL)
                          }
                        }
                      }
                    }
        """.trimmingCharacters(in: .whitespacesAndNewlines),
                "variables": ["cursor": dto.cursor]
            ] as [String : Any]
            
            return try? JSONSerialization.data(withJSONObject: resultObj, options: .prettyPrinted)
        // -------------------------------------------
        
        case .fetchLaunchDetails(let dto):
            let resultObj = [
                "query": """
                        query LaunchDetails($id: ID!) {
                          launch(id: $id) {
                            rocket {
                              __typename
                              name
                              type
                            }
                            isBooked
                          }
                        }
        """.trimmingCharacters(in: .whitespacesAndNewlines),
                "variables": ["id": dto.launchId]
            ] as [String : Any]
            
            return try? JSONSerialization.data(withJSONObject: resultObj, options: .prettyPrinted)
        // -------------------------------------------
        }
    }
}

struct CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        #if DEBUG
        if let method = request.request?.method {
            print("method: \(method)")
        }
        if let body = request.request?.httpBody {
            if let json = try? JSONSerialization.jsonObject(with: body, options: .allowFragments) {
                print("body: \(json)")
            } else {
                let countBytes = ByteCountFormatter()
                countBytes.allowedUnits = [.useAll]
                countBytes.countStyle = .file
                let fileSize = countBytes.string(fromByteCount: Int64(body.count))
                print("body not json, size: \(fileSize)")
            }
        }
        print(request.request?.url?.absoluteString ?? "Something is wrong")
        #endif
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            let payload = try? response.mapJSON()
            print("intercepted payload: \(payload), code: \(response.statusCode)")
            
        case .failure(let error):
            print("intercepted error: \(error)")
        }
    }
}
