//
//  LoginViewModel.swift
//  TQIBankDIO
//
//  Created by Roberth Diorges on 29/01/22.
//

import Foundation
import VFNetwork

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func goToHome(_ viewModel: LoginViewModel, user: User)
}

protocol LoginViewModelViewDelegate: AnyObject {
    func showError(_ viewModel: LoginViewModel, error: Error)
    func showLoading(_ viewModel: LoginViewModel, isLoanding: Bool)
}

class LoginViewModel {
    
    let service: LoginService
    
    weak var viewDelegate: LoginViewModelViewDelegate?
    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    
    public init(service: LoginService = .init()) {
        self.service = service
    }
    
    public func postAuthenticate(userName: String, password: String) {
        
        service.postAuthenticate(userName: userName, password: password) { result in
            self.viewDelegate?.showLoading(self, isLoanding: false)
            switch result {
            case let .success(user):
                self.coordinatorDelegate?.goToHome(self, user: user)
            case let .failure(error):
                self.viewDelegate?.showError(self, error: error)
            }
        }
    }
}
