//
//  SettingsBundleHelper.swift
//  M-Elf
// 3694
//  Created by 范志勇 on 2019/6/13.
//  Copyright © 2019 范志勇. All rights reserved.
//

import Foundation

extension Notification.Name {
    // xml文件：加密
    static let nickName = Notification.Name("nickName")
    static let sendPersonInfoToServer = Notification.Name("sendPersonInfoToServer")
    
    static let loginName = Notification.Name("loginName")
}

class SettingsBundleHelper {
    // ServerURL：http://www.liyuexingzhi.com
    class func fetchServerURL() -> String {
        return "http://www.liyuexingzhi.com/"
    }
    
    // ServerURLWithApptrans：http://www.liyuexingzhi.com/apptrans
    class func fetchServerURLWithApptrans() -> String {
        return "http://www.liyuexingzhi.com/apptrans"
    }
    
    struct SettingsBundleKeys {
        // 视唱
        static let wordOfTrainSpeechRecognize = "wordOfTrainSpeechRecognize"

        // 上传给老师：进度
        static let progress_totalUnitCount = "progress_totalUnitCount"
        static let progress_completedUnitCount = "progress_completedUnitCount"
        static let progress_fractionCompleted = "progress_fractionCompleted"
        static let response_statusCode = "response_statusCode"

        // 从分析中心返回
        static let actionOfPlayingViolinFromAnalysis = "actionOfPlayingViolinFromAnalysis"
        static let actionOfPlayingSightsingingFromAnalysis = "actionOfPlayingSightsingingFromAnalysis"

        // 视唱
        static let modeOfPlayingSightsinging = "modeOfPlayingSightsinging"

        // 找音
        static let needCheckedNoteTag = "needCheckedNoteTag"
        
        // 购买成功
        static let productIDPuchasedSuccesfully = "productIDPuchasedSuccesfully"
        static let productNamePuchasedSuccesfully = "productNamePuchasedSuccesfully"

        // 视唱：倒计时，数量
        static let countDownNumberOfSightSinging = "countDownNumberOfSightSinging"
        
        // 播放：音量调整，浮点数
        static let volume_zoom = "volume_zoom"
        
        // 演奏：audioIdxWhileStartToPlay
        static let audioIdxWhileStartToPlay = "audioIdxWhileStartToPlay"
        
        // 最新的录音文件
        static let latestRecordFile = "latestRecordFile"
        
        // 是否响应声控
        static let isResponseOnSpeechControl = "isResponseOnSpeechControl"
        
        // 服务器可访问吗
        static let isServerReachable = "isServerReachable"
        
        // 宽限期还剩几天：Grace-Period-Remaining
        static let gracePeriodRemaining = "gracePeriodRemaining"
        // 宽限结束日期：Grace-Expiration-Date
        static let graceExpirationDate = "graceExpirationDate"
        static let graceExpirationDateMs = "graceExpirationDateMs"

        // 注册用户，控制：剩余可用天数、剩余可下载乐谱数
        // 剩余可用天数：restUsableDays, experiencePeriodRemaining
        static let experiencePeriodRemaining = "experiencePeriodRemaining"
        // 剩余可下载乐谱数：restNumberOfDownloadableScores, experienceScoreRemaining
        static let experienceScoreRemaining = "experienceScoreRemaining"

        // 要下载的乐谱ID
        static let downloadingScoreID = "downloadingScoreID"

        // 正在支付：isOnPaying
        static let isOnPaying = "isOnPaying"

        // entitlement
        static let entitlement = "entitlement"
        static let entitlementCode = "entitlementCode"

        // latestReceipt
        static let latestReceipt = "latestReceipt"
        static let latestReceiptExpiresDateMs = "latestReceiptExpiresDateMs" // 有效期

        // 乐谱下载数量
        static let countOfDownloadedScores = "countOfDownloadedScores"

        // 停顿
        static let caesuraTime = "caesuraTime"
        
        // 语音控制：系统级间隔
        static let scoreDataCount = "scoreDataCount"

        // 无声停止：noSoundSecond
        static let noSoundSecond = "noSoundSecond"
        static let noSoundSecondForSightSinging = "noSoundSecondForSightSinging"
        static let noSoundSecondForFindThePitchs = "noSoundSecondForFindThePitchs"
        
