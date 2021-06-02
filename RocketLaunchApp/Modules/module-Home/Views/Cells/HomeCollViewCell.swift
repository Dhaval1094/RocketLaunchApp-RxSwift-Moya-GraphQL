//
//  HomeCollViewCell.swift

//  Created by Dhaval Trivedi on 11/04/21.
//


import UIKit

class HomeCollViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    func configureWith(obj: Launches) {
        lblTitle.text = obj.mission?.name
        lblDescription.text = obj.site
        guard let url = URL(string: obj.mission?.missionPatch ?? "") else {
            return
        }
        imgView.setImageWith(url: url , placeholder: UIImage(named: "placeholder"), imageIndicator: .gray, completion: nil)
    }
    
}
