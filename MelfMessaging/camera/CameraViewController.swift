/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The app's primary view controller that presents the camera interface.
*/

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController, AVCaptureFileOutputRecordingDelegate, ItemSelectionViewControllerDelegate {
    
    //MARK: 隐藏状态栏
    override var prefersStatusBarHidden: Bool { return true }

    private var spinner: UIActivityIndicatorView!
    
    var windowOrientation: UIInterfaceOrientation {
        return view.window?.windowScene?.interfaceOrientation ?? .unknown
    }
    
    var child: TabButtonsViewController!
    
    private func setupTabButtons() {
        child = TabButtonsViewController()
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
        
        self.creaSendButton()
    }

    /// send button
    func creaSendButton() {
        var aRect = CGRect(x: 0, y: 0, width: 600, height: 380)
        
        // send
        let sendButton = UIButton(frame: aRect)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(UIColor(displayP3Red: 0xFF/0xFF, green: 0x93/0xFF, blue: 0x7C/0xFF, alpha: 1.0), for: .normal)
        sendButton.layer.borderWidth = 2
        sendButton.layer.cornerRadius = 20
        sendButton.layer.borderColor = UIColor.white.cgColor
        sendButton.layer.backgroundColor = UIColor.white.cgColor

        self.view.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12), // 12
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.widthAnchor.constraint(equalToConstant: 80),
            sendButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
        ])
        
        // close
        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24)))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let closeButton = UIButton(frame: aRect)
        closeButton.setImage(image, for: .normal)
        self.view.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
        ])
    }
    
    /// 创建界面
    ///
    /// 元素
    /// 1. PreviewView
    /// 2. 左侧按钮
    /// 3. 右侧按钮
    /// 4. 顶部按钮
    /// 5. 标签
    func createInterface() {
        // 1. PreviewView
        self.createPreviewView()
        
        // 2.左侧按钮
        self.createLeftButtons()
        
        // 3.右侧按钮
        self.createRightButtons()
        
        // 4.顶部按钮
        self.createTopButtons()
        self.createTopRecordingStatus()

        // 5.标签
        self.createCenterArea()
        
        // 6. 回退按钮
        self.createBackButton()
        
        // 7. 拍照设置参数
        self.createPhotoParametersButton()
    }
    
    var secondCount = 0 // 秒
    var recordingTimer: Timer? // 录像计时器
    var recordingTimeLabel: UILabel!
//    var statusText: UILabel!
    var statusContentView: UIView!
//    var maxTime_record: UILabel! // 录像最长时间：分钟，到时自动停止
    /// 正在录制中
    ///
    /// 显示元素
    /// 1. 录制中：闪动
    /// 2. 计时器（时：分：秒）：每秒增加1次，闪一下
    ///
    /// 触发条件
    /// - 录像启动，则显示
    /// - 录像停止，则隐藏
    func createTopRecordingStatus() {
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        
        self.statusContentView = UIView(frame: aRect)
        self.statusContentView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.view.addSubview(self.statusContentView)
        
        self.statusContentView.isHidden = true //  初始状态：隐藏
        
        var safe = self.view.safeAreaLayoutGuide
        self.statusContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.statusContentView.widthAnchor.constraint(equalToConstant: 150), //600
            self.statusContentView.heightAnchor.constraint(equalToConstant: 50),
            self.statusContentView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0), // 20
            self.statusContentView.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
        ])
        
        //====
        /*
        self.statusText = UILabel(frame: aRect)
        
        var s0 = "录制中"
        var str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.statusText.text = str0
        
        self.statusText.font = UIFont.systemFont(ofSize: 32)
        self.statusText.sizeToFit()
        self.statusText.textColor = ConfigureOfColor.redColor
        
        self.statusContentView.addSubview(self.statusText)
        
//        self.statusText.isHidden = true //隐藏
        
        safe = self.statusContentView.safeAreaLayoutGuide
        self.statusText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            self.statusText.widthAnchor.constraint(equalToConstant: 200),
//            self.statusText.heightAnchor.constraint(equalToConstant: 30),
            self.statusText.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 12),
            self.statusText.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
        ])
        
//        self.statusText.startBlink()
        
        self.maxTime_record = UILabel(frame: aRect)
        let maxTime = SettingsBundleHelper.fetchMaxTimeOfClassNoteVideo()
        
        s0 = "最长: "
        str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        var str = str0 + "\(maxTime) "
        s0 = "分钟\n到时自动停止"
        str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        str += str0

//        let str = "最长：\(maxTime) 分钟\n到时自动停止"
        self.maxTime_record.text = str
        self.maxTime_record.numberOfLines = 2
        self.maxTime_record.font = UIFont.systemFont(ofSize: 24)
        self.maxTime_record.textAlignment = .right
        self.maxTime_record.sizeToFit()
        self.maxTime_record.textColor = ConfigureOfColor.redColor
        
        self.statusContentView.addSubview(self.maxTime_record)
        
        safe = self.statusContentView.safeAreaLayoutGuide
        self.maxTime_record.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            self.maxTime_record.widthAnchor.constraint(equalToConstant: 150),
//            self.maxTime_record.heightAnchor.constraint(equalToConstant: 50),
            self.maxTime_record.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
            self.maxTime_record.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
        ])
        */
        self.recordingTimeLabel = UILabel(frame: aRect)
        self.recordingTimeLabel.text = "00 : 00"
        self.recordingTimeLabel.font = UIFont.systemFont(ofSize: 30)
