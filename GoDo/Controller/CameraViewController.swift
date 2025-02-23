//
//  CameraViewController.swift
//  GoDo
//
//  Created by わだわだ on 2025/01/26.
//

import UIKit

import PKHUD

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var cameraImageView: UIImageView!
    
    // カメラが開かれたかどうかを判定する変数
    private var isCameraOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //　画面が表示されようとする時
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // カメラがまだ開かれていない時
        if !isCameraOpened {
            isCameraOpened = true
            openCamera()
        }
    }
    
    // 📸 カメラを開く処理
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        } else {
            print("カメラが利用できません")
        }
    }
    
    // ❌ キャンセル時に1つ目のタブへ戻る
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.isCameraOpened = false // 🔹 フラグをリセットして再度カメラが開くのを防ぐ
            self.tabBarController?.selectedIndex = 0 // 🟢 1つ目のタブに移動
            
        }
    }
    
    // 🖼️ 画像選択時の処理（必要なら実装）
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            
            self.cameraImageView.image = info[.editedImage] as? UIImage
            self.isCameraOpened = false // 🔹 フラグをリセットして再度カメラが開くのを防ぐ
        }
    }
}
