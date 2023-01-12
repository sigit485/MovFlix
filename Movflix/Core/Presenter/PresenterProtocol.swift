//
//  PresenterProtocol.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

protocol PresenterToViewProtocol {
    func successLoadData<T>(object: T?)
    func showLoading()
    func dismissLoading()
    func failedLoadData(Error: Error)
}
