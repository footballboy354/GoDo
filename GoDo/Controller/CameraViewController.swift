//
//  CameraViewController.swift
//  GoDo
//
//  Created by わだわだ on 2025/01/26.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var cameraImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            
//            let picker = UIImagePickerController()
//            picker.sourceType = .camera
//            picker.delegate = self
//            
//            picker.allowsEditing = true
//            
//            present(picker, animated: true, completion: nil)
//        } else {
//            
//            print("error")
//        }
    }

}