//        self.recordingTimeLabel.sizeToFit()
        self.recordingTimeLabel.textAlignment = .center
        self.recordingTimeLabel.textColor = ConfigureOfColor.redColor
        
        self.statusContentView.addSubview(self.recordingTimeLabel)
        
        safe = self.statusContentView.safeAreaLayoutGuide
        self.recordingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.recordingTimeLabel.widthAnchor.constraint(equalToConstant: 100),
            self.recordingTimeLabel.heightAnchor.constraint(equalToConstant: 30),
            self.recordingTimeLabel.centerXAnchor.constraint(equalTo: safe.centerXAnchor, constant: 0),
            self.recordingTimeLabel.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
        ])
    }
    
    /// 拍照设置参数
    ///
    /// 参数
    /// 1. 闪光灯
    func createPhotoParametersButton() {
        
    }
    
    /// 回退按钮
    ///
    /// 位置
    /// - 左上角
    /// - 大小：60
    func createBackButton() {
        /*
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        self.backButton = UIButton(frame: aRect)
        let image = UIImage(named: "backInVideo")
        self.backButton.setImage(image, for: .normal)
        self.view.addSubview(self.backButton)
        
        self.backButton.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        
        let safe = self.view.safeAreaLayoutGuide
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.backButton.widthAnchor.constraint(equalToConstant: 60),
            self.backButton.heightAnchor.constraint(equalToConstant: 60),
            self.backButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            self.backButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
        ])
        */
    }
    
    @objc func closeWindow()  {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    /// 标签：居中
    /// 1. Camera Unavailable
    /// 2. Resume Button
    func createCenterArea() {
        // 1. cameraUnavailableLabel
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        self.cameraUnavailableLabel = UILabel(frame: aRect)
        self.cameraUnavailableLabel.text = "Camera Unavailable"
        self.cameraUnavailableLabel.textAlignment = .center
        self.cameraUnavailableLabel.textColor = UIColor.systemYellow //颜色
        self.view.addSubview(self.cameraUnavailableLabel)
        
        self.cameraUnavailableLabel.isHidden = true
        
        let safe = self.view.safeAreaLayoutGuide
        self.cameraUnavailableLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.cameraUnavailableLabel.widthAnchor.constraint(equalToConstant: 300),
            self.cameraUnavailableLabel.heightAnchor.constraint(equalToConstant: 25),
            self.cameraUnavailableLabel.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.cameraUnavailableLabel.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
        ])

        // 2. Resume Button
        self.resumeButton = UIButton(frame: aRect)
        self.resumeButton.setTitle("Tap to resume", for: .normal)
        self.resumeButton.setTitleColor(UIColor.systemYellow, for: .normal)
        self.view.addSubview(self.resumeButton)
        self.resumeButton.addTarget(self, action: #selector(resumeInterruptedSession), for: .touchUpInside)
        
        self.resumeButton.isHidden = true
        
        self.resumeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.resumeButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.resumeButton.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
        ])
    }

    /// 顶部按钮
    /// 1. photoQualityPrioritizationSegControl
    /// 2. Capturing Live Photo
    func createTopButtons() {
        self.photoQualityPrioritizationSegControl = UISegmentedControl(items: ["Speed", "Balanced", "Quality"])
        self.view.addSubview(self.photoQualityPrioritizationSegControl)
        
        self.photoQualityPrioritizationSegControl.addTarget(self, action: #selector(togglePhotoQualityPrioritizationMode), for: .valueChanged)
        
        self.photoQualityPrioritizationSegControl.isHidden = true
        
        var safe = self.view.safeAreaLayoutGuide
        self.photoQualityPrioritizationSegControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.photoQualityPrioritizationSegControl.widthAnchor.constraint(equalToConstant: 230),
            self.photoQualityPrioritizationSegControl.heightAnchor.constraint(equalToConstant: 25),
            self.photoQualityPrioritizationSegControl.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.photoQualityPrioritizationSegControl.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
        ])
        
        
        // 2. Capturing Live Photo
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        self.capturingLivePhotoLabel = UILabel(frame: aRect)
        self.capturingLivePhotoLabel.text = "Live"
        self.capturingLivePhotoLabel.textAlignment = .center
        self.view.addSubview(self.capturingLivePhotoLabel)
        
        self.capturingLivePhotoLabel.isHidden = true
        
        safe = self.view.safeAreaLayoutGuide
        self.capturingLivePhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.capturingLivePhotoLabel.widthAnchor.constraint(equalToConstant: 300),
            self.capturingLivePhotoLabel.heightAnchor.constraint(equalToConstant: 25),
            self.capturingLivePhotoLabel.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.capturingLivePhotoLabel.topAnchor.constraint(equalTo: self.photoQualityPrioritizationSegControl.bottomAnchor, constant: 20),
        ])
    }
    
    /// 右侧按钮
    /// 1. photoButton
    /// 2. recordButton
    /// 3. cameraButton 前后摄像头：缺省为后摄像头
    /// 4. captureModeControl
    func createRightButtons() {
        // 0. doPhotoOrVideoButton
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        self.doPhotoOrVideoButton = UIButton(frame: aRect)
        var image = UIImage(named: "doPhoto") //  doVideo doRecording doPhoto
        self.doPhotoOrVideoButton.setImage(image, for: .normal) // 初始状态，拍照：拍照图标
        self.view.addSubview(self.doPhotoOrVideoButton)
        
        self.doPhotoOrVideoButton.addTarget(self, action: #selector(doPhotoOrVideo), for: .touchUpInside)
        
        var safe = self.view.safeAreaLayoutGuide
        self.doPhotoOrVideoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.doPhotoOrVideoButton.widthAnchor.constraint(equalToConstant: 60),
            self.doPhotoOrVideoButton.heightAnchor.constraint(equalToConstant: 60),
            self.doPhotoOrVideoButton.centerYAnchor.constraint(equalTo: safe.centerYAnchor, constant: 0),
            self.doPhotoOrVideoButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
        ])
        
        // 视频selectVideoButton
        self.selectPhotoButton = UIButton(frame: aRect)
        
        var s0 = "照片"
        var str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.selectPhotoButton.setTitle(str0, for: .normal)
        
        self.selectPhotoButton.setTitleColor(UIColor.systemYellow, for: .normal)
        self.selectPhotoButton.backgroundColor = .black.withAlphaComponent(0.3)
        self.selectPhotoButton.layer.cornerRadius = 10
        self.view.addSubview(self.selectPhotoButton)
        
        self.selectPhotoButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        
        safe = self.doPhotoOrVideoButton.safeAreaLayoutGuide
        self.selectPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.selectPhotoButton.widthAnchor.constraint(equalToConstant: 60),
            self.selectPhotoButton.heightAnchor.constraint(equalToConstant: 36),
            self.selectPhotoButton.topAnchor.constraint(equalTo: safe.bottomAnchor, constant: 50),
            self.selectPhotoButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor, constant: 0),
        ])
        
        // 照片selectPhotoButton
        self.selectVideoButton = UIButton(frame: aRect)
        
        s0 = "视频"
        str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        
        self.selectVideoButton.setTitle(str0, for: .normal)
        self.selectVideoButton.setTitleColor(UIColor.white, for: .normal)
        self.selectVideoButton.backgroundColor = .clear
        self.selectVideoButton.layer.cornerRadius = 0
        self.view.addSubview(self.selectVideoButton)
        
        self.selectVideoButton.addTarget(self, action: #selector(selectVideo), for: .touchUpInside)
        
        safe = self.selectPhotoButton.safeAreaLayoutGuide
        self.selectVideoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.selectVideoButton.widthAnchor.constraint(equalToConstant: 60),
            self.selectVideoButton.heightAnchor.constraint(equalToConstant: 36),
            self.selectVideoButton.topAnchor.constraint(equalTo: safe.bottomAnchor, constant: 20),
            self.selectVideoButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor, constant: 0),
        ])
        
        // 3. cameraButton
        self.cameraButton = UIButton(frame: aRect)
        image = UIImage(named: "FlipCamera")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        self.cameraButton.setImage(image, for: .normal)
        self.view.addSubview(self.cameraButton)
        
        self.cameraButton.addTarget(self, action: #selector(changeCamera), for: .touchUpInside)
        
        safe = self.doPhotoOrVideoButton.safeAreaLayoutGuide
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.cameraButton.widthAnchor.constraint(equalTo: safe.widthAnchor, multiplier: 0.8),
            self.cameraButton.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 0.8),
            self.cameraButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.cameraButton.bottomAnchor.constraint(equalTo: safe.topAnchor, constant: -50),
        ])
        

        /*
        // 1. photoButton
        self.photoButton = UIButton(frame: aRect)
        image = UIImage(named: "CapturePhoto")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.photoButton.setImage(image, for: .normal)
        self.view.addSubview(self.photoButton)
        
        self.photoButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        
        safe = self.view.safeAreaLayoutGuide
        self.photoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.photoButton.widthAnchor.constraint(equalToConstant: 60),
            self.photoButton.heightAnchor.constraint(equalToConstant: 60),
            self.photoButton.centerYAnchor.constraint(equalTo: safe.centerYAnchor, constant: 300),
            self.photoButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
        ])
        */
        /*
        // 2. recordButton
        self.recordButton = UIButton(frame: aRect)
        image = UIImage(named: "CaptureVideo")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.recordButton.setImage(image, for: .normal)
        self.view.addSubview(self.recordButton)
        
        self.recordButton.addTarget(self, action: #selector(toggleMovieRecording), for: .touchUpInside)
        
        safe = self.view.safeAreaLayoutGuide
        self.recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.recordButton.widthAnchor.constraint(equalTo: self.photoButton.widthAnchor),
            self.recordButton.heightAnchor.constraint(equalTo: self.photoButton.heightAnchor),
            self.recordButton.centerXAnchor.constraint(equalTo: self.photoButton.centerXAnchor),
            self.recordButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
        ])
        */
        /*
        // 3. cameraButton
        self.cameraButton = UIButton(frame: aRect)
        image = UIImage(named: "FlipCamera")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.cameraButton.setImage(image, for: .normal)
        self.view.addSubview(self.cameraButton)
        
        self.cameraButton.addTarget(self, action: #selector(changeCamera), for: .touchUpInside)
        
        safe = self.view.safeAreaLayoutGuide
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.cameraButton.widthAnchor.constraint(equalTo: self.photoButton.widthAnchor),
            self.cameraButton.heightAnchor.constraint(equalTo: self.photoButton.heightAnchor),
            self.cameraButton.centerXAnchor.constraint(equalTo: self.photoButton.centerXAnchor),
            self.cameraButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
        ])
        */
        /*
        // 4. captureModeControl
        let image1 = UIImage(named: "PhotoSelector")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        let image2 = UIImage(named: "MovieSelector")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.captureModeControl = UISegmentedControl(items: [image1!, image2!])
        self.view.addSubview(self.captureModeControl)
        
        self.captureModeControl.addTarget(self, action: #selector(toggleCaptureMode), for: .valueChanged)
        
        safe = self.photoButton.safeAreaLayoutGuide
        self.captureModeControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.captureModeControl.widthAnchor.constraint(equalToConstant: 44 * 2),
            self.captureModeControl.heightAnchor.constraint(equalToConstant: 44),
            self.captureModeControl.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            self.captureModeControl.trailingAnchor.constraint(equalTo: safe.leadingAnchor, constant: -20),
        ])
        */
    }
    
    /// 左侧按钮
    /// 1. 返回
    /// 1. livePhotoModeButton
    /// 2. depthDataDeliveryButton
    /// 3. portraitEffectsMatteDeliveryButton
    /// 4. portraitEffectsMatteDeliveryButton
    func createLeftButtons() {
        // 返回
        /*
        // 1. livePhotoModeButton
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        self.livePhotoModeButton = UIButton(frame: aRect)
        var image = UIImage(named: "LivePhotoON")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.livePhotoModeButton.setImage(image, for: .normal)
        self.view.addSubview(self.livePhotoModeButton)
        
        self.livePhotoModeButton.addTarget(self, action: #selector(toggleLivePhotoMode), for: .touchUpInside)
        
        var safe = self.view.safeAreaLayoutGuide
        self.livePhotoModeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.livePhotoModeButton.widthAnchor.constraint(equalToConstant: 50),
            self.livePhotoModeButton.heightAnchor.constraint(equalToConstant: 50),
            self.livePhotoModeButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -30),
            self.livePhotoModeButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
        ])
        */
        // 2. depthDataDeliveryButton
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        self.depthDataDeliveryButton = UIButton(frame: aRect)
        var image = UIImage(named: "DepthON")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.depthDataDeliveryButton.setImage(image, for: .normal)
        self.view.addSubview(self.depthDataDeliveryButton)
        
        self.depthDataDeliveryButton.isHidden = true
        
        self.depthDataDeliveryButton.addTarget(self, action: #selector(toggleDepthDataDeliveryMode), for: .touchUpInside)
        
//        safe = self.livePhotoModeButton.safeAreaLayoutGuide
        var safe = self.view.safeAreaLayoutGuide
        self.depthDataDeliveryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.depthDataDeliveryButton.widthAnchor.constraint(equalToConstant: 50),
            self.depthDataDeliveryButton.heightAnchor.constraint(equalToConstant: 50),
            self.depthDataDeliveryButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
            self.depthDataDeliveryButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -30),
        ])

        // 3. portraitEffectsMatteDeliveryButton
        self.portraitEffectsMatteDeliveryButton = UIButton(frame: aRect)
        image = UIImage(named: "PortraitMatteON")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.portraitEffectsMatteDeliveryButton.setImage(image, for: .normal)
        self.view.addSubview(self.portraitEffectsMatteDeliveryButton)
        
        self.portraitEffectsMatteDeliveryButton.isHidden = true
        
        self.portraitEffectsMatteDeliveryButton.addTarget(self, action: #selector(togglePortraitEffectsMatteDeliveryMode), for: .touchUpInside)
        
        safe = self.depthDataDeliveryButton.safeAreaLayoutGuide
        self.portraitEffectsMatteDeliveryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.portraitEffectsMatteDeliveryButton.widthAnchor.constraint(equalTo: safe.widthAnchor),
            self.portraitEffectsMatteDeliveryButton.heightAnchor.constraint(equalTo: safe.heightAnchor),
            self.portraitEffectsMatteDeliveryButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.portraitEffectsMatteDeliveryButton.bottomAnchor.constraint(equalTo: safe.topAnchor, constant: -30),
        ])

        // 4. semanticSegmentationMatteDeliveryButton
        self.semanticSegmentationMatteDeliveryButton = UIButton(frame: aRect)
        image = UIImage(named: "ssm")?.withTintColor(UIColor.systemYellow, renderingMode: .alwaysOriginal)
        self.semanticSegmentationMatteDeliveryButton.setImage(image, for: .normal)
        self.view.addSubview(self.semanticSegmentationMatteDeliveryButton)
        
        self.semanticSegmentationMatteDeliveryButton.isHidden = true
        
        self.semanticSegmentationMatteDeliveryButton.addTarget(self, action: #selector(toggleSemanticSegmentationMatteDeliveryMode), for: .touchUpInside)
        
        safe = self.portraitEffectsMatteDeliveryButton.safeAreaLayoutGuide
        self.semanticSegmentationMatteDeliveryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.semanticSegmentationMatteDeliveryButton.widthAnchor.constraint(equalTo: safe.widthAnchor),
            self.semanticSegmentationMatteDeliveryButton.heightAnchor.constraint(equalTo: safe.heightAnchor),
            self.semanticSegmentationMatteDeliveryButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            self.semanticSegmentationMatteDeliveryButton.bottomAnchor.constraint(equalTo: safe.topAnchor, constant: -30),
        ])
    }
    
    /// 1. PreviewView
    ///
    /// 事件：点击：gestureRecognizers
    func createPreviewView() {
        let aRect = CGRect(x: 0, y: 0, width: 1024, height: 768)
        self.previewView = PreviewView(frame: aRect)
        
        // 全屏
        self.previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.previewView.contentMode = .scaleToFill
        self.previewView.backgroundColor = .black
        self.previewView.isOpaque = true
        self.previewView.clearsContextBeforeDrawing = true
        self.previewView.autoresizesSubviews = true
        self.previewView.isHidden = false
        self.previewView.clipsToBounds = false
        
        self.previewView.backgroundColor = .black
        
        self.view.addSubview(self.previewView)
        
        let safe = self.view.safeAreaLayoutGuide
        self.previewView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.previewView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 0),
            self.previewView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: 0),
            self.previewView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.previewView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
        ])
        
        // 事件：点击
        self.previewView.isUserInteractionEnabled = true
        let gestureRecognizers = UITapGestureRecognizer()
        gestureRecognizers.addTarget(self, action: #selector(focusAndExposeTap))
        self.previewView.addGestureRecognizer(gestureRecognizers)
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建界面
        self.navigationController?.isNavigationBarHidden = true
        self.createInterface()
        
        self.setupTabButtons()
        
        // Disable the UI. Enable the UI later, if and only if the session starts running.
        cameraButton.isEnabled = false
//        recordButton.isEnabled = false
        self.doPhotoOrVideoButton.isEnabled = false
//        photoButton.isEnabled = false
//        livePhotoModeButton.isEnabled = false
        depthDataDeliveryButton.isEnabled = false
        portraitEffectsMatteDeliveryButton.isEnabled = false
        semanticSegmentationMatteDeliveryButton.isEnabled = false
        photoQualityPrioritizationSegControl.isEnabled = false
//        captureModeControl.isEnabled = false
        
        // Set up the video preview view.
        previewView.session = session
        /*
         Check the video authorization status. Video access is required and audio
         access is optional. If the user denies audio access, AVCam won't
         record audio during movie recording.
         */
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // The user has previously granted access to the camera.
            break
            
        case .notDetermined:
            /*
             The user has not yet been presented with the option to grant
             video access. Suspend the session queue to delay session
             setup until the access request has completed.
             
             Note that audio access will be implicitly requested when we
             create an AVCaptureDeviceInput for audio during session setup.
             */
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
        }
        
        /*
         Setup the capture session.
         In general, it's not safe to mutate an AVCaptureSession or any of its
         inputs, outputs, or connections from multiple threads at the same time.
         
         Don't perform these tasks on the main queue because
         AVCaptureSession.startRunning() is a blocking call, which can
         take a long time. Dispatch session setup to the sessionQueue, so
         that the main queue isn't blocked, which keeps the UI responsive.
         */
        sessionQueue.async {
            self.configureSession()
        }
        DispatchQueue.main.async {
            self.spinner = UIActivityIndicatorView(style: .large)
            self.spinner.color = UIColor.yellow
            self.previewView.addSubview(self.spinner)
        }
    }
    
    //获取 AppDelegate 对象：竖屏/横屏
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //该页面显示时可以横竖屏切换
        appDelegate.interfaceOrientations = .allButUpsideDown
        
        sessionQueue.async {
            switch self.setupResult {
            case .success:
                // Only setup observers and start the session if setup succeeded.
                self.addObservers()
                self.session.startRunning()
                self.isSessionRunning = self.session.isRunning
                
            case .notAuthorized:
                DispatchQueue.main.async {
                    let changePrivacySetting = "AVCam doesn't have permission to use the camera, please change privacy settings"
                    let message = NSLocalizedString(changePrivacySetting, comment: "Alert message when the user has denied access to the camera")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"),
                                                            style: .`default`,
                                                            handler: { _ in
                                                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                                                          options: [:],
                                                                                          completionHandler: nil)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            case .configurationFailed:
                DispatchQueue.main.async {
                    let alertMsg = "Alert message when something goes wrong during capture session configuration"
                    let message = NSLocalizedString("Unable to capture media", comment: alertMsg)
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sessionQueue.async {
            if self.setupResult == .success {
                self.session.stopRunning()
                self.isSessionRunning = self.session.isRunning
                self.removeObservers()
            }
        }
        
        super.viewWillDisappear(animated)
        
        //页面退出时还原强制竖屏状态
        appDelegate.interfaceOrientations = .portrait
    }
    
    override var shouldAutorotate: Bool {
        // Disable autorotation of the interface when recording is in progress.
        if let movieFileOutput = movieFileOutput {
            return !movieFileOutput.isRecording
        }
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if let videoPreviewLayerConnection = previewView.videoPreviewLayer.connection {
            let deviceOrientation = UIDevice.current.orientation
            guard let newVideoOrientation = AVCaptureVideoOrientation(deviceOrientation: deviceOrientation),
                deviceOrientation.isPortrait || deviceOrientation.isLandscape else {
                    return
            }
            
            videoPreviewLayerConnection.videoOrientation = newVideoOrientation
        }
    }
    
    // MARK: Session Management
    
    private enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    
    private let session = AVCaptureSession()
    private var isSessionRunning = false
    private var selectedSemanticSegmentationMatteTypes = [AVSemanticSegmentationMatte.MatteType]()
    
    // Communicate with the session and other session objects on this queue.
    private let sessionQueue = DispatchQueue(label: "session queue")
    
    private var setupResult: SessionSetupResult = .success
    
    @objc dynamic var videoDeviceInput: AVCaptureDeviceInput!
    
    var previewView: PreviewView!
    
    // Call this on the session queue.
    /// - Tag: ConfigureSession
    private func configureSession() {
        if setupResult != .success {
            return
        }
        
        session.beginConfiguration()
        
        /*
         Do not create an AVCaptureMovieFileOutput when setting up the session because
         Live Photo is not supported when AVCaptureMovieFileOutput is added to the session.
         */
        session.sessionPreset = .photo // .photo
        
        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            // Choose the back dual camera, if available, otherwise default to a wide angle camera.
            
            if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                defaultVideoDevice = dualCameraDevice
            } else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                // If a rear dual camera is not available, default to the rear wide angle camera.
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If the rear wide angle camera isn't available, default to the front wide angle camera.
                defaultVideoDevice = frontCameraDevice
            }
            guard let videoDevice = defaultVideoDevice else {
                print("Default video device is unavailable.")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                DispatchQueue.main.async {
                    /*
                     Dispatch video streaming to the main queue because AVCaptureVideoPreviewLayer is the backing layer for PreviewView.
                     You can manipulate UIView only on the main thread.
                     Note: As an exception to the above rule, it's not necessary to serialize video orientation changes
                     on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
                     
                     Use the window scene's orientation as the initial video orientation. Subsequent orientation changes are
                     handled by CameraViewController.viewWillTransition(to:with:).
                     */
                    var initialVideoOrientation: AVCaptureVideoOrientation = .landscapeRight // portrait
                    if self.windowOrientation != .unknown {
                        if let videoOrientation = AVCaptureVideoOrientation(interfaceOrientation: self.windowOrientation) {
                            initialVideoOrientation = videoOrientation
                        }
                    }
                    
                    self.previewView.videoPreviewLayer.connection?.videoOrientation = initialVideoOrientation
                }
            } else {
                print("Couldn't add video device input to the session.")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        } catch {
            print("Couldn't create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        // Add an audio input device.
        do {
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice!)
            
            if session.canAddInput(audioDeviceInput) {
                session.addInput(audioDeviceInput)
            } else {
                print("Could not add audio device input to the session")
            }
        } catch {
            print("Could not create audio device input: \(error)")
        }
        
        // Add the photo output.
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            
            photoOutput.isHighResolutionCaptureEnabled = true
            photoOutput.isLivePhotoCaptureEnabled = false
//            photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
            photoOutput.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
            photoOutput.isPortraitEffectsMatteDeliveryEnabled = photoOutput.isPortraitEffectsMatteDeliverySupported
            photoOutput.enabledSemanticSegmentationMatteTypes = photoOutput.availableSemanticSegmentationMatteTypes
            selectedSemanticSegmentationMatteTypes = photoOutput.availableSemanticSegmentationMatteTypes
            photoOutput.maxPhotoQualityPrioritization = .quality
//            livePhotoMode = photoOutput.isLivePhotoCaptureSupported ? .on : .off
//            livePhotoMode = .off
            depthDataDeliveryMode = photoOutput.isDepthDataDeliverySupported ? .on : .off
            portraitEffectsMatteDeliveryMode = photoOutput.isPortraitEffectsMatteDeliverySupported ? .on : .off
            photoQualityPrioritizationMode = .balanced
            
        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
    }
    
    @objc private func resumeInterruptedSession(_ resumeButton: UIButton) {
        sessionQueue.async {
            /*
             The session might fail to start running, for example, if a phone or FaceTime call is still
             using audio or video. This failure is communicated by the session posting a
             runtime error notification. To avoid repeatedly failing to start the session,
             only try to restart the session in the error handler if you aren't
             trying to resume the session.
             */
            self.session.startRunning()
            self.isSessionRunning = self.session.isRunning
            if !self.session.isRunning {
                DispatchQueue.main.async {
                    let message = NSLocalizedString("Unable to resume", comment: "Alert message when unable to resume the session running")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.resumeButton.isHidden = true
                }
            }
        }
    }
    
    private enum CaptureMode: Int {
        case photo = 0
        case movie = 1
    }
    
//    var captureModeControl: UISegmentedControl!
    /*
    /// - Tag: EnableDisableModes
    @objc private func toggleCaptureMode(_ captureModeControl: UISegmentedControl) {
        captureModeControl.isEnabled = false
        
        if captureModeControl.selectedSegmentIndex == CaptureMode.photo.rawValue {
            recordButton.isEnabled = false
            
            sessionQueue.async {
                // Remove the AVCaptureMovieFileOutput from the session because it doesn't support capture of Live Photos.
                self.session.beginConfiguration()
                self.session.removeOutput(self.movieFileOutput!)
                self.session.sessionPreset = .photo
                
                DispatchQueue.main.async {
                    captureModeControl.isEnabled = true
                }
                
                self.movieFileOutput = nil
                
                if self.photoOutput.isLivePhotoCaptureSupported {
                    self.photoOutput.isLivePhotoCaptureEnabled = true
                    
                    DispatchQueue.main.async {
                        self.livePhotoModeButton.isEnabled = true
                    }
                }
                if self.photoOutput.isDepthDataDeliverySupported {
                    self.photoOutput.isDepthDataDeliveryEnabled = true
                    
                    DispatchQueue.main.async {
                        self.depthDataDeliveryButton.isEnabled = true
                    }
                }
                
                if self.photoOutput.isPortraitEffectsMatteDeliverySupported {
                    self.photoOutput.isPortraitEffectsMatteDeliveryEnabled = true
                    
                    DispatchQueue.main.async {
                        self.portraitEffectsMatteDeliveryButton.isEnabled = true
                    }
                }
                
                if !self.photoOutput.availableSemanticSegmentationMatteTypes.isEmpty {
					self.photoOutput.enabledSemanticSegmentationMatteTypes = self.photoOutput.availableSemanticSegmentationMatteTypes
                    self.selectedSemanticSegmentationMatteTypes = self.photoOutput.availableSemanticSegmentationMatteTypes
                    
                    DispatchQueue.main.async {
                        self.semanticSegmentationMatteDeliveryButton.isEnabled = (self.depthDataDeliveryMode == .on) ? true : false
                    }
                }
                
                DispatchQueue.main.async {
                    self.livePhotoModeButton.isHidden = false
                    self.depthDataDeliveryButton.isHidden = false
                    self.portraitEffectsMatteDeliveryButton.isHidden = false
                    self.semanticSegmentationMatteDeliveryButton.isHidden = false
                    self.photoQualityPrioritizationSegControl.isHidden = false
                    self.photoQualityPrioritizationSegControl.isEnabled = true
                }
                self.session.commitConfiguration()
            }
        } else if captureModeControl.selectedSegmentIndex == CaptureMode.movie.rawValue {
            livePhotoModeButton.isHidden = true
            depthDataDeliveryButton.isHidden = true
            portraitEffectsMatteDeliveryButton.isHidden = true
            semanticSegmentationMatteDeliveryButton.isHidden = true
            photoQualityPrioritizationSegControl.isHidden = true
            
            sessionQueue.async {
                let movieFileOutput = AVCaptureMovieFileOutput()
                
                if self.session.canAddOutput(movieFileOutput) {
                    self.session.beginConfiguration()
                    self.session.addOutput(movieFileOutput)
                    self.session.sessionPreset = .high
                    if let connection = movieFileOutput.connection(with: .video) {
                        if connection.isVideoStabilizationSupported {
                            connection.preferredVideoStabilizationMode = .auto
                        }
                    }
                    self.session.commitConfiguration()
                    
                    DispatchQueue.main.async {
                        captureModeControl.isEnabled = true
                    }
                    
                    self.movieFileOutput = movieFileOutput
                    
                    DispatchQueue.main.async {
                        self.recordButton.isEnabled = true
                        
                        /*
                         For photo captures during movie recording, Speed quality photo processing is prioritized
                         to avoid frame drops during recording.
                         */
                        self.photoQualityPrioritizationSegControl.selectedSegmentIndex = 0
                        self.photoQualityPrioritizationSegControl.sendActions(for: UIControl.Event.valueChanged)
                    }
                }
            }
        }
    }
    */
    var doMode = 1 // 模式：0视频，1照片
    ///选择视频
    ///
    ///操作
    ///1. 模式：0视频
    ///2. 按钮颜色
    /// - 视频按钮颜色：字体黄色，背景：黑色+半透明
    /// - 照片按钮颜色：字体白色，背景：无
    ///3. 视频设置
    @objc func selectVideo() {
//        captureModeControl.isEnabled = false
        
        // 1. 模式：0视频
        self.doMode = 0

        // 2.视频按钮颜色：字体黄色，背景：黑色+半透明
        self.selectVideoButton.setTitleColor(UIColor.systemYellow, for: .normal)
        self.selectVideoButton.backgroundColor = .black.withAlphaComponent(0.3)
        self.selectVideoButton.layer.cornerRadius = 10
        
        self.selectPhotoButton.setTitleColor(UIColor.white, for: .normal)
        self.selectPhotoButton.backgroundColor = .clear
        self.selectPhotoButton.layer.cornerRadius = 0

        let image = UIImage(named: "doVideo")
        self.doPhotoOrVideoButton.setImage(image, for: .normal)

        // 3. 视频设置
        
//        livePhotoModeButton.isHidden = true
        depthDataDeliveryButton.isHidden = true
        portraitEffectsMatteDeliveryButton.isHidden = true
        semanticSegmentationMatteDeliveryButton.isHidden = true
        photoQualityPrioritizationSegControl.isHidden = true
        
        sessionQueue.async {
            let movieFileOutput = AVCaptureMovieFileOutput()
            
            if self.session.canAddOutput(movieFileOutput) {
                self.session.beginConfiguration()
                self.session.addOutput(movieFileOutput)
                self.session.sessionPreset = .high
                if let connection = movieFileOutput.connection(with: .video) {
                    if connection.isVideoStabilizationSupported {
                        connection.preferredVideoStabilizationMode = .auto
                    }
                }
                self.session.commitConfiguration()
                
                DispatchQueue.main.async {
//                    self.captureModeControl.isEnabled = true
                }
                
                self.movieFileOutput = movieFileOutput
                
                DispatchQueue.main.async {
//                    self.recordButton.isEnabled = true
                    self.doPhotoOrVideoButton.isEnabled = true

                    /*
                     For photo captures during movie recording, Speed quality photo processing is prioritized
                     to avoid frame drops during recording.
                     */
                    self.photoQualityPrioritizationSegControl.selectedSegmentIndex = 0
                    self.photoQualityPrioritizationSegControl.sendActions(for: UIControl.Event.valueChanged)
                }
            }
        }
        
    }
    
    ///选择照片
    ///
    ///操作
    ///1. 模式：1照片
    ///2. 按钮颜色
    /// - 视频按钮颜色：字体白色，背景：无
    /// - 照片按钮颜色：字体黄色，背景：黑色+半透明
    ///3. 视频设置
    @objc func selectPhoto() {
//        captureModeControl.isEnabled = false
        
        // 1. 模式：1照片
        self.doMode = 1

        // 2.照片按钮颜色：字体黄色，背景：黑色+半透明
        self.selectPhotoButton.setTitleColor(UIColor.systemYellow, for: .normal)
        self.selectPhotoButton.backgroundColor = .black.withAlphaComponent(0.3)
        self.selectPhotoButton.layer.cornerRadius = 10
        
        self.selectVideoButton.setTitleColor(UIColor.white, for: .normal)
        self.selectVideoButton.backgroundColor = .clear
        self.selectVideoButton.layer.cornerRadius = 0
        
        let image = UIImage(named: "doPhoto") // doVideo
        self.doPhotoOrVideoButton.setImage(image, for: .normal)

        // 3. 照片设置
        
//        recordButton.isEnabled = false
        
        sessionQueue.async {
            // Remove the AVCaptureMovieFileOutput from the session because it doesn't support capture of Live Photos.
            self.session.beginConfiguration()
            if self.movieFileOutput != nil {
                self.session.removeOutput(self.movieFileOutput!)
            }
            self.session.sessionPreset = .photo
            
            DispatchQueue.main.async {
//                self.captureModeControl.isEnabled = true
            }
            
            self.movieFileOutput = nil
            
            /*
            if self.photoOutput.isLivePhotoCaptureSupported {
                self.photoOutput.isLivePhotoCaptureEnabled = true
                
                DispatchQueue.main.async {
//                    self.livePhotoModeButton.isEnabled = true
                }
            }
            */
            if self.photoOutput.isDepthDataDeliverySupported {
                self.photoOutput.isDepthDataDeliveryEnabled = true
                
                DispatchQueue.main.async {
                    self.depthDataDeliveryButton.isEnabled = true
                }
            }
            
            if self.photoOutput.isPortraitEffectsMatteDeliverySupported {
                self.photoOutput.isPortraitEffectsMatteDeliveryEnabled = true
                
                DispatchQueue.main.async {
                    self.portraitEffectsMatteDeliveryButton.isEnabled = true
                }
            }
            
            if !self.photoOutput.availableSemanticSegmentationMatteTypes.isEmpty {
                self.photoOutput.enabledSemanticSegmentationMatteTypes = self.photoOutput.availableSemanticSegmentationMatteTypes
                self.selectedSemanticSegmentationMatteTypes = self.photoOutput.availableSemanticSegmentationMatteTypes
                
                DispatchQueue.main.async {
                    self.semanticSegmentationMatteDeliveryButton.isEnabled = (self.depthDataDeliveryMode == .on) ? true : false
                }
            }
            
            DispatchQueue.main.async {
//                self.livePhotoModeButton.isHidden = false
//                self.depthDataDeliveryButton.isHidden = false
//                self.portraitEffectsMatteDeliveryButton.isHidden = false
//                self.semanticSegmentationMatteDeliveryButton.isHidden = false
//                self.photoQualityPrioritizationSegControl.isHidden = false
//                self.photoQualityPrioritizationSegControl.isEnabled = true
            }
            self.session.commitConfiguration()
        }
        
    }
    
    /// 执行
    /// - 0，录视频
    /// - 1，拍照片
    @objc func doPhotoOrVideo(_ sender: UIButton) {
        if self.doMode == 0 {
            self.toggleMovieRecording(sender)
        } else if self.doMode == 1 {
            self.capturePhoto(sender)
        }
    }
    
    // MARK: Device Configuration
    
    var cameraButton: UIButton!
    
    var cameraUnavailableLabel: UILabel!
    
    private let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera],
                                                                               mediaType: .video, position: .unspecified)
    
    /// - Tag: ChangeCamera
    @objc private func changeCamera(_ cameraButton: UIButton) {
        cameraButton.isEnabled = false
//        recordButton.isEnabled = false
        self.doPhotoOrVideoButton.isEnabled = false
//        photoButton.isEnabled = false
//        livePhotoModeButton.isEnabled = false
//        captureModeControl.isEnabled = false
        depthDataDeliveryButton.isEnabled = false
        portraitEffectsMatteDeliveryButton.isEnabled = false
        semanticSegmentationMatteDeliveryButton.isEnabled = false
        photoQualityPrioritizationSegControl.isEnabled = false
        
        sessionQueue.async {
            let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = currentVideoDevice.position
            
            let preferredPosition: AVCaptureDevice.Position
            let preferredDeviceType: AVCaptureDevice.DeviceType
            
            switch currentPosition {
            case .unspecified, .front:
                preferredPosition = .back
                preferredDeviceType = .builtInDualCamera
                
            case .back:
                preferredPosition = .front
                preferredDeviceType = .builtInTrueDepthCamera
                
            @unknown default:
                print("Unknown capture position. Defaulting to back, dual-camera.")
                preferredPosition = .back
                preferredDeviceType = .builtInDualCamera
            }
            let devices = self.videoDeviceDiscoverySession.devices
            var newVideoDevice: AVCaptureDevice? = nil
            
            // First, seek a device with both the preferred position and device type. Otherwise, seek a device with only the preferred position.
            if let device = devices.first(where: { $0.position == preferredPosition && $0.deviceType == preferredDeviceType }) {
                newVideoDevice = device
            } else if let device = devices.first(where: { $0.position == preferredPosition }) {
                newVideoDevice = device
            }
            
            if let videoDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                    
                    self.session.beginConfiguration()
                    
                    // Remove the existing device input first, because AVCaptureSession doesn't support
                    // simultaneous use of the rear and front cameras.
                    self.session.removeInput(self.videoDeviceInput)
                    
                    if self.session.canAddInput(videoDeviceInput) {
                        NotificationCenter.default.removeObserver(self, name: .AVCaptureDeviceSubjectAreaDidChange, object: currentVideoDevice)
                        NotificationCenter.default.addObserver(self, selector: #selector(self.subjectAreaDidChange), name: .AVCaptureDeviceSubjectAreaDidChange, object: videoDeviceInput.device)
                        
                        self.session.addInput(videoDeviceInput)
                        self.videoDeviceInput = videoDeviceInput
                    } else {
                        self.session.addInput(self.videoDeviceInput)
                    }
                    if let connection = self.movieFileOutput?.connection(with: .video) {
                        if connection.isVideoStabilizationSupported {
                            connection.preferredVideoStabilizationMode = .auto
                        }
                    }
                    
                    /*
                     Set Live Photo capture and depth data delivery if it's supported. When changing cameras, the
                     `livePhotoCaptureEnabled` and `depthDataDeliveryEnabled` properties of the AVCapturePhotoOutput
                     get set to false when a video device is disconnected from the session. After the new video device is
                     added to the session, re-enable them on the AVCapturePhotoOutput, if supported.
                     */
//                    self.photoOutput.isLivePhotoCaptureEnabled = self.photoOutput.isLivePhotoCaptureSupported
                    self.photoOutput.isLivePhotoCaptureEnabled = false
                    self.photoOutput.isDepthDataDeliveryEnabled = self.photoOutput.isDepthDataDeliverySupported
                    self.photoOutput.isPortraitEffectsMatteDeliveryEnabled = self.photoOutput.isPortraitEffectsMatteDeliverySupported
                    self.photoOutput.enabledSemanticSegmentationMatteTypes = self.photoOutput.availableSemanticSegmentationMatteTypes
                    self.selectedSemanticSegmentationMatteTypes = self.photoOutput.availableSemanticSegmentationMatteTypes
                    self.photoOutput.maxPhotoQualityPrioritization = .quality
                    
                    self.session.commitConfiguration()
                } catch {
                    print("Error occurred while creating video device input: \(error)")
                }
            }
            
            DispatchQueue.main.async {
                self.cameraButton.isEnabled = true
//                self.recordButton.isEnabled = self.movieFileOutput != nil
//                self.doPhotoOrVideoButton.isEnabled = self.movieFileOutput != nil
                self.doPhotoOrVideoButton.isEnabled = true
//                self.photoButton.isEnabled = true
//                self.livePhotoModeButton.isEnabled = true
//                self.captureModeControl.isEnabled = true
                self.depthDataDeliveryButton.isEnabled = self.photoOutput.isDepthDataDeliveryEnabled
                self.portraitEffectsMatteDeliveryButton.isEnabled = self.photoOutput.isPortraitEffectsMatteDeliveryEnabled
                self.semanticSegmentationMatteDeliveryButton.isEnabled = (self.photoOutput.availableSemanticSegmentationMatteTypes.isEmpty || self.depthDataDeliveryMode == .off) ? false : true
                self.photoQualityPrioritizationSegControl.isEnabled = true
            }
        }
    }
    
    @objc private func focusAndExposeTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let devicePoint = previewView.videoPreviewLayer.captureDevicePointConverted(fromLayerPoint: gestureRecognizer.location(in: gestureRecognizer.view))
        focus(with: .autoFocus, exposureMode: .autoExpose, at: devicePoint, monitorSubjectAreaChange: true)
    }
    
    private func focus(with focusMode: AVCaptureDevice.FocusMode,
                       exposureMode: AVCaptureDevice.ExposureMode,
                       at devicePoint: CGPoint,
                       monitorSubjectAreaChange: Bool) {
        
        sessionQueue.async {
            let device = self.videoDeviceInput.device
            do {
                try device.lockForConfiguration()
                
                /*
                 Setting (focus/exposure)PointOfInterest alone does not initiate a (focus/exposure) operation.
                 Call set(Focus/Exposure)Mode() to apply the new point of interest.
                 */
                if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
                    device.focusPointOfInterest = devicePoint
                    device.focusMode = focusMode
                }
                
                if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
                    device.exposurePointOfInterest = devicePoint
                    device.exposureMode = exposureMode
                }
                
                device.isSubjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
                device.unlockForConfiguration()
            } catch {
                print("Could not lock device for configuration: \(error)")
            }
        }
    }
    
    // MARK: Capturing Photos
    
    private let photoOutput = AVCapturePhotoOutput()
    
    private var inProgressPhotoCaptureDelegates = [Int64: PhotoCaptureProcessor]()
    
