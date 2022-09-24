/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The ViewController class.
*/

import UIKit
import AVFoundation.AVFAudio

extension UIView {
    /// 开始闪烁
    func startBlink()  {
        UIView.animate(withDuration: 0.6, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.allowUserInteraction, UIView.AnimationOptions.curveEaseInOut], animations: {
            self.alpha = 0
        }, completion: nil)
    }
    
    /// 停止闪烁
    func stopBlink()  {
        layer.removeAllAnimations()
        self.alpha = 1
    }
}

class NoteMediaStatusView: UIView {
    var status = 0 // 0:录制，1：暂停，2，停止
    var statusIcon: UIImageView? // 状态：文字
    var statusText: UILabel? // 状态：图标
    var countLabel: UILabel? // 计时器
    var maxTime_record: UILabel! // 录像最长时间：分钟，到时自动停止

    init(frame: CGRect, status: Int=0) {
        super.init(frame: frame)
        self.status = status
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if status == 0 {
            drawRecord()
        } else if status == 1 {
            drawPause()
        } else if status == 2 {
            drawStop()
        }
    }
    
    /// 清除
    func clean() {
        // 停止闪烁
        self.stopBlink()
        
        // 清除
        self.statusIcon?.isHidden = true
        self.statusIcon?.removeFromSuperview()
        
        self.statusText?.isHidden = true
        self.statusText?.removeFromSuperview()
        
        self.countLabel?.isHidden = true
        self.countLabel?.removeFromSuperview()
    }
    
    func drawRecord() {
        // 清除
        self.clean()
        
        // 图标
        let image = UIImage(named: "recording")
        self.statusIcon = UIImageView(image: image)
        
        self.addSubview(self.statusIcon!)
        
        // 文本
        var aRect = CGRect(x: 40, y: 0, width: 80, height: 30)
        
        self.statusText = UILabel(frame: aRect)
        var s0 = "录制中"
        var str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.statusText?.text = str0
        self.statusText?.textColor = ConfigureOfColor.redColor
        
        self.statusText?.center.y = self.statusIcon!.center.y
        
        self.addSubview(self.statusText!)

        // 闪烁
//        self.startBlink()
        
        // 计时器
        aRect.origin.x += 80 + 30
        self.countLabel = UILabel(frame: aRect)
        self.countLabel?.text = "00 : 00"
        self.countLabel?.textColor = ConfigureOfColor.redColor
        
        self.countLabel?.center.y = self.statusIcon!.center.y
        
        self.addSubview(self.countLabel!)
        
        aRect.origin.x += 80 + 30
        aRect.size.width = 250
        self.maxTime_record = UILabel(frame: aRect)
        
        let maxTime = SettingsBundleHelper.fetchMaxTimeOfClassNoteSound()
        
        s0 = "最长: "
        str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        var str = str0 + "\(maxTime) "
        s0 = "分钟\n到时自动停止"
        str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        str += str0
        
        self.maxTime_record.text = str
        self.maxTime_record.numberOfLines = 2
        self.maxTime_record.sizeToFit()

        self.maxTime_record?.textColor = ConfigureOfColor.redColor
        
        self.maxTime_record?.center.y = self.statusIcon!.center.y
        
        self.addSubview(self.maxTime_record!)
        
        
        // 显示
        self.statusIcon?.isHidden = false
        self.statusText?.isHidden = false
        self.countLabel?.isHidden = false
        self.maxTime_record?.isHidden = false
    }
    
    func drawPause() {
        // 清除
        self.clean()
        
        // 图标
        let image = UIImage(named: "recordingPause")
        self.statusIcon = UIImageView(image: image)
        
        self.addSubview(self.statusIcon!)
        
        // 文本
        let aRect = CGRect(x: 40, y: 0, width: 100, height: 30)
        
        self.statusText = UILabel(frame: aRect)
        self.statusText?.text = "暂停中"
        self.statusText?.textColor = ConfigureOfColor.greenColor
        
        self.statusText?.center.y = self.statusIcon!.center.y
        
        self.addSubview(self.statusText!)
        
        self.statusIcon?.isHidden = false
        self.statusText?.isHidden = false
    }
    
