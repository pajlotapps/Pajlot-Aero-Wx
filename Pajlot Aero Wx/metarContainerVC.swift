
import UIKit
import GoogleMobileAds

class metarContainerVC: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-7483966442443954/4449495064"
        bannerView.rootViewController = self
        bannerView.load(request)
    }
}
