//
//  FileManager+Extension.swift
//  RibbonsWidgetApp
//
//  Created by Carmen Lucas on 9/7/23.
//

import Foundation

extension FileManager {
    private static let fileName = "ribbons.json"
    static var docDirURL: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private static let url = docDirURL.appendingPathComponent(fileName)
    
    func readFile() throws -> Data {
        do {
            return try Data(contentsOf: Self.url)
        } catch {
            throw error
        }
    }
    
    func saveFile(contents: String) throws {
        do {
            try contents.write(to:Self.url, atomically: true, encoding: .utf8)
        } catch {
            throw error
        }
    }
    
}
