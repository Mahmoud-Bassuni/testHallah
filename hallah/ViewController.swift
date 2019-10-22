//
//  ViewController.swift
//  hallah
//
//  Created by Nada Gamal on 10/22/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
class ViewController: InputVC {

  
    
    @IBOutlet weak var placeNamePropTxt: UITextField!
    @IBOutlet weak var latTxtProp: UITextField!
    @IBOutlet weak var lngTxtProp: UITextField!
    @IBOutlet weak var dateTxtProp: UITextField!
    @IBOutlet weak var imageProp: UIImageView!
    var imagePicker:UIImagePickerController!
    @IBAction func choosePicAction(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func SaveAction(_ sender: Any) {
        let imageName = NSUUID().uuidString
        let storage = FIRStorage.storage().reference().child("\(imageName).png")
        guard let pickedImage = UIImageJPEGRepresentation(self.imageProp.image!, 0.75) else { return }
        storage.put(pickedImage, metadata: nil , completion: {(meta,err) in
            if let url = meta?.downloadURL() {
                let places : Dictionary<String , String> = ["id" : DatabaseService.shared.placesReference.childByAutoId().key ,"name" : self.placeNamePropTxt.text! , "lat" : self.latTxtProp.text! , "lng" : self.lngTxtProp.text! , "date" : self.dateTxtProp.text! , "imageUrl" : url.absoluteString]
                DatabaseService.shared.placesReference.childByAutoId().setValue(places)
            }
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
       // update
         let places : Dictionary<String , String> = ["id" : DatabaseService.shared.placesReference.childByAutoId().key ,"name" : "self.placeNamePropTxt.text!" , "lat" : "self.latTxtProp.text!" , "lng" : "self.lngTxtProp.text!" , "date" : "self.dateTxtProp.text!" , "imageUrl" : "url.absoluteString"]
        
        FIRDatabase.database().reference().child("places").child("-LrntF-3SHR_R0Htc_Uj").setValue(places)
        // delete
         FIRDatabase.database().reference().child("places").child("-LrntF-3SHR_R0Htc_Uj").removeValue()
        
        DatabaseService.shared.placesReference.observe(FIRDataEventType.value, with: { (snapshot) in
            print(snapshot)
//            guard let postsSnapshot = PostsSnapshot(with: snapshot) else { return }
//            self.posts = postsSnapshot.posts
//            self.posts.sort(by: { $0.date.compare($1.date) == .orderedDescending })
//            self.tableView.reloadData()
            
        })
        
    }
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate , UIPopoverControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageProp.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
