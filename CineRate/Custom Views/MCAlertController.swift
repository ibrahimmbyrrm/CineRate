//
//  MCAlert.swift
//  CineRate
//
//  Created by İbrahim Bayram on 8.06.2023.
//

import UIKit

class MCAlertController: UIViewController {

    @IBOutlet weak var errorDescription: UITextView!
    let error : httpError
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    init(error : httpError) {
        self.error = error
        super.init(nibName: "MCAlert", bundle: Bundle(for: MCAlertController.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.errorDescription.text = self.error.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
