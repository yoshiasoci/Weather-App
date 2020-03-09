//
//  JSONRequest.swift
//  AplikasiCuaca
//
//  Created by admin on 1/13/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol JSONRequestFileServiceable {
    func requestJsonFile<ResultData: Decodable>(file jsonFile: String?, completionHandler: @escaping (Result<ResultData?, Error>) -> Void)
}

class JSONRequestFileLocal: JSONRequestFileServiceable {
    
    private let utilityQueue = DispatchQueue(label: "tes.com.request.json", qos: .utility)
    
    final func requestJsonFile<ResultData: Decodable>(file jsonFile: String?, completionHandler: @escaping (Result<ResultData?, Error>) -> Void) {
        guard let file: String = jsonFile else { return }
        let url = Bundle.main.url(forResource: file, withExtension: "json")!

        utilityQueue.async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    DispatchQueue.main.async {
                    completionHandler(.success(nil))
                    }
                    return
                }
                do {
                    let resultData = try JSONDecoder().decode(ResultData.self, from: data)
                    DispatchQueue.main.async {
                    completionHandler(.success(resultData))
                    }
                } catch {
                    DispatchQueue.main.async {
                    completionHandler(.failure(error))
                    }
                }
            }.resume()
        }
    }
    
}
