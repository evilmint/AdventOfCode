//
//  Util.swift
//  AoCDay1
//
//  Created by aleksander.lorenc on 01/12/2019.
//

import Foundation

func loadFileContents(fileName: String) -> String {
    let currentPath = FileManager.default.currentDirectoryPath
    let data = FileManager.default.contents(atPath: currentPath + "/" + fileName)!
    return String(data: data, encoding: .utf8)!
}