//    var photoButton: UIButton!
    var doPhotoOrVideoButton: UIButton!
    var selectVideoButton: UIButton!
    var selectPhotoButton: UIButton!
//    var backButton: UIButton!

    /// - Tag: CapturePhoto
    @objc private func capturePhoto(_ photoButton: UIButton) {
        /*
         Retrieve the video preview layer's video orientation on the main queue before
         entering the session queue. Do this to ensure that UI elements are accessed on
         the main thread and session configuration is done on the session queue.
         */
        let videoPreviewLayerOrientation = previewView.videoPreviewLayer.connection?.videoOrientation
        
        sessionQueue.async {
            if let photoOutputConnection = self.photoOutput.connection(with: .video) {
                photoOutputConnection.videoOrientation = videoPreviewLayerOrientation!
            }
            var photoSettings = AVCapturePhotoSettings()
            
            // Capture HEIF photos when supported. Enable auto-flash and high-resolution photos.
            
            /*
            if  self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
                
            }
            */
            
            if  self.photoOutput.availablePhotoCodecTypes.contains(.jpeg) {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
//                photoSettings = AVCapturePhotoSettings(rawPixelFormatType: OSType(AVFileType.dng.rawValue)!, rawFileType: .dng, processedFormat: [AVVideoCodecKey: AVVideoCodecType.jpeg], processedFileType: .jpg)
            }

            if self.videoDeviceInput.device.isFlashAvailable {
                photoSettings.flashMode = .auto
                
                if self.videoDeviceInput.device.position == .front {
                    // 前置摄像头：不能用闪光灯
                    photoSettings.flashMode = .off
                }
            }
            
            photoSettings.isHighResolutionPhotoEnabled = true
            if !photoSettings.__availablePreviewPhotoPixelFormatTypes.isEmpty {
                photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoSettings.__availablePreviewPhotoPixelFormatTypes.first!]
            }
            // Live Photo capture is not supported in movie mode.
            /*
            if self.livePhotoMode == .on && self.photoOutput.isLivePhotoCaptureSupported {
                let livePhotoMovieFileName = NSUUID().uuidString
                let livePhotoMovieFilePath = (NSTemporaryDirectory() as NSString).appendingPathComponent((livePhotoMovieFileName as NSString).appendingPathExtension("mov")!)
                photoSettings.livePhotoMovieFileURL = URL(fileURLWithPath: livePhotoMovieFilePath)
            }
            */
            photoSettings.isDepthDataDeliveryEnabled = (self.depthDataDeliveryMode == .on
                && self.photoOutput.isDepthDataDeliveryEnabled)
            
            photoSettings.isPortraitEffectsMatteDeliveryEnabled = (self.portraitEffectsMatteDeliveryMode == .on
                && self.photoOutput.isPortraitEffectsMatteDeliveryEnabled)
            
            if photoSettings.isDepthDataDeliveryEnabled {
                if !self.photoOutput.availableSemanticSegmentationMatteTypes.isEmpty {
                    photoSettings.enabledSemanticSegmentationMatteTypes = self.selectedSemanticSegmentationMatteTypes
                }
            }
            
            photoSettings.photoQualityPrioritization = self.photoQualityPrioritizationMode
            
            let photoCaptureProcessor = PhotoCaptureProcessor(with: photoSettings, willCapturePhotoAnimation: {
                // Flash the screen to signal that AVCam took a photo.
                DispatchQueue.main.async {
                    self.previewView.videoPreviewLayer.opacity = 0
                    UIView.animate(withDuration: 0.25) {
                        self.previewView.videoPreviewLayer.opacity = 1
                    }
                }
            }, livePhotoCaptureHandler: { capturing in
                self.sessionQueue.async {
                    if capturing {
                        self.inProgressLivePhotoCapturesCount += 1
                    } else {
                        self.inProgressLivePhotoCapturesCount -= 1
                    }
                    
                    let inProgressLivePhotoCapturesCount = self.inProgressLivePhotoCapturesCount
                    DispatchQueue.main.async {
                        if inProgressLivePhotoCapturesCount > 0 {
                            self.capturingLivePhotoLabel.isHidden = false
                        } else if inProgressLivePhotoCapturesCount == 0 {
                            self.capturingLivePhotoLabel.isHidden = true
                        } else {
                            print("Error: In progress Live Photo capture count is less than 0.")
                        }
                    }
                }
            }, completionHandler: { photoCaptureProcessor in
                // When the capture is complete, remove a reference to the photo capture delegate so it can be deallocated.
                // 存储笔记
                if let photoData = photoCaptureProcessor.photoData, let image = UIImage(data: photoData), let data_jpg = image.jpegData(compressionQuality: 0.8) {
                    // 文件名使用：时间.png，开始时间
                    // 路径修改：melfNote
                    let int_time = Int(Date().timeIntervalSince1970)
                    let outputFileName = String(int_time) + ".jpg"

                    do {
                        let fm = FileManager.default
                        let docsurl = try fm.url(for:.applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        let myfolder = docsurl.appendingPathComponent("melfNote")
                        
                        try fm.createDirectory(at:myfolder, withIntermediateDirectories: true)
                        
                        let outputFilePath = myfolder.appendingPathComponent(outputFileName)
                        
                        if image.imageOrientation == .down {
                            // 图像倒了：需要翻转
                            let image_tmp = image.flip()
                            if let jpgData = image_tmp.jpegData(compressionQuality: 0.8) {
                                try jpgData.write(to: outputFilePath)
                            }

                        } else {
                            try data_jpg.write(to: outputFilePath, options: .atomic)
                        }

                        /*
                        // 存储
                        // 3. 构建melfNote，存入到数据库
                        var melfNote = MelfNote(notePosition: self.notePositon!)
                        melfNote.content = outputFileName
                        melfNote.melfNoteType = 2 // 图像
                        melfNote.createTime = int_time
                        
                        // 插入
                        if DAOOfMelfNote.insertNewMelfNote(melfNote: melfNote) == true {
                            print("saveNote 插入 图像 OK")
                            print(melfNote.description)
                            
                            // 发出通知
                            NotificationCenter.default.post(name: .melfNoteSave, object: self)
                        }
                        */
                    } catch let err as NSError {
                        print("Error: \(err.domain)")
                    }
                }
                
                self.sessionQueue.async {
                    self.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = nil
                }
            }, photoProcessingHandler: { animate in
                // Animates a spinner while photo is processing
                DispatchQueue.main.async {
                    if animate {
                        self.spinner.hidesWhenStopped = true
                        self.spinner.center = CGPoint(x: self.previewView.frame.size.width / 2.0, y: self.previewView.frame.size.height / 2.0)
                        self.spinner.startAnimating()
                    } else {
                        self.spinner.stopAnimating()
                    }
                }
            }
            )
            
            // The photo output holds a weak reference to the photo capture delegate and stores it in an array to maintain a strong reference.
            self.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = photoCaptureProcessor
            self.photoOutput.capturePhoto(with: photoSettings, delegate: photoCaptureProcessor)
        }
    }
    
