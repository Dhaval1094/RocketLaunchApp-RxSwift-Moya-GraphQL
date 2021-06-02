//
//  UICollectionView+Extension.swift

//  Created by Dhaval Trivedi on 11/04/21.
//
import UIKit

public extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_: T.Type, in bundle: Bundle? = nil) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentity)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentity, for: indexPath) as? T else {
            debugPrint("Could not dequeue cell with identifier: \(T.reuseIdentity)")
            return UICollectionViewCell() as! T
        }
        return cell
    }
    
    func scrollToTop() {
        contentOffset = CGPoint(x: 0, y: -contentInset.top)
    }

}
