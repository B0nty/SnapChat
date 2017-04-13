//
//  ViewSnapViewController.swift
//  SnapChat-clone
//
//  Created by B0nty on 13/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))

    }
    
    // Call back button and delete snaps from the Snaps ViewController
    
    override func viewWillDisappear(_ animated: Bool) {
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("We deleted picture")
        }
    }

}
