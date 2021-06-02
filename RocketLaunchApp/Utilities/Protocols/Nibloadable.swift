//
//  Nibloadable.swift

//  Created by Dhaval Trivedi on 11/04/21.
//
import Foundation
import UIKit

public protocol NibLoadableView: class {
    static var nibName: String { get }
}

public extension NibLoadableView {
    static var nibName: String {
        return "\(self)"
    }
}
