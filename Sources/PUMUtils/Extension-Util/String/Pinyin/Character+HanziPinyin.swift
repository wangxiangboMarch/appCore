//
//  File.swift
//
//
//  Created by εδΈζ on 2021/9/27.
//

import Foundation

public extension Character {
    func pinyin(withFormat outputFormat: PinyinOutputFormat = .default)-> [String] {
        guard let scale = unicodeScalars.first?.value else {
            return []
        }
        return HanziPinyin.pinyinArray(withCharCodePoint: scale,outputFormat: outputFormat)
    }
}
