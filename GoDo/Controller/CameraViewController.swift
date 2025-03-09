//
//  CameraViewController.swift
//  GoDo
//
//  Created by わだわだ on 2025/01/26.
//

import UIKit
import Cloudinary
import PKHUD

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var cameraImageView: UIImageView!
    
    //cloudinaryの設定を定義
    let config = CLDConfiguration(cloudName: "dhualcxnn", secure: true)
    var cloudinary: CLDCloudinary?
    
    // カメラが開かれたかどうかを判定する変数
    private var isCameraOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cloudinaryの設定を反映察せる
        cloudinary = CLDCloudinary(configuration: config)
        
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
    
    @IBAction func postImage() {
        // thumbnailが空でないことを確認
        guard let postImage = cameraImageView.image else {
            // サムネイル画像が空の場合の処理
            showAlert(title: "入力エラー", message: "サムネイル画像を選択してください。")
            return
        }
        
        Task {
            
            await uploadPostImage(image: postImage)
            showAlert(title: "投稿しました", message: "")
        }
    }
    
    // アラートを表示する関数
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    //撮影した写真をクラウドに保存する関数
    func uploadPostImage(image: UIImage) async -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8), let cloudinary = cloudinary else {
            print("画像データの準備に失敗しました")
            return ""
        }
        
        let uploader = cloudinary.createUploader()
        
        return await withCheckedContinuation { continuation in
            var isResumed = false
            let uniquePublicId = "postImage_\(UUID().uuidString)"
            let params = CLDUploadRequestParams().setPublicId(uniquePublicId)
            
            uploader.upload(data: imageData, uploadPreset: "postImage", params: params, progress: { progress in
                print("アップロード進行中: \(progress.fractionCompleted * 100)%")
            }) { result, error in
                guard !isResumed else { return }
                
                if let error = error {
                    print("アップロード失敗: \(error.localizedDescription)")
                    isResumed = true
                    continuation.resume(returning: "")
                    return
                }
                
                if let result = result, let secureUrl = result.secureUrl {
                    print("アップロード成功: \(secureUrl)")
                    isResumed = true
                    continuation.resume(returning: secureUrl)
                } else {
                    print("アップロード結果が不明です")
                    isResumed = true
                    continuation.resume(returning: "")
                }
            }
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
