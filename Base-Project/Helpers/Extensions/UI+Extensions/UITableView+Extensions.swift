//
//  UITableView+Extensions.swift
//  Base-Project
//
//  Created by Mojtaba Al Mousawi on 10/1/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func addSpinnerToBottom() -> UIActivityIndicatorView{
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        OperationQueue.main.addOperation{
            //spinner.color = Colors.pickColor
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))
        }
        return spinner
    }
    
    func activate(theSpinner spinner : UIActivityIndicatorView){
        OperationQueue.main.addOperation{
            spinner.startAnimating()
            self.tableFooterView = spinner
            self.tableFooterView?.isHidden = false
        }
    }
    
    func hideSpinner(){
        OperationQueue.main.addOperation{
            self.tableFooterView = nil
            self.tableFooterView?.isHidden = true
        }
    }
    
    func deselectSelectedRow(animated: Bool){
        if let indexPathForSelectedRow = self.indexPathForSelectedRow
        {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
    
    func didReachBottom() -> Bool{
        return (self.contentOffset.y + self.frame.size.height) > self.contentSize.height
    }
    
    func didPassScrollingPercentage(of percentage : Double) -> Bool{
        let yOffset: CGFloat = self.contentOffset.y
        let height: CGFloat = self.contentSize.height - self.frame.size.height
        let scrolledPercentage: CGFloat = yOffset / height
        // Check if all the conditions are met to allow loading the next page
        if scrolledPercentage > CGFloat(percentage) {
            return true
        }
        
        return false
    }
    
}
