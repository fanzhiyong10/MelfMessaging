//
//  TabButtonsViewController.swift
//  MelfMessaging
//
//  Created by 范志勇 on 2022/9/19.
//

import UIKit

class TabButtonsViewController: UIViewController {
    //MARK: 隐藏状态栏
    override var prefersStatusBarHidden: Bool { return true }
    
    var isHighLight_camera = false
    var isHighLight_text = false
    var isHighLight_music = false
    
    var color_highlight = UIColor.white
    var color_not_highlight = UIColor.gray

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: 50)
        
        self.createButtons()
    }
    
    func createButtons() {
        var aRect = CGRect(x: 0, y: 0, width: 100, height: 31)
        let backgroundView = UIView(frame: aRect)
        backgroundView.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        backgroundView.layer.cornerRadius = 20
        self.view.addSubview(backgroundView)
        
        let safe = self.view.safeAreaLayoutGuide
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
            backgroundView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
        ])
        
        aRect = CGRect(x: 0, y: 0, width: 100, height: 31)
        let cameraButton = UIButton(frame: aRect)
        
        cameraButton.setTitle("camera", for: .normal)
        
        if isHighLight_camera {
            cameraButton.setTitleColor(color_highlight, for: .normal)
        } else {
            cameraButton.setTitleColor(color_not_highlight, for: .normal)
        }
        
        self.view.addSubview(cameraButton)
        
        cameraButton.addTarget(self, action: #selector(sendCamera), for: .touchUpInside)
        
//        let safe = self.view.safeAreaLayoutGuide
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cameraButton.widthAnchor.constraint(equalToConstant: 100),
            cameraButton.heightAnchor.constraint(equalToConstant: 31),
            cameraButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -10),
            cameraButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
        ])

        let musicButton = UIButton(frame: aRect)
        
        musicButton.setTitle("sound", for: .normal)
        
        if isHighLight_music {
            musicButton.setTitleColor(color_highlight, for: .normal)
        } else {
            musicButton.setTitleColor(color_not_highlight, for: .normal)
        }
        
        self.view.addSubview(musicButton)
        
        musicButton.addTarget(self, action: #selector(sendSound), for: .touchUpInside)
        
        musicButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicButton.widthAnchor.constraint(equalToConstant: 100),
            musicButton.heightAnchor.constraint(equalToConstant: 31),
            musicButton.bottomAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 0),
            musicButton.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -20),
        ])
        
        let textButton = UIButton(frame: aRect)
        
        textButton.setTitle("text", for: .normal)
        
        if isHighLight_text {
            textButton.setTitleColor(color_highlight, for: .normal)
        } else {
            textButton.setTitleColor(color_not_highlight, for: .normal)
        }
        
        self.view.addSubview(textButton)
        
        textButton.addTarget(self, action: #selector(sendText), for: .touchUpInside)
        
        textButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textButton.widthAnchor.constraint(equalToConstant: 100),
            textButton.heightAnchor.constraint(equalToConstant: 31),
            textButton.bottomAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 0),
            textButton.leadingAnchor.constraint(equalTo: cameraButton.trailingAnchor, constant: 20),
        ])
    }
    
    @objc func sendText() {
        let vc = SendTextViewController()
        
        // show in full screen
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }

    @objc func sendCamera() {
        let vc = CameraViewController()
        
        // show in full screen
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    @objc func sendSound() {
        let vc = NoteSoundViewController()
        
        // show in full screen
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
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
