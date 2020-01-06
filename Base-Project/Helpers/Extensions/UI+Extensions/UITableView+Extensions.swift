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
        let spinner = UIActivityIndicatorView(style: .gray)
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
    public func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    /// SwifterSwift: Scroll to top of TableView.
    ///
    /// - Parameter animated: set true to animate scroll (default is true).
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    public func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool = true) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    func configure(withSelectionAllowed selectionAllowed : Bool? = true,
                   andSperatorStyle sepratorStyle : UITableViewCell.SeparatorStyle,
                   andBackgroundColor bgdColor : UIColor? = .lightGray,
                   isBouncingEnabled bouncingEnables : Bool? = nil){
        self.allowsSelection = selectionAllowed ?? true
        self.separatorStyle = sepratorStyle
        self.backgroundColor = bgdColor
        if bouncingEnables != nil {
            self.bounces = bouncingEnables!
        }
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }

}
