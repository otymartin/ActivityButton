//
//  ActivityButton.swift
//  ActivityButton
//
//  Created by Martin Otyeka on 2018-05-13.
//  Copyright © 2018 Dopeness Academy. All rights reserved.
//

import Spring
import UIKit

public enum ActivityIndicatorType {
    case spinner
    case indicator
}

open class ActivityButton: SpringButton {
    
    private var spinner: Spinner!
    
    public var activity = false
    
    private var originalButtonText: String?
    
    public var turnGrayDuringActivity = false
    
    private var originalBackgroundColor: UIColor?
    
    public var activityIndicatorColor: UIColor = .white
    
    public var type: ActivityIndicatorType = .indicator
    
    public var backgroundColorDuringActivity: UIColor = .gray
    
    private var activityIndicator: UIActivityIndicatorView!
    
}

extension ActivityButton {
    
    public override func startActivity() {
        
        super.startActivity()
        
        self.activity = true
        
        self.originalButtonText = self.titleLabel?.text
        
        switch self.turnGrayDuringActivity {
        case true:
            self.originalBackgroundColor = self.backgroundColor
            self.backgroundColor = self.backgroundColorDuringActivity
        default:
            break
        }
        
        
        DispatchQueue.main.async {
            self.setTitle("", for: .normal)
        }
        
        switch self.type {
        case .indicator:
            if (activityIndicator == nil) {
                self.activityIndicator = createActivityIndicator()
            }
        case .spinner:
            if self.spinner == nil {
                self.createSpinner()
            }
        }
        
        self.showSpinning()
    }
    
    @objc public override func stopActivity() {
        super.stopActivity()
        
        self.activity = false
        
        self.setTitle(originalButtonText, for: .normal)
        
        switch self.turnGrayDuringActivity {
        case true:
            self.backgroundColor = self.originalBackgroundColor
        default:
            break
        }
        switch self.type {
        case .indicator:
            self.activityIndicator.stopAnimating()
        case .spinner:
            self.spinner.stopAnimating()
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.activityIndicatorColor
        return activityIndicator
    }
    
    private func createSpinner() {
        self.spinner = Spinner()
        self.spinner.Style = .dark
        self.addSubview(self.spinner)
    }
    
    private func showSpinning() {
        switch self.type {
        case .indicator:
            self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(activityIndicator)
            centerActivityIndicatorInButton()
            activityIndicator.startAnimating()
        case .spinner:
            self.spinner.startAnimating()
            self.spinner.translatesAutoresizingMaskIntoConstraints = false
            self.centerSpinnerInButton()
        }
    }
    
    private func centerSpinnerInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.spinner, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.spinner, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}

extension UIButton {
    
    @objc func startActivity() {
        self.isEnabled = false
        self.isUserInteractionEnabled = false
    }
    
    @objc func stopActivity() {
        self.isEnabled = true
        self.isUserInteractionEnabled = true
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let minimumHitArea = CGSize(width: 50, height: 50)
        
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
        
        // increase the hit frame to be at least as big as `minimumHitArea`
        let buttonSize = self.bounds.size
        let widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
        let heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
        
        /// Perform hit test on larger frame
        return (largerFrame.contains(point)) ? self : nil
    }
    
}