    func drawStop() {
        // 状态改变
        // 图标
        let image = UIImage(named: "recordingStop")
        self.statusIcon?.image = image
        
        let s0 = "停止"
        let str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.statusText?.text = str0
        self.statusText?.textColor = ConfigureOfColor.grayColor
        
        self.countLabel?.textColor = ConfigureOfColor.grayColor
        
        self.maxTime_record?.textColor = ConfigureOfColor.grayColor
        
        self.statusIcon?.isHidden = false
        self.statusText?.isHidden = false
        self.countLabel?.isHidden = false
        self.maxTime_record?.isHidden = false
    }
}

class NoteSoundViewController: UIViewController {
    
    var child: TabButtonsViewController!
    
    private func setupTabButtons() {
        child = TabButtonsViewController()
        child.isHighLight_music = true
        
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

    var sendButton: UIButton!
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
        self.sendButton = sendButton
        
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
    
    @objc func closeWindow()  {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    var status = 0 // 0:录制，1：暂停，2，停止
    
    // 入参：笔记的位置
//    var notePositon: MelfNotePosition?

    var recordButton: UIButton! // 暂停/继续录音，隐藏
//    var completeButton: UIButton! // 完成，则隐藏recordButton
//    var abandonButton: UIButton! // 抛弃返回，退出
//    var restartButton: UIButton! // 重新开始
    
    var playButton: UIButton!
    
    var fxSwitch: UISwitch!
    var speechSwitch: UISwitch!
    var bypassSwitch: UISwitch!
    
    var speechMeter: LevelMeterView!
    var fxMeter: LevelMeterView!
    var voiceIOMeter: LevelMeterView!
    
    var statusView: NoteMediaStatusView! // 状态视图

    private var audioEngine: AudioEngine!

    enum ButtonTitles: String {
        case record = "Record"
        case play = "Play"
        case stop = "Stop"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s0 = "回课笔记：声音"
        let str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.navigationItem.title = str0

//        self.setupNavigatorBar()
        self.setupTabButtons()

        self.createInterface()

        self.setupAudioEngine()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleInterruption(_:)),
                                               name: AVAudioSession.interruptionNotification,
                                               object: AVAudioSession.sharedInstance())
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleRouteChange(_:)),
                                               name: AVAudioSession.routeChangeNotification,
                                               object: AVAudioSession.sharedInstance())
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleMediaServicesWereReset(_:)),
                                               name: AVAudioSession.mediaServicesWereResetNotification,
                                               object: AVAudioSession.sharedInstance())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 启动录音
        self.recordPressed()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 停止播放
        self.audioEngine.stopRecordingAndPlayers()
    }
    
    var recordOrPauseItem: UIBarButtonItem!
    var isRecording = true
    
    var secondCount = 0 // 秒
    var recordingTimer: Timer? // 录像计时器

    ///设置导航栏
    ///
    ///设置项目
    ///- 完成，存储 saveItem
    ///- 抛弃返回，删除 deleteItem
    ///- 重新开始，reNew
    ///- 关闭
    ///- title：文字笔记，白色
    func setupNavigatorBar() {
        var image = UIImage(named: "xmark.circle")
        let cancelItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(closeNote))
        self.navigationItem.leftBarButtonItem = cancelItem
        
        image = UIImage(systemName: "plus")
        let addNewNoteItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addNewNote))
        
//        image = UIImage(named: "noteSave")
        image = UIImage(systemName: "checkmark")
        let saveItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(saveNote))
        
//        image = UIImage(named: "noteDelete")
//        image = UIImage(systemName: "trash")
//        let deleteItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(deleteNote))
        
        // 加大间距
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 30 // adjust as needed
        
