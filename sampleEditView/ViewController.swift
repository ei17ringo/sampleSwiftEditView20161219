//
//  ViewController.swift
//  sampleEditView
//
//  Created by Eriko Ichinohe on 2017/02/14.
//  Copyright © 2017年 Eriko Ichinohe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var myTitle: UITextField!
    
    @IBOutlet weak var myDate: UITextField!
    
    @IBOutlet weak var myContents: UITextView!
    
    //datePickerを載せるView
    let baseView:UIView = UIView(frame: CGRect(x:0,y:720,width:200,height:250))
    
    //datePicker(日付編集時)
    let diaryDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: 10, y: 20, width: 300, height: 220))
    
    //datePickerを隠すためのボタン
    let closeBtnDatePicker:UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //日付が変わった時のイベントをdatePickerに設定
        diaryDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
        
        //baseViewにdatePickerを配置
        baseView.addSubview(diaryDatePicker)
        
        //baseViewにボタンを配置
        //位置、大きさを決定
        closeBtnDatePicker.frame = CGRect(x: self.view.frame.width - 60, y: 0, width: 50, height: 20)
        
        //タイトルの設定
        closeBtnDatePicker.setTitle("Close", for: .normal)
        
        //イベントの追加
        closeBtnDatePicker.addTarget(self, action: #selector(closeDatePickerView(sender:)), for: .touchUpInside)
        
        //Viewに追加
        baseView.addSubview(closeBtnDatePicker)
        
        
        //下にピッタリ配置、横幅ピッタリの大きさにしておく
        //位置
        baseView.frame.origin = CGPoint(x:0,y:self.view.frame.size.height)
        
        //横幅
        baseView.frame.size = CGSize(width: self.view.frame.width, height: baseView.frame.height)
        
        //背景色Grayにセット
        baseView.backgroundColor = UIColor.gray
        
        //画面に追加
        self.view.addSubview(baseView)
        
    }

    //textFieldにカーソルが当たったとき（入力開始）
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing 発動された")
        print(textField.tag)
        
        //TODO:キーボード、日付のViewを閉じる
        //キーボード
        myTitle.resignFirstResponder()
        
        //日付のView
        hideDatePickerView()
        
        switch textField.tag {
        case 1:
            //タイトル
            //キーボードを表示
            return true
        case 2:
            //日付
            //アニメーションでDatePickerが載ったViewを表示
            disprayDatePickerView()
            
            //キーボードを非表示
            return false
        default:
            return true
        }
        
        return true
    }
    
    
    //DatePickerのViewを隠す
    func hideDatePickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
            
        },completion:{finished in print("DatePickerを隠しました")})
    }
    
    //DatePickerのViewを表示する
    func disprayDatePickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height - self.baseView.frame.height)
            
        },completion:{finished in print("DatePickerが現れました")})
    
    }
    
    
    //タイトルで表示したキーボードのReturnキーが押されたとき発動
    @IBAction func tapTitleReturn(_ sender: UITextField) {
    }
    
    //MARK:TextView
    //textViewにカーソルが当たったとき(入力開始)
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        //フォーム全体を上に移動する
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.formView.frame.origin = CGPoint(x: self.formView.frame.origin.x, y: self.formView.frame.origin.y - 250)
            
        },completion:{finished in print("FormViewが上に移動しました")})
        
        //キーボードを表示
        return true
    }
    
    //Closeボタンが押されたとき発動
    @IBAction func tapClose(_ sender: UIButton) {
        
        //キーボード閉じる
        myContents.resignFirstResponder()
        
        //DatePickerのViewを閉じる
        hideDatePickerView()
        
        //formViewを元に戻す
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.formView.frame.origin = CGPoint(x: self.formView.frame.origin.x, y: self.formView.frame.origin.y + 250)
            
        },completion:{finished in print("FormViewが元の位置に移動しました")})
    }
    
    
    //DatePickerが載ったViewを隠す
    func closeDatePickerView(sender:UIButton){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
            
        },completion:{finished in print("DatePickerを隠しました")})
        
    }
    
    //DatePickerで選択している日付を変えた時、日付用のTextFieldに値を表示
    func showDateSelected(sender:UIDatePicker){
    
        //フォーマットを設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        
        //日付を文字列に変換
        let strSelectedDate = df.string(from: sender.date)
        
        //TextFieldに値を表示
        myDate.text = strSelectedDate
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

