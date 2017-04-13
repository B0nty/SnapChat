//
//  PictureViewController.swift
//  SnapChat-clone
//
//  Created by Jernej Hartman on 11/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        nextButton.isEnabled = false
        
    }

   
    // Function to get picture to use Camera to take a picture
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear
        
        nextButton.isEnabled = true
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        // Adding picture to Firebase and upload it to Firebase before perform sague
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
       
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, Error) in
           
            if Error != nil {
            
            } else {
                self.performSegue(withIdentifier: "selectUsersegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        nextVC.uuid = uuid
    
        
           }

}
