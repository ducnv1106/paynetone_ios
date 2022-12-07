//
//  LoginContract.swift
//  PaynetOne
//
//  Created by vinatti on 27/12/2021.
//

import Foundation

//view -> presenter
protocol ViewToPresenterLoginProtocol {
    var view: PresenterToViewLoginProtocol? {get set}
    var interactor: PresenterToInteractorLoginProtocol? {get set}
    var router: PresenterToRouterLoginProtocol? {get set}
}

//presenter -> view
protocol PresenterToViewLoginProtocol {
    
}

//Presenter -> interactor
protocol PresenterToInteractorLoginProtocol {
    
}

//presenter -> router
protocol PresenterToRouterLoginProtocol {
    
}

