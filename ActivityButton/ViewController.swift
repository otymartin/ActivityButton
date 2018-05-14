//
//  ViewController.swift
//  ActivityButton
//
//  Created by Martin Otyeka on 2018-05-13.
//  Copyright © 2018 Dopeness Academy. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, InvitationButtonDelegate {
    
    let button = InvitationButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.delegate = self
        self.button.type = .spinner
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.center.equalTo(view.snp.center)
        }
    }
    
    func didTap(_ sender: InvitationButton) {
        switch sender.activity {
        case true:
            sender.stopActivity()
        case false:
            sender.startActivity()
            sender.isUserInteractionEnabled = true
        }
    }

}

