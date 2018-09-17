//
//  ViewController.swift
//  FileSaveUtil
//
//  Created by Natsuki HARAI on 2018/09/15.
//  Copyright © 2018年 hahnah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let sourcURL: URL = yourSourceURL // 保存したい動画のURL
        let filePath: String = Bundle.main.path(forResource: "sample", ofType: "mov")!
        let sourceURL: URL = URL(fileURLWithPath: filePath, relativeTo: nil)
        
        let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL: URL = documentsDirectory.appendingPathComponent("myMovie.mov")
        let fileType: AVFileType = AVFileType.mov
        FileSaveUtility.exportMovie(sourceURL: sourceURL, destinationURL: destinationURL, fileType: fileType)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