        // 音量阈值
        // 音量阈值（Float）：找音，低于此值，则视为无声
        static let minVolForFindThePitchs = "minVolForFindThePitchs"

        // 找音：FindThePitchs
        static let currThreadIdxForFindThePitchs = "currThreadIdxForFindThePitchs"
        static let idxCurrentForFindThePitchs = "idxCurrentForFindThePitchs"
        
        // 注册、登录
        static let userID = "userID"
        static let secretKey = "secretKey"
        static let moblePhone = "moblePhone"
        static let email = "email"
        static let loginName = "loginName"
        static let loginPassword = "loginPassword"

        // 加密后
        static let secretKeyEn = "secretKeyEn"
        static let currentTimeEn = "currentTimeEn"

        
        static let userLogin = "UserLogin"
        static let nickName = "nickName"
        static let target = "hobby"
        static let birth = "birth"

        
        static let aFrequency = "AFrequency"
        static let vibratoBelowLevel3 = "vibratoBelowLevel3"

        static let isAllGuideDisplay = "IsAllGuideDisplay"

        static let findPitchSection1 = "FindPitchSection1"
        static let findPitchSection2 = "FindPitchSection2"
        
        static let minVolumn = "MinVolumn"
        static let minVolumnString = "MinVolumnString"
        static let tuneSoundCatalog = "TuneSoundCatalog"
        
        static let maxTimeOfClassNoteSound = "MaxTimeOfClassNoteSound"
        static let maxTimeOfClassNoteVideo = "MaxTimeOfClassNoteVideo"
        
        static let autoCleanToggle = "AutoCleanToggle"
        static let autoCleanTime = "AutoCleanTime"
    }
    
    // 回课笔记，未归档的回课笔记：自动清理的时间
    class func fetchAutoCleanTime() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.autoCleanTime) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.autoCleanTime)
        } else {
            UserDefaults.standard.set(30, forKey: SettingsBundleKeys.autoCleanTime)
            return 30
        }
    }
    
    class func saveAutoCleanTime(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.autoCleanTime)
    }
    
    // 回课笔记，未归档的回课笔记：自动清理开关，缺省为打开
    class func fetchAutoCleanToggle() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.autoCleanToggle) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.autoCleanToggle)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.autoCleanToggle)
            return 0
        }
    }
    
    class func saveAutoCleanToggle(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.autoCleanToggle)
    }
    
    class func fetchMaxTimeOfClassNoteSound() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.maxTimeOfClassNoteSound) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.maxTimeOfClassNoteSound)
        } else {
            UserDefaults.standard.set(3, forKey: SettingsBundleKeys.maxTimeOfClassNoteSound)
            return 3
        }
    }
    
    class func saveMaxTimeOfClassNoteSound(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.maxTimeOfClassNoteSound)
    }
    
    class func fetchMaxTimeOfClassNoteVideo() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.maxTimeOfClassNoteVideo) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.maxTimeOfClassNoteVideo)
        } else {
            UserDefaults.standard.set(1, forKey: SettingsBundleKeys.maxTimeOfClassNoteVideo)
            return 1
        }
    }
    
    class func saveMaxTimeOfClassNoteVideo(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.maxTimeOfClassNoteVideo)
    }

    
    class func fetchWordOfTrainSpeechRecognize() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.wordOfTrainSpeechRecognize) {
            return result
        } else {
            return nil
        }
    }

    class func saveWordOfTrainSpeechRecognize(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.wordOfTrainSpeechRecognize)
    }
    
    // 上传给老师：进度
    class func fetchResponse_statusCode() -> Int {
        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.response_statusCode)
        return result
    }
    
    class func saveResponse_statusCode(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.response_statusCode)
    }

    class func fetchProgress_totalUnitCount() -> Int {
        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.progress_totalUnitCount)
        return result
    }
    
    class func saveProgress_totalUnitCount(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.progress_totalUnitCount)
    }

    class func fetchProgress_completedUnitCount() -> Int {
        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.progress_completedUnitCount)
        return result
    }
    
    class func saveProgress_completedUnitCount(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.progress_completedUnitCount)
    }

    class func fetchProgress_fractionCompleted() -> Double {
        let result = UserDefaults.standard.double(forKey: SettingsBundleKeys.progress_fractionCompleted)
        return result
    }
    
    class func saveProgress_fractionCompleted(_ value: Double) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.progress_fractionCompleted)
    }

    // 从分析中心返回：演奏，1：再来，2：继续
    class func fetchActionOfPlayingViolinFromAnalysis() -> Int {
        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.actionOfPlayingViolinFromAnalysis)
        return result
    }
    
    class func saveActionOfPlayingViolinFromAnalysis(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.actionOfPlayingViolinFromAnalysis)
    }
    
    // 从分析中心返回：视唱，1：再来，2：继续
    class func fetchActionOfPlayingSightsingingFromAnalysis() -> Int {
        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.actionOfPlayingSightsingingFromAnalysis)
        return result
    }
    
    class func saveActionOfPlayingSightsingingFromAnalysis(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.actionOfPlayingSightsingingFromAnalysis)
    }

    
    // 视唱：等待第一音（0），定时开始（1）
    class func fetchModeOfPlayingSightsinging() -> Int {
        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.modeOfPlayingSightsinging)
        return result
    }
    
    class func saveModeOfPlayingSightsinging(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.modeOfPlayingSightsinging)
    }
    
    // 找音
    class func fetchNeedCheckedNoteTag() -> Int {
        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.needCheckedNoteTag)
        return result
    }
    
    class func saveNeedCheckedNoteTag(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.needCheckedNoteTag)
    }
    
    // =====================================
    // 购买服务成功的product：productIDPuchasedSuccesfully
