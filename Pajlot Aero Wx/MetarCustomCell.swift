
import UIKit

enum CellState {
    case expanded
    case collapsed
}

class MetarCustomCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 1
        }
    }
    
    var item: METARItem! {
        didSet {
            titleLabel.text = item.title
            descriptionLabel.text = item.description
        }
    }
}














