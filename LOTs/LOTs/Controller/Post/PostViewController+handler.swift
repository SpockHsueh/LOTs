//
//  PostViewController+handler.swift
//  LOTs
//
//  Created by 乃方 on 2018/9/22.
//  Copyright © 2018年 Nia. All rights reserved.
//

import UIKit
import Photos
import Firebase
import FirebaseAuth
import FirebaseStorage

// Image Upload

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
// Need the Auth at first
    
    func handleRegister() {
        
        // E-mail control
        
        
        // Auth
        
        // Error Handler
        guard location != nil else {
            alertRemind(status: "location")
            return
        }
        
        guard cuisine != nil else {
            alertRemind(status: "cuisine")
            return
        }

        guard createdTime != nil else {
            alertRemind(status: "time")
            return
        }

        guard articleTitle != nil else {
            alertRemind(status: "article title")
            return
        }

        guard content != nil else {
            alertRemind(status: "content")
            return
        }
        
        // UUID
        let fileName = UUID().uuidString
        
        // Storage
        let storageRef = Storage.storage().reference().child("article_images").child("\(fileName).jpg")
        
        if let articleImage = self.articleImage.image, let uploadData = self.articleImage.image?.jpegData(compressionQuality: 0.5) {
            
            print(uploadData)
            
            height = articleImage.size.height
            width = articleImage.size.width
            
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                
                print(metadata)
                
                storageRef.downloadURL(completion: { (url, error) in

                    guard let downloadURL = url else {
                        return
                    }
                    
                    self.pictureURL = downloadURL.absoluteString
                    
                    let postID = self.ref.child("post").childByAutoId().key
                    
                    self.ref.child("posts/\(postID)").setValue([
                        "articleTitle": self.articleTitle,
                        "articleImage": self.pictureURL,
                        "height": self.height,
                        "width": self.width,
                        "createdTime": self.createdTime,
                        "cuisine": self.cuisine,
                        "location": self.location,
                        "content": self.content,
                        "user":
                            [
                                "name": Auth.auth().currentUser?.displayName,
                                "image": Auth.auth().currentUser?.photoURL?.absoluteString
                            ]
                        ])
                })
            }
            
            backToMainPage()

        }
                
    }
    
    func alertRemind(status: String) {
        
        let alertController = UIAlertController(title: "Error", message: "Please complete \(status) part!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func handleSelectProfileImageView() {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            selectImageFromPicker = editedImage
            
            print(editedImage)
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            selectImageFromPicker = originalImage
            print(originalImage)

        }
        
        if let selectedImage = selectImageFromPicker {
            
            articleImage.image = selectedImage
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        print("Cancel picker")
        dismiss(animated: true, completion: nil)
        
    }
    
}
