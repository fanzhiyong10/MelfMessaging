//
//  AppDelegate.swift
//  MelfMessaging
//
//  Created by 范志勇 on 2022/9/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //当前界面支持的方向（默认情况下只能竖屏，不能横屏显示）
    var interfaceOrientations:UIInterfaceOrientationMask = .portrait{
        didSet{
            //强制设置成竖屏
            if interfaceOrientations == .portrait{
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                          forKey: "orientation")
            }
            //强制设置成横屏
            else if !interfaceOrientations.contains(.portrait){
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue,
                                          forKey: "orientation")
            }
        }
    }
 
    //返回当前界面支持的旋转方向
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor
        window: UIWindow?)-> UIInterfaceOrientationMask {
        return interfaceOrientations
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*
        // 低版本
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if AuthManager.shared.signedIn == true {
            window.rootViewController = TabBarVC()
        } else {
            let navVC = UINavigationController(rootViewController: WelcomeViewController())
            navVC.navigationBar.prefersLargeTitles = true
            navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = navVC
        }
        
        window.makeKeyAndVisible()
        
        self.window = window
        */
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

