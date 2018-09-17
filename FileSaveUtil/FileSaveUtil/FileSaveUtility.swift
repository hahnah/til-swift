import AVFoundation

class FileSaveUtility {
    static func exportMovie(sourceURL: URL, destinationURL: URL, fileType: AVFileType) -> Void {
        
        let avAsset: AVAsset = AVAsset(url: sourceURL)
        
        // video と audio のトラックをそれぞれ取得
        let videoTrack: AVAssetTrack = avAsset.tracks(withMediaType: AVMediaType.video)[0]
        let audioTracks: [AVAssetTrack] = avAsset.tracks(withMediaType: AVMediaType.audio)
        let audioTrack: AVAssetTrack? =  audioTracks.count > 0 ? audioTracks[0] : nil
        
        let mainComposition : AVMutableComposition = AVMutableComposition()
        
        // video と audio のコンポジショントラックをそれぞれ作成
        let compositionVideoTrack: AVMutableCompositionTrack = mainComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!
        let compositionAudioTrack: AVMutableCompositionTrack? = audioTrack != nil
            ? mainComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
            : nil
        
        // コンポジションの設定
        try! compositionVideoTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, avAsset.duration), of: videoTrack, at: kCMTimeZero)
        try! compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(kCMTimeZero, avAsset.duration), of: audioTrack!, at: kCMTimeZero)
        
        // エクスポートするためのセッションを作成
        let assetExport = AVAssetExportSession.init(asset: mainComposition, presetName: AVAssetExportPresetMediumQuality)
        
        // エクスポートするファイルの種類を設定
        assetExport?.outputFileType = fileType
        
        // エクスポート先URLを設定
        assetExport?.outputURL = destinationURL
        
        // エクスポート先URLに既にファイルが存在していれば、削除する (上書きはできないので)
        if FileManager.default.fileExists(atPath: (assetExport?.outputURL?.path)!) {
            try! FileManager.default.removeItem(atPath: (assetExport?.outputURL?.path)!)
        }
        // エクスポートする
        assetExport?.exportAsynchronously(completionHandler: {
            // エクスポート完了後に実行したいコードを記述
        })
        
    }
}
