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

class RxSwiftViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    let enableBtnColor: UIColor = UIColor(red: 96/255, green: 163/255, blue: 255/255, alpha: 1.0)
    let disenableBtnColor: UIColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
    }
    
    private func initView() {
        changeLoginEnabled()
        
        // idTextFieldを監視対象に追加
        validTxtField(textField: idTextField)
        
        // passTextFieldを監視対象に追加
        validTxtField(textField: passTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 状態を初期化
        idTextField.text = ""
        passTextField.text = ""
        changeLoginEnabled()
    }
    
    // TextFieldの文字数によってログインボタンの状態を変化
    private func changeLoginEnabled() {
        if idTextField.text!.count > 0 && passTextField.text!.count > 0 {
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
    
    // テキストフィールドの変更を監視
    func validTxtField(textField: UITextField) {
        // textの変更を検知する
        textField.rx.text.subscribe(onNext: { _ in
            print(textField.text!.count)
            
            // チェック関数の呼び出し
            self.changeLoginEnabled()
        }).disposed(by: disposeBag)
    }
    
    // 画面遷移用関数
    @IBAction func moveBeforeView(_ sender: Any) {
        // ViewControllerに繊維
        self.dismiss(animated: true, completion: nil)
    }
}
