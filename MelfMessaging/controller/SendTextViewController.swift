//
//  SendTextViewController.swift
//  MelfMessaging
//
//  Created by 范志勇 on 2022/9/19.
//

import UIKit

class SendTextViewController: UIViewController, UITextViewDelegate {
    //MARK: 隐藏状态栏
    override var prefersStatusBarHidden: Bool { return true }
    
    // 入参：笔记的位置
//    var notePositon: MelfNotePosition?

    var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 0xFF/0xFF, green: 0x93/0xFF, blue: 0x7C/0xFF, alpha: 1.0)
        
        // Do any additional setup after loading the view.
        
        let s0 = "回课笔记：文字"
        let str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
        self.navigationItem.title = str0
        
        self.setupNavigatorBar()
        
        self.createInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 测试：数据库查询
//        if let results = DAOOfMelfNote.searchAllMelfNotes(idscore: (notePositon?.idscore)!, uid: (notePositon?.iduser)!) {
//            for result in results {
//                print(result.description)
//            }
//        }
        
    }
    
    ///设置导航栏
    ///
    ///设置项目
    ///- 存储
    ///- 删除
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
//        let deleteItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(deleteNote))
        
        // 加大间距
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 30 // adjust as needed
        
//        self.navigationItem.rightBarButtonItems = [saveItem, space, deleteItem]
        self.navigationItem.rightBarButtonItems = [saveItem, space, addNewNoteItem]

    }
    
    /// 关闭窗口
    @objc func closeNote() {
        self.contentTextView.endEditing(true)
        
        self.presentingViewController?.dismiss(animated: true)
    }

    /// 添加新的笔记
    ///
    /// 操作
    /// 1. 清除文字内容
    /// 2. melfNote_backup = nil
    /// 3. 新的
    @objc func addNewNote() {
        self.contentTextView.text = ""
        
        // 显示输入键盘
        self.contentTextView.becomeFirstResponder()
        
//        self.melfNote_backup = nil
    }
    
    /// 备份，用于区分数据库的操作：插入、更新
//    var melfNote_backup: MelfNote?
    ///存储笔记
    ///
    ///顺序做两件时间
    ///1. 存储内容
    ///2. 发出通知
    ///
    ///存储内容
    ///- 笔记
    ///- 时间：精确到秒
    ///- 乐谱
    ///- 乐谱位置：小节索引、音符索引
    @objc func saveNote() {
        /*
        self.contentTextView.endEditing(true)
        print(self.notePositon?.description)
        print(self.contentTextView.text)
        
        var melfNote = MelfNote(notePosition: self.notePositon!)
        melfNote.content = self.contentTextView.text
        melfNote.melfNoteType = 0
        melfNote.createTime = Int(Date().timeIntervalSince1970)
        
        if melfNote_backup == nil {
            // 插入
            if DAOOfMelfNote.insertNewMelfNote(melfNote: melfNote) == true {
                // 发出通知
                NotificationCenter.default.post(name: .melfNoteSave, object: self)
                
                print("saveNote 插入 OK")
                print(melfNote.description)
            }
        }  else {
            // 更新
            if DAOOfMelfNote.updateMelfNote(new: melfNote, old: melfNote_backup!) == true {
                // 发出通知
                NotificationCenter.default.post(name: .melfNoteSave, object: self)
                
                print("saveNote 更新 OK")
                print(melfNote.description)
            }
        }
        
        // 备份更新
        melfNote_backup = melfNote
        */
    }

    /// 删除笔记
    @objc func deleteNote() {
        self.contentTextView.endEditing(true)
    }
    
    /// 界面：输入文本
    func createInterface() {
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

        
        // text
        aRect = CGRect(x: 0, y: 0, width: 600, height: 380)
        self.contentTextView = UITextView(frame: aRect)
        self.contentTextView.backgroundColor = .clear
        self.contentTextView.textColor = .white
        self.contentTextView.font = UIFont.systemFont(ofSize: 32)

        self.view.addSubview(self.contentTextView)
        self.contentTextView.delegate = self
        
        self.contentTextView.translatesAutoresizingMaskIntoConstraints = false
//        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.contentTextView.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 50), // 12
            self.contentTextView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 12),
            self.contentTextView.heightAnchor.constraint(equalToConstant: 250),
            self.contentTextView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
        ])
        
        // 准备录入：显示键盘
        self.contentTextView.becomeFirstResponder()
        
        // 按钮
        self.setupTabButtons()
    }
    
    @objc func closeWindow() {
        self.presentingViewController?.dismiss(animated: true)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.contentTextView.textColor == UIColor.red {
            self.contentTextView.text = nil
            self.contentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.contentTextView.text.isEmpty {
            let s0 = "文字笔记"
            let str0 = NSLocalizedString(s0, tableName: "classNote", value: s0, comment: s0)
            self.contentTextView.text = str0
            self.contentTextView.textColor = UIColor.red
        }
    }
    
    var child: TabButtonsViewController!
    
    private func setupTabButtons() {
        child = TabButtonsViewController()
        child.isHighLight_text = true
        self.addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)

        
        let sz = child.preferredContentSize
        
        let safe = self.view.safeAreaLayoutGuide
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.widthAnchor.constraint(equalToConstant: sz.width),
            child.view.heightAnchor.constraint(equalToConstant: sz.height),
            child.view.topAnchor.constraint(equalTo: self.contentTextView.bottomAnchor, constant: 50),
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
