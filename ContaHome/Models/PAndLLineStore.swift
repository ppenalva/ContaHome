//
//  PAndLLineStore.swift
//  ContaHome
//
//  Created by Pablo Penalva on 13/6/22.
//

import Foundation
import SwiftUI

class PAndLLineStore: ObservableObject {
    @Published var pAndLLines: [PAndLLine] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("pAndLLines.data")
    }
    
    static func load(completion: @escaping (Result<[PAndLLine], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let pAndLLines = try JSONDecoder().decode([PAndLLine].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(pAndLLines))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(pAndLLines: [PAndLLine], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(pAndLLines)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(pAndLLines.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

