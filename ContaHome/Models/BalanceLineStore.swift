//
//  BalanceLineStore.swift
//  ContaHome
//
//  Created by Pablo Penalva on 7/6/22.
//

import Foundation
import SwiftUI

class BalanceLineStore: ObservableObject {
    @Published var balanceLines: [BalanceLine] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("balanceLines.data")
    }
    
    static func load(completion: @escaping (Result<[BalanceLine], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let balanceLines = try JSONDecoder().decode([BalanceLine].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(balanceLines))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(balanceLines: [BalanceLine], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(balanceLines)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(balanceLines.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
