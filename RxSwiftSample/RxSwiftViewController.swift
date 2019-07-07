//
//  RxSwiftViewController.swift
//  RxSwiftSample
//
//  Created by 千葉　諒 on 2019/06/22.
//  Copyright © 2019 chiba. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional

final class RxSwiftViewController: UIViewController {
    
    // MARK: Properties
    
    private let enableLoginButtonColor = UIColor(red: 96/255, green: 163/255, blue: 255/255, alpha: 1.0)
    private let disableLoginButtonColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1.0)
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        observeTextFields()
        observeLoginButton()
    }
    
    // MARK: Private Methods
    
    private func configureView() {
        configureLoginButton()
        disableLoginButton()
        resetTextFields()
    }
    
    private func resetTextFields() {
        self.idTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    private func configureLoginButton() {
        self.loginButton.setTitleColor(.white, for: .normal)
        self.loginButton.setTitleColor(self.disableLoginButtonColor, for: .disabled)
    }
    
    private func switchLoginButton(isEnabled: Bool) {
        if isEnabled {
            enableLoginButton()
        } else {
            disableLoginButton()
        }
    }
    
    private func enableLoginButton() {
        self.loginButton.isEnabled = true
        self.loginButton.layer.borderColor = UIColor.clear.cgColor
        self.loginButton.layer.backgroundColor = self.enableLoginButtonColor.cgColor
    }
    
    private func disableLoginButton() {
        self.loginButton.isEnabled = false
        self.loginButton.layer.borderColor = self.disableLoginButtonColor.cgColor
        self.loginButton.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    private func observeTextFields() {
        _ = Observable.combineLatest(
            self.idTextField.rx.text.asObservable().filterNil(),
            self.passwordTextField.rx.text.asObservable().filterNil()
            )
            .takeUntil(self.rx.deallocating)
            .map { (id, password) -> Bool in
                !id.isEmpty && !password.isEmpty
            }
            .subscribe(onNext: { isEnabled in
                self.switchLoginButton(isEnabled: isEnabled)
            })
    }
    
    private func observeLoginButton() {
        _ = self.loginButton.rx
            .controlEvent(.touchUpInside)
            .takeUntil(self.rx.deallocating)
            .subscribe(onNext: { _ in
                self.dismiss(animated: true)
            })
    }
    
}