//    private enum LivePhotoMode {
//        case on
//        case off
//    }
    
    private enum DepthDataDeliveryMode {
        case on
        case off
    }
    
    private enum PortraitEffectsMatteDeliveryMode {
        case on
        case off
    }
//    private var livePhotoMode: LivePhotoMode = .off
    
    /*
    var livePhotoModeButton: UIButton!
    
    @objc private func toggleLivePhotoMode(_ livePhotoModeButton: UIButton) {
        sessionQueue.async {
            self.livePhotoMode = (self.livePhotoMode == .on) ? .off : .on
            let livePhotoMode = self.livePhotoMode
            
            DispatchQueue.main.async {
                if livePhotoMode == .on {
                    self.livePhotoModeButton.setImage(#imageLiteral(resourceName: "LivePhotoON"), for: [])
                } else {
                    self.livePhotoModeButton.setImage(#imageLiteral(resourceName: "LivePhotoOFF"), for: [])
                }
            }
        }
    }
*/
    private var depthDataDeliveryMode: DepthDataDeliveryMode = .off
    
    var depthDataDeliveryButton: UIButton!
    
    @objc func toggleDepthDataDeliveryMode(_ depthDataDeliveryButton: UIButton) {
        sessionQueue.async {
            self.depthDataDeliveryMode = (self.depthDataDeliveryMode == .on) ? .off : .on
            let depthDataDeliveryMode = self.depthDataDeliveryMode
            if depthDataDeliveryMode == .on {
                self.portraitEffectsMatteDeliveryMode = .on
            } else {
                self.portraitEffectsMatteDeliveryMode = .off
            }
            
            DispatchQueue.main.async {
                if depthDataDeliveryMode == .on {
                    self.depthDataDeliveryButton.setImage(#imageLiteral(resourceName: "DepthON"), for: [])
                    self.portraitEffectsMatteDeliveryButton.setImage(#imageLiteral(resourceName: "PortraitMatteON"), for: [])
                    self.semanticSegmentationMatteDeliveryButton.isEnabled = true
                } else {
                    self.depthDataDeliveryButton.setImage(#imageLiteral(resourceName: "DepthOFF"), for: [])
                    self.portraitEffectsMatteDeliveryButton.setImage(#imageLiteral(resourceName: "PortraitMatteOFF"), for: [])
                    self.semanticSegmentationMatteDeliveryButton.isEnabled = false
                }
            }
        }
    }
    
    private var portraitEffectsMatteDeliveryMode: PortraitEffectsMatteDeliveryMode = .off
    
    var portraitEffectsMatteDeliveryButton: UIButton!
    
    @objc func togglePortraitEffectsMatteDeliveryMode(_ portraitEffectsMatteDeliveryButton: UIButton) {
        sessionQueue.async {
            if self.portraitEffectsMatteDeliveryMode == .on {
                self.portraitEffectsMatteDeliveryMode = .off
            } else {
                self.portraitEffectsMatteDeliveryMode = (self.depthDataDeliveryMode == .off) ? .off : .on
            }
            let portraitEffectsMatteDeliveryMode = self.portraitEffectsMatteDeliveryMode
            
            DispatchQueue.main.async {
                if portraitEffectsMatteDeliveryMode == .on {
                    self.portraitEffectsMatteDeliveryButton.setImage(#imageLiteral(resourceName: "PortraitMatteON"), for: [])
                } else {
                    self.portraitEffectsMatteDeliveryButton.setImage(#imageLiteral(resourceName: "PortraitMatteOFF"), for: [])
                }
            }
        }
    }
    
    private var photoQualityPrioritizationMode: AVCapturePhotoOutput.QualityPrioritization = .balanced
    
    var photoQualityPrioritizationSegControl: UISegmentedControl!
    
    @objc func togglePhotoQualityPrioritizationMode(_ photoQualityPrioritizationSegControl: UISegmentedControl) {
        let selectedQuality = photoQualityPrioritizationSegControl.selectedSegmentIndex
        sessionQueue.async {
            switch selectedQuality {
            case 0 :
                self.photoQualityPrioritizationMode = .speed
            case 1 :
                self.photoQualityPrioritizationMode = .balanced
            case 2 :
                self.photoQualityPrioritizationMode = .quality
            default:
                break
            }
        }
    }
    
    var semanticSegmentationMatteDeliveryButton: UIButton!
    
    @objc func toggleSemanticSegmentationMatteDeliveryMode(_ semanticSegmentationMatteDeliveryButton: UIButton) {
        let itemSelectionViewController = ItemSelectionViewController(delegate: self,
                                                                      identifier: semanticSegmentationTypeItemSelectionIdentifier,
                                                                      allItems: photoOutput.availableSemanticSegmentationMatteTypes,
                                                                      selectedItems: selectedSemanticSegmentationMatteTypes,
                                                                      allowsMultipleSelection: true)
        
        presentItemSelectionViewController(itemSelectionViewController)
        
    }
    
    // MARK: ItemSelectionViewControllerDelegate
    
    let semanticSegmentationTypeItemSelectionIdentifier = "SemanticSegmentationTypes"
    
    private func presentItemSelectionViewController(_ itemSelectionViewController: ItemSelectionViewController) {
        let navigationController = UINavigationController(rootViewController: itemSelectionViewController)
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.tintColor = view.tintColor
        present(navigationController, animated: true, completion: nil)
    }
    
    func itemSelectionViewController(_ itemSelectionViewController: ItemSelectionViewController,
                                     didFinishSelectingItems selectedItems: [AVSemanticSegmentationMatte.MatteType]) {
        let identifier = itemSelectionViewController.identifier
        
        if identifier == semanticSegmentationTypeItemSelectionIdentifier {
            sessionQueue.async {
                self.selectedSemanticSegmentationMatteTypes = selectedItems
            }
        }
    }
    
    private var inProgressLivePhotoCapturesCount = 0
    
    var capturingLivePhotoLabel: UILabel!
    
    // MARK: Recording Movies
    
    private var movieFileOutput: AVCaptureMovieFileOutput?
    
    private var backgroundRecordingID: UIBackgroundTaskIdentifier?
    
//    var recordButton: UIButton!
    
    var resumeButton: UIButton!
    
    @objc private func toggleMovieRecording(_ recordButton: UIButton) {
        guard let movieFileOutput = self.movieFileOutput else {
            return
        }
        
        /*
         Disable the Camera button until recording finishes, and disable
         the Record button until recording starts or finishes.
         
         See the AVCaptureFileOutputRecordingDelegate methods.
         */
        cameraButton.isEnabled = false
//        recordButton.isEnabled = false
        self.doPhotoOrVideoButton.isEnabled = false
//        captureModeControl.isEnabled = false
        
        let videoPreviewLayerOrientation = previewView.videoPreviewLayer.connection?.videoOrientation
        
        sessionQueue.async {
            if !movieFileOutput.isRecording {
                // 不在录制，则启动录制
                if UIDevice.current.isMultitaskingSupported {
                    self.backgroundRecordingID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
                }
                
                // Update the orientation on the movie file output video connection before recording.
                let movieFileOutputConnection = movieFileOutput.connection(with: .video)
                movieFileOutputConnection?.videoOrientation = videoPreviewLayerOrientation!
                
                let availableVideoCodecTypes = movieFileOutput.availableVideoCodecTypes
                
                if availableVideoCodecTypes.contains(.hevc) {
                    movieFileOutput.setOutputSettings([AVVideoCodecKey: AVVideoCodecType.hevc], for: movieFileOutputConnection!)
                }
                
                // Start recording video to a temporary file.
//                let outputFileName = NSUUID().uuidString
//                let outputFilePath = (NSTemporaryDirectory() as NSString).appendingPathComponent((outputFileName as NSString).appendingPathExtension("mov")!)
//                movieFileOutput.startRecording(to: URL(fileURLWithPath: outputFilePath), recordingDelegate: self)
                
                // 文件名使用：时间.mov，开始时间
                // 路径修改：melfNote
                self.int_time = Int(Date().timeIntervalSince1970)
                self.outputFileName = String(self.int_time) + ".mov"
                do {
                    let fm = FileManager.default
                    let docsurl = try fm.url(for:.applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let myfolder = docsurl.appendingPathComponent("melfNote")
                    
                    try fm.createDirectory(at:myfolder, withIntermediateDirectories: true)
                    
                    let outputFilePath = myfolder.appendingPathComponent(self.outputFileName)
                    
                    movieFileOutput.startRecording(to: outputFilePath, recordingDelegate: self)
                } catch let err as NSError {
                    print("Error: \(err.domain)")
                }
                
            } else {
                // 如果正在录制，则停止
                movieFileOutput.stopRecording()
            }
        }
    }
    
    /// - Tag: DidStartRecording
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        // Enable the Record button to let the user stop recording.
        DispatchQueue.main.async {
//            self.recordButton.isEnabled = true
//            self.recordButton.setImage(#imageLiteral(resourceName: "CaptureStop"), for: [])
            
            // 按钮显示改为：停止
            self.doPhotoOrVideoButton.isEnabled = true
            let image = UIImage(named: "doRecording") //  doVideo doRecording doPhoto
//            self.doPhotoOrVideoButton.setImage(image, for: .normal)
            self.doPhotoOrVideoButton.setImage(image, for: [])
            
            // 状态显示
            self.statusContentView.isHidden = false
//            self.statusText.startBlink()
            
            // 隐藏按钮
            self.cameraButton.isHidden = true
            self.selectPhotoButton.isHidden = true
            self.selectVideoButton.isHidden = true
//            self.backButton.isHidden = true
            
            self.recordingTimeLabel.text = "00 : 00"
        }
        
        // 启动计时器
        self.secondCount = 0 // 秒
        self.recordingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(videoRecordingTotolTime), userInfo: nil, repeats: true)
    }
    
    @objc func videoRecordingTotolTime() {
        self.secondCount += 1
        
        //  判断是否录制超时
        if secondCount == SettingsBundleHelper.fetchMaxTimeOfClassNoteVideo() * 60 {
            // 停止录像
            sessionQueue.async {
                // 如果正在录制，则停止
                self.movieFileOutput?.stopRecording()
            }
            
            // 停止计时
            self.recordingTimer?.invalidate()
        }

       
        // 分
        let mintues = (secondCount % 3600) / 60
        
        // 秒
        let seconds = secondCount % 60
 
        // 文本：计时器
        let str = String(format:"%02d", mintues) + " : " + String(format:"%02d", seconds)
        
        DispatchQueue.main.async {
            self.recordingTimeLabel.text = str
        }
    }
    
    // 入参：笔记的位置
//    var notePositon: MelfNotePosition?
    var outputFileName = ""
    var int_time = 0
    
    /// - Tag: DidFinishRecording
    ///
    /// 处理过程
    /// 1. 保存笔记：数据库
    /// 2. 再清理文件
    func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        // Note: Because we use a unique file path for each recording, a new recording won't overwrite a recording mid-save.
        func cleanup() {
            if let currentBackgroundRecordingID = backgroundRecordingID {
                backgroundRecordingID = UIBackgroundTaskIdentifier.invalid
                
                if currentBackgroundRecordingID != UIBackgroundTaskIdentifier.invalid {
                    UIApplication.shared.endBackgroundTask(currentBackgroundRecordingID)
                }
            }
        }
        
        var success = true
        
        if error != nil {
            print("Movie file finishing error: \(String(describing: error))")
            success = (((error! as NSError).userInfo[AVErrorRecordingSuccessfullyFinishedKey] as AnyObject).boolValue)!
        }
        
        if success {
            // 视频时长
            let audioAsset = AVURLAsset.init(url: outputFileURL, options: nil)
            let duration = audioAsset.duration
            let durationInSeconds = CMTimeGetSeconds(duration)
            
            print("durationInSeconds: \(durationInSeconds)")
/*
            // 存储
            // 3. 构建melfNote，存入到数据库
            var melfNote = MelfNote(notePosition: self.notePositon!)
            melfNote.content = self.outputFileName
            melfNote.melfNoteType = 3 // 视频
            melfNote.createTime = self.int_time
            melfNote.duration = Float(durationInSeconds)
            
            // 插入
            if DAOOfMelfNote.insertNewMelfNote(melfNote: melfNote) == true {
                print("saveNote 插入 视频 OK")
                print(melfNote.description)
                
                // 发出通知
                NotificationCenter.default.post(name: .melfNoteSave, object: self)
            }
            */
        }
        
        cleanup()
        
        // Enable the Camera and Record buttons to let the user switch camera and start another recording.
        DispatchQueue.main.async {
            // 停止计时
            self.recordingTimer?.invalidate()
            
            // Only enable the ability to change camera if the device has more than one camera.
            self.cameraButton.isEnabled = self.videoDeviceDiscoverySession.uniqueDevicePositionsCount > 1
            
            // 按钮显示改为：等待录制
            self.doPhotoOrVideoButton.isEnabled = true
            let image = UIImage(named: "doVideo") //  doVideo doRecording doPhoto
            self.doPhotoOrVideoButton.setImage(image, for: [])
            
            // 状态显示
            self.statusContentView.isHidden = true
//            self.statusText.stopBlink()
            
            // 显示按钮
            self.cameraButton.isHidden = false
            self.selectPhotoButton.isHidden = false
            self.selectVideoButton.isHidden = false
//            self.backButton.isHidden = false
        }
    }
    func fileOutputOld(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        // Note: Because we use a unique file path for each recording, a new recording won't overwrite a recording mid-save.
        func cleanup() {
            let path = outputFileURL.path
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    print("Could not remove file at url: \(outputFileURL)")
                }
            }
            
            if let currentBackgroundRecordingID = backgroundRecordingID {
                backgroundRecordingID = UIBackgroundTaskIdentifier.invalid
                
                if currentBackgroundRecordingID != UIBackgroundTaskIdentifier.invalid {
                    UIApplication.shared.endBackgroundTask(currentBackgroundRecordingID)
                }
            }
        }
        
        var success = true
        
        if error != nil {
            print("Movie file finishing error: \(String(describing: error))")
            success = (((error! as NSError).userInfo[AVErrorRecordingSuccessfullyFinishedKey] as AnyObject).boolValue)!
        }
        
        if success {
            // Check the authorization status.
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    // Save the movie file to the photo library and cleanup.
                    PHPhotoLibrary.shared().performChanges({
                        let options = PHAssetResourceCreationOptions()
                        options.shouldMoveFile = true
                        let creationRequest = PHAssetCreationRequest.forAsset()
                        creationRequest.addResource(with: .video, fileURL: outputFileURL, options: options)
                    }, completionHandler: { success, error in
                        if !success {
                            print("AVCam couldn't save the movie to your photo library: \(String(describing: error))")
                        }
                        cleanup()
                    }
                    )
                } else {
                    cleanup()
                }
            }
        } else {
            cleanup()
        }
        
        // Enable the Camera and Record buttons to let the user switch camera and start another recording.
        DispatchQueue.main.async {
            // Only enable the ability to change camera if the device has more than one camera.
            self.cameraButton.isEnabled = self.videoDeviceDiscoverySession.uniqueDevicePositionsCount > 1
//            self.recordButton.isEnabled = true
//            self.captureModeControl.isEnabled = true
//            self.recordButton.setImage(#imageLiteral(resourceName: "CaptureVideo"), for: [])
            
            // 按钮显示改为：等待录制
            self.doPhotoOrVideoButton.isEnabled = true
            let image = UIImage(named: "doVideo") //  doVideo doRecording doPhoto
            self.doPhotoOrVideoButton.setImage(image, for: [])
        }
    }
    
    // MARK: KVO and Notifications
    
    private var keyValueObservations = [NSKeyValueObservation]()
    /// - Tag: ObserveInterruption
    private func addObservers() {
        let keyValueObservation = session.observe(\.isRunning, options: .new) { _, change in
            guard let isSessionRunning = change.newValue else { return }
//            let isLivePhotoCaptureEnabled = self.photoOutput.isLivePhotoCaptureEnabled
            let isDepthDeliveryDataEnabled = self.photoOutput.isDepthDataDeliveryEnabled
            let isPortraitEffectsMatteEnabled = self.photoOutput.isPortraitEffectsMatteDeliveryEnabled
            let isSemanticSegmentationMatteEnabled = !self.photoOutput.enabledSemanticSegmentationMatteTypes.isEmpty
            
            DispatchQueue.main.async {
                // Only enable the ability to change camera if the device has more than one camera.
                self.cameraButton.isEnabled = isSessionRunning && self.videoDeviceDiscoverySession.uniqueDevicePositionsCount > 1
//                self.recordButton.isEnabled = isSessionRunning && self.movieFileOutput != nil
//                self.doPhotoOrVideoButton.isEnabled = isSessionRunning && self.movieFileOutput != nil
                self.doPhotoOrVideoButton.isEnabled = isSessionRunning
//                self.photoButton.isEnabled = isSessionRunning
//                self.captureModeControl.isEnabled = isSessionRunning
//                self.livePhotoModeButton.isEnabled = isSessionRunning && isLivePhotoCaptureEnabled
                self.depthDataDeliveryButton.isEnabled = isSessionRunning && isDepthDeliveryDataEnabled
                self.portraitEffectsMatteDeliveryButton.isEnabled = isSessionRunning && isPortraitEffectsMatteEnabled
                self.semanticSegmentationMatteDeliveryButton.isEnabled = isSessionRunning && isSemanticSegmentationMatteEnabled
                self.photoQualityPrioritizationSegControl.isEnabled = isSessionRunning
            }
        }
        keyValueObservations.append(keyValueObservation)
        
        let systemPressureStateObservation = observe(\.videoDeviceInput.device.systemPressureState, options: .new) { _, change in
            guard let systemPressureState = change.newValue else { return }
            self.setRecommendedFrameRateRangeForPressureState(systemPressureState: systemPressureState)
        }
        keyValueObservations.append(systemPressureStateObservation)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(subjectAreaDidChange),
                                               name: .AVCaptureDeviceSubjectAreaDidChange,
                                               object: videoDeviceInput.device)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sessionRuntimeError),
                                               name: .AVCaptureSessionRuntimeError,
                                               object: session)
        
        /*
         A session can only run when the app is full screen. It will be interrupted
         in a multi-app layout, introduced in iOS 9, see also the documentation of
         AVCaptureSessionInterruptionReason. Add observers to handle these session
         interruptions and show a preview is paused message. See the documentation
         of AVCaptureSessionWasInterruptedNotification for other interruption reasons.
         */
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sessionWasInterrupted),
                                               name: .AVCaptureSessionWasInterrupted,
                                               object: session)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sessionInterruptionEnded),
                                               name: .AVCaptureSessionInterruptionEnded,
                                               object: session)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        
        for keyValueObservation in keyValueObservations {
            keyValueObservation.invalidate()
        }
        keyValueObservations.removeAll()
    }
    
    @objc
    func subjectAreaDidChange(notification: NSNotification) {
        let devicePoint = CGPoint(x: 0.5, y: 0.5)
        focus(with: .continuousAutoFocus, exposureMode: .continuousAutoExposure, at: devicePoint, monitorSubjectAreaChange: false)
    }
    
    /// - Tag: HandleRuntimeError
    @objc
    func sessionRuntimeError(notification: NSNotification) {
        guard let error = notification.userInfo?[AVCaptureSessionErrorKey] as? AVError else { return }
        
        print("Capture session runtime error: \(error)")
        // If media services were reset, and the last start succeeded, restart the session.
        if error.code == .mediaServicesWereReset {
            sessionQueue.async {
                if self.isSessionRunning {
                    self.session.startRunning()
                    self.isSessionRunning = self.session.isRunning
                } else {
                    DispatchQueue.main.async {
                        self.resumeButton.isHidden = false
                    }
                }
            }
        } else {
            resumeButton.isHidden = false
        }
    }
    
    /// - Tag: HandleSystemPressure
    private func setRecommendedFrameRateRangeForPressureState(systemPressureState: AVCaptureDevice.SystemPressureState) {
        /*
         The frame rates used here are only for demonstration purposes.
         Your frame rate throttling may be different depending on your app's camera configuration.
         */
        let pressureLevel = systemPressureState.level
        if pressureLevel == .serious || pressureLevel == .critical {
            if self.movieFileOutput == nil || self.movieFileOutput?.isRecording == false {
                do {
                    try self.videoDeviceInput.device.lockForConfiguration()
                    print("WARNING: Reached elevated system pressure level: \(pressureLevel). Throttling frame rate.")
                    self.videoDeviceInput.device.activeVideoMinFrameDuration = CMTime(value: 1, timescale: 20)
                    self.videoDeviceInput.device.activeVideoMaxFrameDuration = CMTime(value: 1, timescale: 15)
                    self.videoDeviceInput.device.unlockForConfiguration()
                } catch {
                    print("Could not lock device for configuration: \(error)")
                }
            }
        } else if pressureLevel == .shutdown {
            print("Session stopped running due to shutdown system pressure level.")
        }
    }
    
    /// - Tag: HandleInterruption
    @objc
    func sessionWasInterrupted(notification: NSNotification) {
        /*
         In some scenarios you want to enable the user to resume the session.
         For example, if music playback is initiated from Control Center while
         using AVCam, then the user can let AVCam resume
         the session running, which will stop music playback. Note that stopping
         music playback in Control Center will not automatically resume the session.
         Also note that it's not always possible to resume, see `resumeInterruptedSession(_:)`.
         */
        if let userInfoValue = notification.userInfo?[AVCaptureSessionInterruptionReasonKey] as AnyObject?,
            let reasonIntegerValue = userInfoValue.integerValue,
            let reason = AVCaptureSession.InterruptionReason(rawValue: reasonIntegerValue) {
            print("Capture session was interrupted with reason \(reason)")
            
            var showResumeButton = false
            if reason == .audioDeviceInUseByAnotherClient || reason == .videoDeviceInUseByAnotherClient {
                showResumeButton = true
            } else if reason == .videoDeviceNotAvailableWithMultipleForegroundApps {
                // Fade-in a label to inform the user that the camera is unavailable.
                cameraUnavailableLabel.alpha = 0
                cameraUnavailableLabel.isHidden = false
                UIView.animate(withDuration: 0.25) {
                    self.cameraUnavailableLabel.alpha = 1
                }
            } else if reason == .videoDeviceNotAvailableDueToSystemPressure {
                print("Session stopped running due to shutdown system pressure level.")
            }
            if showResumeButton {
                // Fade-in a button to enable the user to try to resume the session running.
                resumeButton.alpha = 0
                resumeButton.isHidden = false
                UIView.animate(withDuration: 0.25) {
                    self.resumeButton.alpha = 1
                }
            }
        }
    }
    
    @objc
    func sessionInterruptionEnded(notification: NSNotification) {
        print("Capture session interruption ended")
        
        if !resumeButton.isHidden {
            UIView.animate(withDuration: 0.25,
                           animations: {
                            self.resumeButton.alpha = 0
            }, completion: { _ in
                self.resumeButton.isHidden = true
            })
        }
        if !cameraUnavailableLabel.isHidden {
            UIView.animate(withDuration: 0.25,
                           animations: {
                            self.cameraUnavailableLabel.alpha = 0
            }, completion: { _ in
                self.cameraUnavailableLabel.isHidden = true
            }
            )
        }
    }
}