//    class func fetchProductIDPuchasedSuccesfully() -> Int {
//        let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.productIDPuchasedSuccesfully)
//        return result
//        if let result = UserDefaults.standard.integer(forKey: SettingsBundleKeys.productIDPuchasedSuccesfully) {
//            return result
//        } else {
//            return nil
//        }
//    }
    
    class func fetchProductIDPuchasedSuccesfully() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.needCheckedNoteTag) {
            return result
        } else {
            return nil
        }
    }

    class func saveProductIDPuchasedSuccesfully(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.productIDPuchasedSuccesfully)
    }
    
    class func fetchProductNamePuchasedSuccesfully() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.productNamePuchasedSuccesfully) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveProductNamePuchasedSuccesfully(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.productNamePuchasedSuccesfully)
    }
    
    // =====================================
    // 视唱，倒计时数量：countDownNumberOfSightSinging
    class func fetchCountDownNumberOfSightSinging() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.countDownNumberOfSightSinging) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.countDownNumberOfSightSinging)
        } else {
            UserDefaults.standard.set(2, forKey: SettingsBundleKeys.countDownNumberOfSightSinging)
            return 2
        }
    }
    
    class func saveCountDownNumberOfSightSinging(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.countDownNumberOfSightSinging)
    }
    
    // =====================================
    // 演奏：volume_zoom
    class func fetchVolumeZoom() -> Float {
        if UserDefaults.standard.float(forKey: SettingsBundleKeys.volume_zoom) != 0 {
            return UserDefaults.standard.float(forKey: SettingsBundleKeys.volume_zoom)
        } else {
            UserDefaults.standard.set(5.0, forKey: SettingsBundleKeys.volume_zoom)
            return 5.0
        }
    }
    
    class func saveVolumeZoom(_ value: Float) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.volume_zoom)
    }

    // =====================================
    // 演奏：audioIdxWhileStartToPlay
    class func fetchAudioIdxWhileStartToPlay() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.audioIdxWhileStartToPlay) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.audioIdxWhileStartToPlay)
        } else {
            UserDefaults.standard.set(-1, forKey: SettingsBundleKeys.audioIdxWhileStartToPlay)
            return -1
        }
    }
    
    class func saveAudioIdxWhileStartToPlay(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.audioIdxWhileStartToPlay)
    }

    // =====================================
    // 最新的录音文件：latestRecordFile
    class func fetchLatestRecordFile() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.latestRecordFile) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveLatestRecordFile(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.latestRecordFile)
    }
    
    // =====================================
    // 是否响应声控
    class func fetchIsResponseOnSpeechControl() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.isResponseOnSpeechControl) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.isResponseOnSpeechControl)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.isResponseOnSpeechControl)
            return 0
        }
    }
    
    class func saveIsResponseOnSpeechControl(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.isResponseOnSpeechControl)
    }

    // =====================================
    // 服务器可访问吗
    class func fetchIsServerReachable() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.isServerReachable) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.isServerReachable)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.isServerReachable)
            return 0
        }
    }
    
    class func saveIsServerReachable(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.isServerReachable)
    }

    // =====================================
    // 要下载的乐谱ID
    class func fetchDownloadingScoreID() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.downloadingScoreID) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.downloadingScoreID)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.downloadingScoreID)
            return 0
        }
    }
    
    class func saveDownloadingScoreID(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.downloadingScoreID)
    }

    // =====================================
    // 宽限期还剩几天：Grace-Period-Remaining
    class func fetchGracePeriodRemaining() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.gracePeriodRemaining) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.gracePeriodRemaining)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.gracePeriodRemaining)
            return 0
        }
    }
    
    class func saveGracePeriodRemaining(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.gracePeriodRemaining)
    }

    // 宽限结束日期：Grace-Expiration-Date
    class func fetchGraceExpirationDate() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.graceExpirationDate) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveGraceExpirationDate(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.graceExpirationDate)
    }
    
    class func fetchGraceExpirationDateMs() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.graceExpirationDateMs) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveGraceExpirationDateMs(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.graceExpirationDateMs)
    }
    
    // =====================================
    // 注册用户，控制：剩余可用天数、剩余可下载乐谱数
    // 剩余可用天数：experiencePeriodRemaining
    class func fetchExperiencePeriodRemaining() -> Int {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.experiencePeriodRemaining) {
            // 如果字符串转换为整型发生错误，则为10。一般不会发生
            return Int(result) ?? 10
        } else {
            // 最初为30天
            return 30
        }
    }
    
    class func saveExperiencePeriodRemaining(_ value: String) {
        // 使用字符串而不用整型，为了避免整型在最初缺省时为0
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.experiencePeriodRemaining)
    }
    
    // 剩余可下载乐谱数：experienceScoreRemaining
    class func fetchExperienceScoreRemaining() -> Int {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.experienceScoreRemaining) {
            // 如果字符串转换为整型发生错误，则为10。一般不会发生
            return Int(result) ?? 10
        } else {
            // 最初为30个
            return 30
        }
    }
    
    class func saveExperienceScoreRemaining(_ value: String) {
        // 使用字符串而不用整型，为了避免整型在最初缺省时为0
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.experienceScoreRemaining)
    }

    // =====================================
    // 是否正在支付
    class func fetchIsOnPaying() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.isOnPaying) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.isOnPaying)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.isOnPaying)
            return 0
        }
    }
    
    class func saveIsOnPaying(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.isOnPaying)
    }
    
    // =====================================
    // Entitlement
    class func fetchEntitlement() -> Data? {
        if let result = UserDefaults.standard.object(forKey: SettingsBundleKeys.entitlement) as? Data {
            return result
        } else {
            return nil
        }
    }
    
    class func saveEntitlement(_ value: Data) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.entitlement)
    }
    
    // EntitlementCode
    class func fetchEntitlementCode() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.entitlementCode) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveEntitlementCode(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.entitlementCode)
    }
    
    // =====================================
    // LatestReceipt
    class func fetchLatestReceipt() -> Data? {
        if let result = UserDefaults.standard.object(forKey: SettingsBundleKeys.latestReceipt) as? Data {
            return result
        } else {
            return nil
        }
    }
    
    class func saveLatestReceipt(_ value: Data) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.latestReceipt)
    }
    
    class func fetchLatestReceiptExpiresDateMs() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.latestReceiptExpiresDateMs) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.latestReceiptExpiresDateMs)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.latestReceiptExpiresDateMs)
            return 0
        }
    }
    
    class func saveLatestReceiptExpiresDateMs(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.latestReceiptExpiresDateMs)
    }

    // =====================================
    // 乐谱下载数量：只要下载就累加，删除乐谱不削减
    class func fetchCountOfDownloadedScores() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.countOfDownloadedScores) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.countOfDownloadedScores)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.countOfDownloadedScores)
            return 0
        }
    }
    
    class func addCountOfDownloadedScores() {
        var value = fetchCountOfDownloadedScores()
        value += 1
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.countOfDownloadedScores)
    }

    class func saveCountOfDownloadedScores(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.countOfDownloadedScores)
    }
    

    // =====================================
    // 无声
    static var caesuraTimes: [Double] = [0.2, 0.3, 0.4, 0.5] // 暂设置为3个
    class func fetchCaesuraTime() -> Double {
        if UserDefaults.standard.double(forKey: SettingsBundleKeys.caesuraTime) != 0 {
            return UserDefaults.standard.double(forKey: SettingsBundleKeys.caesuraTime)
        } else {
            UserDefaults.standard.set(0.3, forKey: SettingsBundleKeys.caesuraTime)
            return 0
        }
    }
    
    class func saveCaesuraTime(_ value: Double) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.caesuraTime)
    }

    // =====================================
    class func fetchScoreDataCount() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.scoreDataCount) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.scoreDataCount)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.scoreDataCount)
            return 0
        }
    }
    
    class func saveScoreDataCount(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.scoreDataCount)
    }
    
    // =====================================
    // 音量阈值
    static var minVolForFindThePitchs: [Float] = [0.01, 0.02, 0.04, 0.05, 0.1] // 暂设置为5个
    class func fetchMinVolForFindThePitchs() -> Float {
        if UserDefaults.standard.float(forKey: SettingsBundleKeys.minVolForFindThePitchs) != 0 {
            return UserDefaults.standard.float(forKey: SettingsBundleKeys.minVolForFindThePitchs)
        } else {
            UserDefaults.standard.set(0.02, forKey: SettingsBundleKeys.minVolForFindThePitchs)
            return 0.02
        }
    }
    
    class func saveMinVolForFindThePitchs(_ value: Float) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.minVolForFindThePitchs)
    }
    
    // 无声
    static var noSoundSeconds: [Float] = [1.0, 1.5, 2.0] // 暂设置为3个
    class func fetchNoSoundSecond() -> Float {
        if UserDefaults.standard.float(forKey: SettingsBundleKeys.noSoundSecond) != 0 {
            return UserDefaults.standard.float(forKey: SettingsBundleKeys.noSoundSecond)
        } else {
            UserDefaults.standard.set(2.0, forKey: SettingsBundleKeys.noSoundSecond)
            return 2.0
        }
    }
    
    class func saveNoSoundSecond(_ value: Float) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.noSoundSecond)
    }
    
    static var noSoundSecondsForSightSinging: [Float] = [1.0, 1.5, 2.0] // 暂设置为3个
    class func fetchNoSoundSecondForSightSinging() -> Float {
        if UserDefaults.standard.float(forKey: SettingsBundleKeys.noSoundSecondForSightSinging) != 0 {
            return UserDefaults.standard.float(forKey: SettingsBundleKeys.noSoundSecondForSightSinging)
        } else {
            UserDefaults.standard.set(1.0, forKey: SettingsBundleKeys.noSoundSecondForSightSinging)
            return 1.0
        }
    }
    
    class func saveNoSoundSecondForSightSinging(_ value: Float) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.noSoundSecondForSightSinging)
    }
    
    static var noSoundSecondsForFindThePitchs: [Float] = [1.0, 1.5, 2.0, 4.0, 5.0, 8.0, 10.0, 20.0, 30.0] // 多个
    class func fetchNoSoundSecondForFindThePitchs() -> Float {
        if UserDefaults.standard.float(forKey: SettingsBundleKeys.noSoundSecondForFindThePitchs) != 0 {
            return UserDefaults.standard.float(forKey: SettingsBundleKeys.noSoundSecondForFindThePitchs)
        } else {
            UserDefaults.standard.set(4.0, forKey: SettingsBundleKeys.noSoundSecondForFindThePitchs)
            return 4.0
        }
    }
    
    class func saveNoSoundSecondForFindThePitchs(_ value: Float) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.noSoundSecondForFindThePitchs)
    }
    
    // =====================================
    class func fetchCurrThreadIdxForFindThePitchs() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.currThreadIdxForFindThePitchs) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.currThreadIdxForFindThePitchs)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.currThreadIdxForFindThePitchs)
            return 0
        }
    }
    
    class func saveCurrThreadIdxForFindThePitchs(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.currThreadIdxForFindThePitchs)
    }
    
    // =====================================
    class func fetchIdxCurrentForFindThePitchs() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.idxCurrentForFindThePitchs) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.idxCurrentForFindThePitchs)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.idxCurrentForFindThePitchs)
            return 0
        }
    }
    
    class func saveIdxCurrentForFindThePitchs(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.idxCurrentForFindThePitchs)
    }
    
    // =====================================
    class func fetchCurrentTimeEn() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.currentTimeEn) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveCurrentTimeEn(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.currentTimeEn)
    }
    
    // =====================================
