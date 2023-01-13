//
//  BudgetStore.swift
//  ContaHome
//
//  Created by Pablo Penalva on 12/12/22.
//

import Foundation
import SwiftUI

class BudgetStore: ObservableObject {
    @Published var budgets: [Budget] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("budgets.data")
    }
    
    static func load(completion: @escaping (Result<[Budget], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let budgets = try JSONDecoder().decode([Budget].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(budgets))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(budgets: [Budget], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(budgets)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(budgets.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