extension AVCaptureVideoOrientation {
    init?(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeRight
        case .landscapeRight: self = .landscapeLeft
        default: return nil
        }
    }
    
    init?(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeLeft
        case .landscapeRight: self = .landscapeRight
        default: return nil
        }
    }
}

extension AVCaptureDevice.DiscoverySession {
    var uniqueDevicePositionsCount: Int {
        
        var uniqueDevicePositions = [AVCaptureDevice.Position]()
        
        for device in devices where !uniqueDevicePositions.contains(device.position) {
            uniqueDevicePositions.append(device.position)
        }
        
        return uniqueDevicePositions.count
    }
}

extension UIImage {
    //调整大小
    func scaleImageToSize(_ size:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
        self.draw(in: CGRect(x: 0,y: 0, width: size.width, height: size.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    //切割圆角
    func clip(radius:CGFloat)->UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSize(width:radius*2,height:radius*2), false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.addArc(center: CGPoint(x:radius,y:radius), radius: radius, startAngle: 0, endAngle: .pi/180 * 360, clockwise: true)
        ctx?.clip()
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: radius*2, height: radius*2)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// 将图像垂直翻转
    ///
    /// 应用场景
    /// - iPad：前置摄像头拍摄
    func flip() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.scaleBy(x: -1, y: 1)
        ctx?.translateBy(x: -self.size.width, y: 0)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
