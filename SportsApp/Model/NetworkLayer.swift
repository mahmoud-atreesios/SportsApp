//
//  NetworkLayer.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 17/10/2023.
//

import Foundation

class NetworkLayer {
    
    func sendPostRequest(apiURL: URL, body: [String: Any], completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        
        // Serialize the body data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            let serializationError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"])
            completion(.failure(serializationError))
            return
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error as Error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}





