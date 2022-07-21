//
//  File.swift
//  
//
//  Created by MacMini on 2022/7/19.
//

import Foundation
import UIKit
import AVFoundation
/// 根据Url 获取视频的第一帧图片
public extension UIImage {
    
    public static func getFirstImage(url: String,
                              callback: @escaping((UIImage)-> Void)) {
        let queue = DispatchQueue(label: "UrlVideoFirstImage",
                                  attributes: DispatchQueue.Attributes.concurrent)
        queue.async {
            print("开始生成截图")
            let asset = AVURLAsset(url: URL(string: url)!)
            
            let assetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImageGenerator.appliesPreferredTrackTransform = true
            assetImageGenerator.apertureMode = .encodedPixels
            do {
                
                let time = CFTimeInterval(60)
                // seconds: 当前的秒数
                // preferredTimescale: 每秒多少帧
                let cmtime = CMTime(seconds: time, preferredTimescale: 60)
                
                let cgImage = try assetImageGenerator.copyCGImage(at: cmtime,
                                                                  actualTime: nil)
                let thumbnailImage = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    callback(thumbnailImage)
                }
            } catch let error {
                print("thumbnailImageGenerationError \(error)")
            }
        }
    }
}
