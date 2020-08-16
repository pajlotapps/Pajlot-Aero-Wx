import UIKit
import SVProgressHUD

class TableViewHelper {
    
    class func EmptyMessage(message:String, viewController: UITableViewController) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Avenir", size: 14)
        messageLabel.sizeToFit()
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: message)
        
        
        viewController.tableView.backgroundView = messageLabel;
        viewController.tableView.separatorStyle = .none;
        
    }
    
    class func RemoveMessage(viewController: UITableViewController) {
        viewController.tableView.backgroundView = .none;
        
        SVProgressHUD.dismiss()
        
        var frame = viewController.tableView.bounds
        frame.origin.y = -frame.size.height
        frame.size.height = frame.size.height
        frame.size.width = UIScreen.main.bounds.size.width
        let View = UIView(frame: frame)
        //View.backgroundColor = color5
        viewController.tableView.addSubview(View)
    }
}