//    class func fetchSecretKeyEn() -> [UInt8]? {
//        if let result = UserDefaults.standard.data(forKey: SettingsBundleKeys.secretKeyEn)?.bytes {
//            return result
//        } else {
//            return nil
//        }
//    }

    class func saveSecretKeyEn(_ value: [UInt8]) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.secretKeyEn)
    }
    
    // =====================================
    class func fetchBirth() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.birth) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.birth)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.birth)
            return 0
        }
    }
    
    class func saveBirth(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.birth)
    }
    
    // =====================================
    class func fetchMoblePhone() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.moblePhone) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveMoblePhone(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.moblePhone)
    }
    
    // =====================================
    class func fetchEmail() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.email) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveEmail(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.email)
    }
    
    // =====================================
    class func fetchLoginName() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.loginName) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveLoginName(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.loginName)
    }
    
    // =====================================
    class func fetchLoginPassword() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.loginPassword) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveLoginPassword(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.loginPassword)
    }
    
    // =====================================
    class func fetchUserID() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.userID) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.userID)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.userID)
            return 0
        }
    }
    
    class func saveUserID(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.userID)
    }
    
    // =====================================
    class func fetchSecretKey() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.secretKey) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveSecretKey(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.secretKey)
    }
    
    // =====================================
    class func fetchUserLogin() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.userLogin) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.userLogin)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.userLogin)
            return 0
        }
    }
    
    class func saveUserLogin(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.userLogin)
    }

    // =====================================
    class func fetchTarget() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.target) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.target)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.target)
            return 0
        }
    }
    
    class func saveTarget(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.target)
    }
    
    // =====================================
    class func fetchNickName() -> String? {
        if let result = UserDefaults.standard.string(forKey: SettingsBundleKeys.nickName) {
            return result
        } else {
            return nil
        }
    }
    
    class func saveNickName(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.nickName)
    }
    
    // =====================================
    class func fetchVibratoBelowLevel3() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.vibratoBelowLevel3) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.vibratoBelowLevel3)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.vibratoBelowLevel3)
            return 0
        }
    }
    
    class func saveVibratoBelowLevel3(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.vibratoBelowLevel3)
    }
    

    // ============== 校音 =========================
    static var tuningSection = ["标准A频率", "音量大小", "声音种类"] // 暂设置为3个
    // ============== 基准音：A
    static var aFrencies = [440, 442] // 暂设置为3个
    
    class func fetchAFrequency() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.aFrequency) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.aFrequency)
        } else {
            UserDefaults.standard.set(440, forKey: SettingsBundleKeys.aFrequency)
            return 440
        }
    }
    
    class func saveAFrequency(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.aFrequency)
    }
    
    // ============== 最小音量
    static var minVolumns: [Float] = [0.002, 0.004, 0.01, 0.02] // 暂设置为4个
    static var minVolumnStrings = ["小声", "中声", "大声", "更大声"] // 暂设置为4个

    class func fetchMinVolumnString() -> String {
        if UserDefaults.standard.string(forKey: SettingsBundleKeys.minVolumnString) != nil {
            return UserDefaults.standard.string(forKey: SettingsBundleKeys.minVolumnString)!
        } else {
            UserDefaults.standard.set("中声", forKey: SettingsBundleKeys.minVolumnString)
            return "中声"
        }
    }
    
    class func saveMinVolumnString(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.minVolumnString)
    }
    
    class func fetchMinVolumn() -> Float {
        if UserDefaults.standard.float(forKey: SettingsBundleKeys.minVolumn) != 0 {
//            print("fetchMinVolumn: \(UserDefaults.standard.float(forKey: SettingsBundleKeys.minVolumn))")
            return UserDefaults.standard.float(forKey: SettingsBundleKeys.minVolumn)
        } else {
//            print("fetchMinVolumn: 0.004")
            UserDefaults.standard.set(0.004, forKey: SettingsBundleKeys.minVolumn)
            return 0.004
        }
    }
    
    class func saveMinVolumn(_ value: Float) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.minVolumn)
    }
    
    class func saveMinVolumn(_ str: String) {
        if let index = minVolumnStrings.index(of: str) {
            let value = minVolumns[index]
            UserDefaults.standard.set(value, forKey: SettingsBundleKeys.minVolumn)
        }
    }
    
    // ============== 校音中播放声音的种类
