import UIKit
import RealmSwift
import CoreSpotlight
import YandexMapsMobile


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let MAPKIT_API_KEY = "42d0c015-15ad-43d4-ae28-51f608b379b3"
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window?.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        YMKMapKit.setApiKey(MAPKIT_API_KEY)
        YMKMapKit.setLocale("ru_RU")
        
        let _ = try! Realm()
        
        if #available(iOS 13.0, *) {
            window?.tintColor = .label
        } else {
            window?.tintColor = .black
        }
        
        application.extendStateRestoration()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {

    }
    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
}
