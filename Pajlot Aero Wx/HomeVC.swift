
import UIKit

class HomeVC: UIViewController {

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    @IBAction func btnSelectedAirfieldPressed(_ sender: Any) {
        performSegue(withIdentifier: "selectedAirfieldSegue", sender: nil)
    }
    
    //MARK: App lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
