//
//  NetworkManager.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import Network

class NetworkManager {
    
    static let shared = NetworkManager()
    
    lazy private var monitor = NWPathMonitor()

    private init() { }

    public func checkInternetConnection(onSuccess: @escaping() -> Void, onError: @escaping (String) -> Void) {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            DispatchQueue.main.async {
                if pathUpdateHandler.status == .satisfied {
                    onSuccess()
                } else {
                    onError(Constants.Error.noNetwork.message)
                }
            }
        }
        let queue = DispatchQueue(label: Constants.Text.internetConnectionMonitor.rawValue)
        monitor.start(queue: queue)
    }
    
    public func cancelMonitoring() {
        monitor.cancel()
    }
}
