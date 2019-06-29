//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by 千葉　諒 on 2019/06/22.
//  Copyright © 2019 chiba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let enableBtnColor: UIColor = UIColor(red: 96/255, green: 163/255, blue: 255/255, alpha: 1.0)
    let disenableBtnColor: UIColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 状態を初期化
        idTextField.text = ""
        passwordTextField.text = ""
        changeLoginEnabled()
    }
    
    private func initView() {
        changeLoginEnabled()
        
        // idの入力制限を登録
        idTextField.addTarget(self, action: #selector(ViewController.checkTextCount), for: .editingChanged)
        
        //passの入力制限を登録
        passwordTextField.addTarget(self, action: #selector(ViewController.checkTextCount), for: .editingChanged)
    }
    
    // TextFieldの文字数によってログインボタンの状態を変化
    private func changeLoginEnabled() {
        if idTextField.text!.count > 0 && passwordTextField.text!.count > 0 {
            print("ボタン活性！")
            // ボタンの活性状態
            loginButton.isEnabled = true
            // ボタンのタイトル色
            loginButton.setTitleColor(UIColor.white,for: UIControl.State.normal)
            // ボタンのボーダー色
            loginButton.layer.borderColor = UIColor.clear.cgColor
            // ボタンの背景色
            loginButton.layer.backgroundColor = enableBtnColor.cgColor
            // どのくらい角を丸くするか
            loginButton.layer.cornerRadius = 4.0
            // ボーダーのの線の太さ
            loginButton.layer.borderWidth = 2.0
        } else {
            print("ボタン非活性！")
            // ボタンの活性状態
            loginButton.isEnabled = false
            // ボタンのタイトル色
            loginButton.setTitleColor(disenableBtnColor,for: UIControl.State.disabled)
            // ボタンのボーダー色
            loginButton.layer.borderColor = disenableBtnColor.cgColor
            // ボタンの背景色
            loginButton.layer.backgroundColor = UIColor.clear.cgColor
            // どのくらい角を丸くするか
            loginButton.layer.cornerRadius = 4.0
            // ボーダーのの線の太さ
            loginButton.layer.borderWidth = 2.0
        }
    }
    
    // textFieldの文字数を検知
    @objc func checkTextCount(textField: UITextField) {
        print(textField.text!.count)
        // チェック関数の呼び出し
        changeLoginEnabled()
    }
    
    // 画面遷移用関数
    @IBAction func moveNextView(_ sender: Any) {
        // RxSwiftViewControllerに繊維
        let storyboard: UIStoryboard = UIStoryboard(name: "RxSwift", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "RxSwift")
        viewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(viewController, animated: true, completion: nil)
    }
    
}
