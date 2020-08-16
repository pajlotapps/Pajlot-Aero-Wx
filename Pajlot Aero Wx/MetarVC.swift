
import UIKit

class MetarVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var fetchedMETAR: METARItem!

    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        refreshControl.tintColor = activeColor
        refreshControl.backgroundColor = mainColor
        refreshControl.addTarget(self, action: #selector(MetarVC.refreshData), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl

    }
    
    @objc func refreshData () {
        
        let metarFeedParser = MetarFetch()
        
        for airfield in ICAOcodesMIL {
            metarFeedParser.parseFeed(airfield: airfield) { (fetchedMETAR) in
                
                OperationQueue.main.addOperation {
                    self.fetchedMETAR = fetchedMETAR
                    
                    let index = ICAOcodesMIL.index(of: airfield)
                    Metars[index!] = fetchedMETAR
                }
            }
            print("RefreshData.fetched METAR: \(fetchedMETAR!)")
        }
        

        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func loadData () {
        
        let metarFeedParser = MetarFetch()
        
        for airfield in ICAOcodesMIL {
            metarFeedParser.parseFeed(airfield: airfield) { (fetchedMETAR) in
                self.fetchedMETAR = fetchedMETAR
                
                let index = ICAOcodesMIL.index(of: airfield)
                Metars[index!] = fetchedMETAR
                
                
                OperationQueue.main.addOperation {
                    
                }
            }
            print("LoadData.fetched METAR: \(fetchedMETAR)")
        }
        print("\tLoadData.METAR: \(Metars)")

        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Metars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! MetarCell
            
        cell.selectionStyle = .none

        cell.titleLabel.text = Metars[indexPath.row].title
        cell.descriptionLabel.text = Metars[indexPath.row].description

        return cell
    }
}
