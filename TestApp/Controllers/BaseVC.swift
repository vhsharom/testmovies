//
//  BaseVC.swift
//  TestApp
//
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    func showSnackBarMessage(message : String){
        let snackView = SnackView()
        snackView.backgroundColor = UIColor.colorAppPurple()
        snackView.setTitle(title: message).show()
    }

    func showSnackBarMessageError(message : String){
        let snackView = SnackView()
        snackView.backgroundColor = UIColor.colorRed()
        snackView.setTitle(title: message).show()
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
