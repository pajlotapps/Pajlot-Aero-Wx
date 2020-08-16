
import UIKit
import SVProgressHUD
import DGElasticPullToRefresh

class MetarTableViewController: UITableViewController {
    
    private var metarItems: [METARItem]?
    private var refreshedMetars: [METARItem]?
    private var cellStates: [CellState]?
      
    let tvController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = activeColor
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in

            self?.fetchMetars()

            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(mainColor)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
        fetchMetars()
    }
    
    private func fetchMetars(){
        let metarFeedParser = MetarFeedParser()
        metarFeedParser.parseFeed() { (metarItems) in
            self.metarItems = metarItems
            self.cellStates = Array(repeating: .collapsed, count: metarItems.count)
            
            OperationQueue.main.addOperation {
                
                if metarItems.count < ICAOcodesMIL.count || isParsing {
                    TableViewHelper.EmptyMessage(message: "Pobieram depesze z IMGW.\n Cierpliwości...", viewController:  self.tvController)
                }else{
                    TableViewHelper.RemoveMessage(viewController: self.tvController)
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
                }
            }
            //print("metarItems zawiera \(metarItems.count)")

        }

        //tvController.tableView.reloadData()
        //self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)

        
    }
    deinit {
        tableView.dg_removePullToRefresh()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isParsing {
            return 0
        }else{
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let metarItems = metarItems else {
            return 0
        }
        return metarItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MetarCustomCell
        if let item = metarItems?[indexPath.item] {
            cell.item = item
            cell.selectionStyle = .none
            
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = (cellStates[indexPath.row] == .expanded) ? 0 : 1
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MetarCustomCell
        
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 1 : 0
        
        cellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed
        
        tableView.endUpdates()
    }
    
}
