//
//  ViewController.swift
//  KeyChain101
//
//  Created by madi on 7/6/18.
//  Copyright © 2018 madi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addKeyText: UITextField!
    @IBOutlet weak var addValueText: UITextField!
    @IBOutlet weak var getKeyText: UITextField!
    @IBOutlet weak var getValueLabel: UILabel!
    
    let keychainWrapper = KeychainWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addToKeychainPressed(_ sender: UIButton) {
        keychainWrapper.addData(with: addValueText.text ?? "dummy", forKey: addKeyText.text ?? "dummy")
        addKeyText.text?.removeAll()
        addValueText.text?.removeAll()
    }
    
    @IBAction func getFromKeychainPressed(_ sender: UIButton) {
        if let valueText = keychainWrapper.getData(forKey: getKeyText.text ?? "dummy") {
            getValueLabel.text = NSString(data: valueText as Data, encoding: String.Encoding.utf8.rawValue) as String?
        } else {
            getValueLabel.text = "***No data found***"
            getValueLabel.textColor = .red
        }
    }
}
