//
//  URL+Extension.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

extension URL {
    static func imagePath(from path: String) -> URL {
        return URL(string: Constant.posterURL + path) ?? URL(string: "")!
    }
    
    static func imageLargePath(from path: String) -> URL {
        return URL(string: Constant.posterLargeURL + path) ?? URL(string: "")!
    }
}
