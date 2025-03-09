//
//  CollectionViewCell.swift
//  GoDo
//
//  Created by わだわだ on 2025/01/12.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var likeButton: UIButton!

    
    var isLiked: Bool = false

    @IBAction func like() {
        isLiked.toggle()
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
