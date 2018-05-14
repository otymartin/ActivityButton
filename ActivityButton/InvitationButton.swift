//
//  InvitationButton.swift
//  ActivityButton
//
//  Created by Martin Otyeka on 2018-05-13.
//  Copyright © 2018 Dopeness Academy. All rights reserved.
//

import UIKit
import Spring

protocol InvitationButtonDelegate: class {
    
    func didTap(_ sender: InvitationButton)
}

final class InvitationButton: ActivityButton {
    
    public weak var delegate: InvitationButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InvitationButton {
    
    private func configure() {
        self.setTitle("Send Invitation", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColorDuringActivity = .white
        self.snp.makeConstraints { (make) in
            make.width.equalTo(170)
            make.height.equalTo(55)
        }
        self.layer.cornerRadius = 22
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.addTarget(self, action: #selector(self.tap), for: .touchUpInside)
    }
    
    @objc func tap() {
        self.delegate?.didTap(self)
    }
    
    override func startActivity() {
        super.startActivity()
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func stopActivity() {
        super.stopActivity()
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
