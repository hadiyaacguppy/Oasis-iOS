//
//  UIStackview+Extensions.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

extension UIStackView {
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> UIStackView {
        self.axis = axis
        return self
    }
    
    @discardableResult
    func spacing(_ space: CGFloat) -> UIStackView {
        self.spacing = space
        return self
    }
    
    @discardableResult
    func distributionMode(_ mode: UIStackView.Distribution) -> UIStackView {
        self.distribution = mode
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: Alignment) -> UIStackView {
        self.alignment = alignment
        return self
    }
    
    func arrangedSubviews(_ subviews: UIView...) -> UIStackView {
        subviews.forEach { addArrangedSubview($0) }
        return self
    }

    public func make(viewsHidden: [UIView], viewsVisible: [UIView], animated: Bool) {
        let viewsHidden = viewsHidden.filter({ $0.superview === self })
        let viewsVisible = viewsVisible.filter({ $0.superview === self })

        let blockToSetVisibility: ([UIView], _ hidden: Bool) -> Void = { views, hidden in
            views.forEach({ $0.isHidden = hidden })
        }

        // need for smooth animation
        let blockToSetAlphaForSubviewsOf: ([UIView], _ alpha: CGFloat) -> Void = { views, alpha in
            views.forEach({ view in
                view.subviews.forEach({ $0.alpha = alpha })
            })
        }

        if !animated {
            blockToSetVisibility(viewsHidden, true)
            blockToSetVisibility(viewsVisible, false)
            blockToSetAlphaForSubviewsOf(viewsHidden, 1)
            blockToSetAlphaForSubviewsOf(viewsVisible, 1)
        } else {
            // update hidden values of all views
            // without that animation doesn't go
            let allViews = viewsHidden + viewsVisible
            self.layer.removeAllAnimations()
            allViews.forEach { view in
                let oldHiddenValue = view.isHidden
                view.layer.removeAllAnimations()
                view.layer.isHidden = oldHiddenValue
            }

            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {

                blockToSetAlphaForSubviewsOf(viewsVisible, 1)
                blockToSetAlphaForSubviewsOf(viewsHidden, 0)

                blockToSetVisibility(viewsHidden, true)
                blockToSetVisibility(viewsVisible, false)
                self.layoutIfNeeded()
            },
                           completion: nil)
        }
    }
    
}

extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }

    private func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}
