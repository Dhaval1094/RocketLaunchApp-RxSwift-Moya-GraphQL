//
//  Copyright © 2020 Vlogmi. All rights reserved.
//  

import Foundation
import RxSwift

enum ActivityState: Equatable {
    case idle
    case loading
    case complete(item: CompletableAction)
    
    enum CompletableAction {
        // enumerate all the possible actions that can be completed
        case fetchLauncheDetail
        case fetchRocketDetail
    }
    
    static func == (lhs: ActivityState, rhs: ActivityState) -> Bool {
        switch lhs {
        case .idle:
            switch rhs {
            case .idle:
                return true
            default:
                return false
            }
        case .loading:
            switch rhs {
            case .loading:
                return true
            default:
                return false
            }
        case .complete(let itemL):
            switch rhs {
            case .complete(let itemR):
                return itemL == itemR
            default:
                return false
            }
        }
    }
}

protocol ActivityStateMachineType {
    var state: Observable<ActivityState> { get }
    var error: Observable<Error?> { get }
}

extension Observable where Element == ActivityState {
    
    func isLoading() -> Observable<Bool> {
        return map{ $0 == ActivityState.loading }
    }
    
    /// simple result without consideration to the completable type
    func isComplete() -> Observable<Bool> {
        return map { element -> Bool in
            switch element {
            case .complete:
                return true
            default:
                return false
            }
        }
    }
    
    /// returns the completable type if complete otherwise nil
    func isCompleteByAction() -> Observable<ActivityState.CompletableAction?> {
        return map { element -> ActivityState.CompletableAction? in
            switch element {
            case .complete(let item):
                return item
            default:
                return nil
            }
        }
    }
}
