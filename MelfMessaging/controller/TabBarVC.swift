//
//  TabBarVC.swift
//  MelfMessaging
//
//  Created by 范志勇 on 2022/9/19.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let vc1 = SendMusicViewController()
        let vc2 = SendPhotoViewController()
        let vc3 = SendTextViewController()
        
        vc1.navigationItem.title = "sound"
        vc2.navigationItem.title = "camera"
        vc3.navigationItem.title = "text"

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        nav1.navigationBar.prefersLargeTitles = true
        nav1.navigationItem.largeTitleDisplayMode = .always
        nav2.navigationBar.prefersLargeTitles = true
        nav2.navigationItem.largeTitleDisplayMode = .always
        nav3.navigationBar.prefersLargeTitles = true
        nav3.navigationItem.largeTitleDisplayMode = .always

        nav1.tabBarItem = UITabBarItem(title: "sound", image: UIImage(systemName: "music.note.list"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "camera", image: UIImage(systemName: "camera"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "text", image: UIImage(systemName: "text.bubble"), tag: 3)
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