//        self.navigationItem.rightBarButtonItems = [saveItem, space, deleteItem, space, addNewNoteItem]
        self.navigationItem.rightBarButtonItems = [saveItem, space, addNewNoteItem]

    }
    
    /// 关闭窗口
    @objc func closeNote() {
//        self.contentTextView.endEditing(true)
        
        self.presentingViewController?.dismiss(animated: true)
    }

    /// 添加新的笔记：重新录音
    @objc func addNewNote() {
        self.restart()
    }
    
    /// 暂停或录制
    ///
    /// 录制状态
    /// - 正在录制，则允许的操作为暂停，显示“暂停”
    /// - 不在录制，则允许的操作为录制，显示“录制”
    @objc func recordOrPause() {
        isRecording = !isRecording // 状态翻转
        if isRecording {
            // 正在录音，则允许的操作为暂停，显示“暂停”
            self.recordOrPauseItem.image = UIImage(named: "pause.circle")
        } else {
            //不在录制，则允许的操作为录制，显示“录制”
            self.recordOrPauseItem.image = UIImage(named: "record.circle")
            
            //不在录制，则允许的操作为录制，显示“录制”
        }
    }

    ///存储笔记
    ///
    ///顺序做两件时间
    ///1. 如果正在录音，则停止
    ///2. 存储内容
    ///3. 发出通知
    ///4. 关闭窗口
    ///
    ///存储内容
    ///- 笔记
    ///- 时间：精确到秒
    ///- 乐谱
    ///- 乐谱位置：小节索引、音符索引
    @objc func saveNote() {
        if audioEngine.isRecording {
            // 入口条件：停止录音
            self.stopRecoring()
            
            // 1. 停止录音
            // 1.1 停止
            // 1.2 显示
            self.statusView.drawStop()
            self.status = 2 // 停止
            self.recordButton.isHidden = true
//            self.completeButton.isHidden = true
            self.playButton.isHidden = false
        }
        
        let str = self.audioEngine.recordedFileURL.relativeString
        print("saveNote: \(str)")
        
        // 音频时长
        let audioAsset = AVURLAsset.init(url: self.audioEngine.recordedFileURL, options: nil)
        let duration = audioAsset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)
        
        print("durationInSeconds: \(durationInSeconds)")
        
        // 1. 如果未停止录音，则停止录音
        
        // 2. 复制文件到目录下：Application Support/melfNote/时间.caf
        let srcPath = self.audioEngine.recordedFileURL
        let int_time = Int(Date().timeIntervalSince1970)
        let fileName = String(int_time) + ".caf"
        
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let myfolder = docsurl.appendingPathComponent("melfNote")
            
            try fm.createDirectory(at:myfolder, withIntermediateDirectories: true)
            
            let destPath = myfolder.appendingPathComponent(fileName)
            
            try fm.copyItem(at: srcPath, to: destPath)
            
        } catch let err as NSError {
            print("Error: \(err.domain)")
        }
        /*
        // 3. 构建melfNote，存入到数据库
        var melfNote = MelfNote(notePosition: self.notePositon!)
        melfNote.content = fileName
        melfNote.melfNoteType = 1 // 声音
        melfNote.createTime = int_time
        melfNote.duration = Float(durationInSeconds)
        
        // 插入
        if DAOOfMelfNote.insertNewMelfNote(melfNote: melfNote) == true {
            // 发出通知
            NotificationCenter.default.post(name: .melfNoteSave, object: self)
            
            print("saveNote 插入 声音 OK")
            print(melfNote.description)
        }
        */
    }
    
    /// 删除笔记
    @objc func deleteNote() {
//        self.contentTextView.endEditing(true)
    }
    
    /// 录音笔记
    ///
    /// 显示：三层
    /// 1. 状态，2种：正在录音，停止状态
    /// 2. 音量
    /// 3. 按钮：停止录音、播放/停止播放
    ///
    /// 执行动作
    /// 1. 先显示界面
    /// 2. 启动录音
    func createInterface() {
        var aRect = CGRect(x: 0, y: 0, width: 300, height: 180)
        self.contentView = UIView(frame: aRect)
        self.view.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        var safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
//            self.contentView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12), // 12
            self.contentView.topAnchor.constraint(equalTo: self.sendButton.bottomAnchor, constant: 50), // 12
            self.contentView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 12),
            self.contentView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -12),
            self.contentView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
        ])
        
        // 1. 状态，2种：正在录音，暂停状态
        self.statusView = NoteMediaStatusView(frame: aRect)
        self.contentView.addSubview(self.statusView)
        
        self.statusView.translatesAutoresizingMaskIntoConstraints = false
        safe = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.statusView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            self.statusView.leadingAnchor.constraint(equalTo: safe.leadingAnchor), // 12
            self.statusView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.statusView.heightAnchor.constraint(equalToConstant: 30),
        ])
        

        // 2. 音量
        aRect.size.width = 300
        aRect.size.height = 50
        self.voiceIOMeter = LevelMeterView(frame: aRect)
        self.contentView.addSubview(self.voiceIOMeter)
        
        self.voiceIOMeter.translatesAutoresizingMaskIntoConstraints = false
        safe = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.voiceIOMeter.topAnchor.constraint(equalTo: self.statusView.bottomAnchor, constant: 20),
            self.voiceIOMeter.leadingAnchor.constraint(equalTo: safe.leadingAnchor), // 12
            self.voiceIOMeter.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
            self.voiceIOMeter.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // 3. 按钮：继续/暂停
        aRect.size.width = 100
        aRect.size.height = 30
        self.recordButton = UIButton(frame: aRect)
        var s0 = "停止录音"
        var str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.recordButton.setTitle(str0, for: .normal)
        self.recordButton.setTitleColor(ConfigureOfColor.blueColor, for: .normal)
        
        var image = UIImage(systemName: "stop.fill")
        self.recordButton.setImage(image, for: .normal)
        
        self.contentView.addSubview(self.recordButton)
        self.recordButton.addTarget(self, action: #selector(stopRecording), for: .touchUpInside)
        
        switch status {
        case 0: // 录制中，对应操作：停止
            self.recordButton.isHidden = false
            
            break
            
        case 1, 2: // 停止中，隐藏按钮
            self.recordButton.isHidden = true
            break
            
        default:
            self.recordButton.isHidden = false
            break
        }
        
        self.recordButton.translatesAutoresizingMaskIntoConstraints = false
        safe = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.recordButton.topAnchor.constraint(equalTo: self.voiceIOMeter.bottomAnchor, constant: 12), // 12
            self.recordButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 4),
            self.recordButton.heightAnchor.constraint(equalToConstant: 30),
            self.recordButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        
        // 播放
        self.playButton = UIButton(frame: aRect)
        s0 = "播放录音"
        str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.playButton.setTitle(str0, for: .normal)
        self.playButton.setTitleColor(ConfigureOfColor.blueColor, for: .normal)
        
        image = UIImage(systemName: "play.fill")
        self.playButton.setImage(image, for: .normal)

        self.contentView.addSubview(self.playButton)
        self.playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        
        self.playButton.isHidden = true // 隐藏

        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        safe = self.contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.playButton.topAnchor.constraint(equalTo: self.voiceIOMeter.bottomAnchor, constant: 12), // 12
            self.playButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -4),
            self.playButton.heightAnchor.constraint(equalToConstant: 30),
            self.playButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
    }
    
    var contentView: UIView!
    
    func setupAudioSession(sampleRate: Double) {
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(.playAndRecord, options: .defaultToSpeaker)
        } catch {
            print("Could not set the audio category: \(error.localizedDescription)")
        }

        do {
            try session.setPreferredSampleRate(sampleRate)
        } catch {
            print("Could not set the preferred sample rate: \(error.localizedDescription)")
        }
    }
    
    func setupAudioEngine() {
        do {
            audioEngine = try AudioEngine()

            voiceIOMeter.levelProvider = audioEngine.voiceIOPowerMeter

            setupAudioSession(sampleRate: audioEngine.voiceIOFormat.sampleRate)

            audioEngine.setup()
            audioEngine.start()
            
            // 启动计时器
            self.secondCount = 0 // 秒
            self.recordingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(soundRecordingTotolTime), userInfo: nil, repeats: true)

        } catch {
            fatalError("Could not set up the audio engine: \(error)")
        }
    }
    
    @objc func soundRecordingTotolTime() {
        self.secondCount += 1
        
        //  判断是否录制超时
        if secondCount == SettingsBundleHelper.fetchMaxTimeOfClassNoteVideo() * 60 {
            // 停止录音
            self.stopRecording()
        }

       
        // 分
        let mintues = (secondCount % 3600) / 60
        
        // 秒
        let seconds = secondCount % 60
 
        // 文本：计时器
        let str = String(format:"%02d", mintues) + " : " + String(format:"%02d", seconds)
        
        DispatchQueue.main.async {
            self.statusView.countLabel?.text = str
//            self.recordingTimeLabel.text = str
        }
    }
    
    func resetUIStates() {
        fxSwitch.setOn(false, animated: true)
        speechSwitch.setOn(false, animated: true)
        bypassSwitch.setOn(false, animated: true)
        
        recordButton.setTitle(ButtonTitles.record.rawValue, for: .normal)
        recordButton.isEnabled = true
        playButton.setTitle(ButtonTitles.play.rawValue, for: .normal)
        playButton.isEnabled = false
    }
    
    func resetAudioEngine() {
        audioEngine = nil
    }
    
    @objc
    func handleInterruption(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else { return }
        
        switch type {
        case .began:
            // Interruption begins so you need to take appropriate actions.
            if let isRecording = audioEngine?.isRecording, isRecording {
                recordButton.setTitle(ButtonTitles.record.rawValue, for: .normal)
            }
            audioEngine?.stopRecordingAndPlayers()
            
            fxSwitch.setOn(false, animated: true)
            speechSwitch.setOn(false, animated: true)
            playButton.setTitle(ButtonTitles.record.rawValue, for: .normal)
            playButton.isEnabled = false
        case .ended:
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Could not set the audio session to active: \(error)")
            }
            
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    // Interruption ends. Resume playback.
                } else {
                    // Interruption ends. Don't resume playback.
                }
            }
        @unknown default:
            fatalError("Unknown type: \(type)")
        }
    }
    
    @objc
    func handleRouteChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue),
            let routeDescription = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription else { return }
        switch reason {
        case .newDeviceAvailable:
            print("newDeviceAvailable")
        case .oldDeviceUnavailable:
            print("oldDeviceUnavailable")
        case .categoryChange:
            print("categoryChange")
            print("New category: \(AVAudioSession.sharedInstance().category)")
        case .override:
            print("override")
        case .wakeFromSleep:
            print("wakeFromSleep")
        case .noSuitableRouteForCategory:
            print("noSuitableRouteForCategory")
        case .routeConfigurationChange:
            print("routeConfigurationChange")
        case .unknown:
            print("unknown")
        @unknown default:
            fatalError("Really unknown reason: \(reason)")
        }
        
        print("Previous route:\n\(routeDescription)")
        print("Current route:\n\(AVAudioSession.sharedInstance().currentRoute)")
    }
    
    @objc
    func handleMediaServicesWereReset(_ notification: Notification) {
        resetUIStates()
        resetAudioEngine()
        setupAudioEngine()
    }
    
    @objc func fxSwitchPressed(_ sender: UISwitch) {
        audioEngine?.checkEngineIsRunning()
        
        print("FX Switch pressed.")
        audioEngine?.fxPlayerPlay(sender.isOn)
    }
    
    @objc func speechSwitchPressed(_ sender: UISwitch) {
        audioEngine?.checkEngineIsRunning()
        
        print("Speech Switch pressed.")
        audioEngine?.speechPlayerPlay(sender.isOn)
    }
    
    @objc func bypassSwitchPressed(_ sender: UISwitch) {
        print("Bypass Switch pressed.")
        audioEngine?.bypassVoiceProcessing(sender.isOn)
    }
    
    @objc func recordPressed() {
        print("Record button pressed.")
        audioEngine?.checkEngineIsRunning()
        audioEngine?.toggleRecording()

        if let isRecording = audioEngine?.isRecording, isRecording {
//            sender.setTitle(ButtonTitles.stop.rawValue, for: .normal)
//            playButton.isEnabled = false
        } else {
//            sender.setTitle(ButtonTitles.record.rawValue, for: .normal)
//            playButton.isEnabled = true
        }
    }
    
    @objc func playPressed() {
        print("Play button pressed.")
        audioEngine?.checkEngineIsRunning()
        audioEngine?.togglePlaying()

        if let isPlaying = audioEngine?.isPlaying, isPlaying {
//            fxSwitch.setOn(false, animated: true)
//            speechSwitch.setOn(false, animated: true)

//            playButton.setTitle(ButtonTitles.stop.rawValue, for: .normal)
//            recordButton.isEnabled = false
        } else {
//            playButton.setTitle(ButtonTitles.play.rawValue, for: .normal)
//            recordButton.isEnabled = true
        }
    }
    
    /// 重新录音
    ///
    /// 执行
    /// 1. 删除当前的录音
    /// 2. 重新录音
    /// 3. 启动计时器
    ///
    /// 入口条件
    /// 1. 如果正在录音，则停止
    /// 2. 如果正在播放录音，则停止播放
    /// 3. 满足上述条件，则启动录音
    @objc func restart() {
        print("重新录音 restart()")
        
        // 入口条件：停止录音
        self.stopRecoring()
        
        // 1. 删除当前的录音
        
        // 2. 重新录音
        // 2.1 状态、按钮
        self.restartRecording()
        self.status = 0
//        self.completeButton.isHidden = false
        self.playButton.isHidden = true
        
        // 2.2 启动录音
        self.recordPressed()
        
        // 3. 启动计时器
        self.secondCount = 0 // 秒
        self.recordingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(soundRecordingTotolTime), userInfo: nil, repeats: true)
    }
    
    
    /// 抛弃返回
    ///
    /// 执行
    /// 1. 删除当前的录音
    /// 2. 返回
    ///
    /// 入口条件
    /// - 如果正在录音，则停止
    @objc func deleteAndReturn() {
        print("抛弃返回 deleteAndReturn()")
        
        // 入口条件：停止录音
        stopRecoring()
        
        // 1. 删除当前的录音
        
        // 2. 返回
        self.closeNote()
    }
    
    /// 完成保存
    ///
    /// 执行
    /// 1. 停止录音
    /// 2. 保存当前的录音
    ///
    /// 入口条件
    /// - 如果正在录音，则停止
    /*
    @objc func complete() {
        print("完成保存 complete()")
        
        // 入口条件：停止录音
        self.stopRecoring()
        
        // 1. 停止录音
        // 1.1 停止
        // 1.2 显示
        self.statusView.drawStop()
        self.status = 2 // 停止
        self.recordButton.isHidden = true
        self.completeButton.isHidden = true
        self.playButton.isHidden = false

        // 2. 保存
        self.saveNote()
    }
*/
    
    
    /// 停止录音
    ///
    /// 公用方法
    func stopRecoring() {
        audioEngine.stopRecordingAndPlayers()
    }
    
    /// 停止录音
    ///
    /// 操作
    /// - 计时器：停止
    /// - 录音停止
    /// - 状态显示：停止中
    /// - 按钮显示：隐藏
    /// - 播放按钮：显示
    /// - 状态：停止 = 2
    @objc func stopRecording() {
        // 停止计时
        self.recordingTimer?.invalidate()
        
        // 停止录音
        self.stopRecoring()
        
        // 界面显示：停止中
        self.showRecordingStop()
        
        // 状态
        self.status = 2
        
        // 播放按钮：显示
        self.playButton.isHidden = false
    }
    
    /// 界面显示：停止中
    /// - 状态显示：停止中
    /// - 按钮显示：隐藏
    func showRecordingStop() {
        // 状态显示：停止中
        self.statusView.drawStop()
        
        // 按钮显示：隐藏
        self.recordButton.isHidden = true
    }
    
    /// 界面显示：录音中
    /// - 状态显示：录音中
    /// - 按钮显示：显示
    func showRecording() {
        // 状态显示：停止中
        self.statusView.drawRecord()
        
        // 按钮显示：显示
        self.recordButton.isHidden = false
    }
    
    /// 重启录音
    ///
    /// 操作
    /// - 录音停止
    /// - 状态显示：录音中
    /// - 按钮显示：显示
    @objc func restartRecording() {
        // 界面显示：录音中
        self.showRecording()
    }

}

