//
//  ImagePickerHandler.swift
//  Bloodstock
//
//  Created by Rogerio de Paula Assis on 4/11/16.
//  Copyright © 2016 Arrowfield. All rights reserved.
//

import UIKit
import MobileCoreServices

public class MediaPickerHandler: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    var delegate: MediaPickerPresenter?
    let imagePicker = UIImagePickerController()
    let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)    
    
    private let sourceType: UIImagePickerControllerSourceType    
    
    public init(sourceType: UIImagePickerControllerSourceType) {
        self.sourceType = sourceType
        super.init()
        self.documentPicker.delegate = self
        self.imagePicker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)];
        self.imagePicker.delegate = self
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.delegate?.didSelectFromMediaPicker(withUrl: url)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
            switch mediaType {
            case String(kUTTypeImage):
                if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    self.delegate?.didSelectFromMediaPicker(withImage: selectedImage)
                }
            case String(kUTTypeMovie):
                if let selectedMediaURL = info[UIImagePickerControllerMediaURL] as? URL {
                    self.delegate?.didSelectFromMediaPicker(withUrl: selectedMediaURL)
                }
            default:
                break
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}