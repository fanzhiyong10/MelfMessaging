//
//  mainContainerVC.swift
//  MelfMessaging
//
//  Created by 范志勇 on 2022/9/19.
//

import UIKit

/// 主
class mainContainerVC: UIViewController {
    //MARK: 隐藏状态栏
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(displayP3Red: 0xFF/0xFF, green: 0x93/0xFF, blue: 0x7C/0xFF, alpha: 1.0)
        
        self.setupTabButtons()
        
        self.createWelcome()
    }
    
    /// 欢迎你
    ///
    /// 两行
    /// 1. You're welcome
    /// 2. melf message
    func createWelcome() {
        var aRect = CGRect(x: 0, y: 0, width: 600, height: 380)
        
        // 1. You're welcome
        let label1 = UILabel(frame: aRect)
        label1.text = "You'are welcome"
        label1.textColor = .white
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 36)

        self.view.addSubview(label1)
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label1.centerYAnchor.constraint(equalTo: safe.centerYAnchor, constant: -200), // 12
            label1.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            label1.heightAnchor.constraint(equalToConstant: 50),
            label1.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
        ])
        
        // 2. melf message
        let label2 = UILabel(frame: aRect)
        label2.text = "melf message"
        label2.textColor = .white
        label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 20)

        self.view.addSubview(label2)
        
        label2.translatesAutoresizingMaskIntoConstraints = false
//        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label2.centerYAnchor.constraint(equalTo: safe.centerYAnchor, constant: -50), // 12
            label2.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            label2.heightAnchor.constraint(equalToConstant: 30),
            label2.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
        ])
    }
    
    var child: TabButtonsViewController!
    
    private func setupTabButtons() {
        child = TabButtonsViewController()
        child.isHighLight_music = true
        child.isHighLight_text = true
        child.isHighLight_camera = true

        self.addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)

        
        let sz = child.preferredContentSize
        
        let safe = self.view.safeAreaLayoutGuide
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.widthAnchor.constraint(equalToConstant: sz.width),
            child.view.heightAnchor.constraint(equalToConstant: sz.height),
            child.view.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -100),
            child.view.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
        ])
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