//    static var tuneSoundCatalogs = ["用手拨弦声", "用弓拉弦声"] // 暂设置为2个
    static var tuneSoundCatalogs: [String] { // 暂设置为2个
        var result = [String]()
        var s0 = "用手拨弦声"
        var str0 = NSLocalizedString(s0, tableName: "tuning", value: s0, comment: s0)
        result.append(str0)

        s0 = "用弓拉弦声"
        str0 = NSLocalizedString(s0, tableName: "tuning", value: s0, comment: s0)
        result.append(str0)
        
        return result
    }

    class func fetchTuneSoundCatalog() -> String {
        if UserDefaults.standard.string(forKey: SettingsBundleKeys.tuneSoundCatalog) != nil {
            return UserDefaults.standard.string(forKey: SettingsBundleKeys.tuneSoundCatalog)!
        } else {
            UserDefaults.standard.set(tuneSoundCatalogs[0], forKey: SettingsBundleKeys.tuneSoundCatalog)
            return tuneSoundCatalogs[0]
        }
    }
    
    class func saveTuneSoundCatalogg(_ value: String) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.tuneSoundCatalog)
    }
    
    // ============== 找音练习
    static var findPitchSection = ["找出一个音符的最长时间（秒）", "保持一个音高的最短时间（秒）"] // 暂设置为2个
    static var findPitchSection1 = [5, 10, 15, 20, 30] // 适应初级找音
    static var findPitchSection2 = [0.3, 0.5, 1, 2] // 适应初级找音

    class func fetchFindPitchSection1() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.findPitchSection1) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.findPitchSection1)
        } else {
            UserDefaults.standard.set(findPitchSection1.first!, forKey: SettingsBundleKeys.findPitchSection1)
            return findPitchSection1.first!
        }
    }
    
    class func fetchFindPitchSection2() -> Double {
        if UserDefaults.standard.double(forKey: SettingsBundleKeys.findPitchSection2) != 0 {
            return UserDefaults.standard.double(forKey: SettingsBundleKeys.findPitchSection2)
        } else {
            UserDefaults.standard.set(findPitchSection2.first!, forKey: SettingsBundleKeys.findPitchSection2)
            return findPitchSection2.first!
        }
    }
    
    class func saveFindPitchSection1(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.findPitchSection1)
    }

    class func saveFindPitchSection2(_ value: Double) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.findPitchSection2)
    }
    

    /// 所有的帮助指导，是否显示
    ///
    /// - Returns: 0，不显示所有；1，显示所有
    class func fetchIsAllGuideDisplay() -> Int {
        if UserDefaults.standard.integer(forKey: SettingsBundleKeys.isAllGuideDisplay) != 0 {
            return UserDefaults.standard.integer(forKey: SettingsBundleKeys.isAllGuideDisplay)
        } else {
            UserDefaults.standard.set(0, forKey: SettingsBundleKeys.isAllGuideDisplay)
            return 0
        }
    }
    
    class func saveIsAllGuideDisplay(_ value: Int) {
        UserDefaults.standard.set(value, forKey: SettingsBundleKeys.isAllGuideDisplay)
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference") // 版本
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference") // 构建
    }
    
    // ============== 乐谱标记 =========================
    static var markOfScoreSection = ["稍停顿", "延长记号"] // 暂设置为3个

    static var breakInSound = ["comma", "caesura"]
    static var breakInSoundValue = [0.2, 0.3]
    
    static var pauses = ["normal", "angled", "square"]
    static var pauseValues = [0.5, 1.0, 8.0]

    
}
