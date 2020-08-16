
import UIKit
import Firebase
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        globalFunctions().checkReachability()

        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barStyle  = .blackTranslucent
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = mainColor
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = mainColor
        
//        UITabBar.appearance().tintColor = activeColor
//        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        
        let shortestTime: UInt32 = 50
        let longestTime: UInt32 = 500
        guard let timeInterval = TimeInterval(exactly: arc4random_uniform(longestTime - shortestTime) + shortestTime) else { return true }


        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(AppDelegate.requestReview), userInfo: nil, repeats: false)
        
        return true
    }
    
    @objc func requestReview() {
        SKStoreReviewController.requestReview()
    }

}

