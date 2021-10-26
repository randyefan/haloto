//
//  NetworkProvider.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import Moya
import RxSwift

internal class NetworkProvider<Target> where Target: TargetType {
    private let provider: MoyaProvider<Target>

    internal init() {
        provider = MoyaProvider()
    }

    internal func request(_ token: Target) -> Observable<Response> {
        return provider.rx
            .request(token)
            .asObservable()
    }
}
