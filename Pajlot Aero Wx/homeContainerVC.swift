
import UIKit
import GoogleMobileAds

class homeContainerVC: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-7483966442443954/8375537832"
        bannerView.rootViewController = self
        bannerView.load(request)
    }
}

