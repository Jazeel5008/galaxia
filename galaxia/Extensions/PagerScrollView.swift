//
//  PagerScrollView.swift
//  Zulekha Hospitals
//
//  Created by Arjun KT on 20/01/22.
//

import Foundation
import UIKit

@objc public protocol PagerScrollViewDelegate: AnyObject {
    @objc optional func didChangePage(toPageIndex pageIndex: Int)
}

public class PagerScrollView: UIScrollView, UIScrollViewDelegate
{
    //    weak public var delegate: PagerScrollViewDelegate?
    public var pagerDelegate: PagerScrollViewDelegate?
    private var numberOfPages: Int?
    private var pageIndex: Int?
    private var views: [String: UIView] = [:]


    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    private func setup() {
        delegate = self

        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }

    public func setPagerScrollView(toParentVC parent: UIViewController, pagesVC pages: [UIViewController]) {
        numberOfPages = pages.count
        views = ["container": self]

        var constraintString: String = ""

        for (index, vc) in pages.enumerated() {
            vc.view.translatesAutoresizingMaskIntoConstraints = false

            self.addSubview(vc.view)
            parent.addChild(vc)
            vc.didMove(toParent: parent)

            views["page\(index)"] = vc.view
            constraintString += "[page\(index)(==container)]"
        }

        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[page0(==container)]|", options: [], metrics: nil, views: views)
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|\(constraintString)|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)

        NSLayoutConstraint.activate(verticalConstraint + horizontalConstraint)

    }

    public func setPage(withIndex index: Int, animated: Bool) {
        guard let numberOfPages = numberOfPages
            else { return }

        pageIndex = index

        let contentOffsetX = contentSize.width/CGFloat(numberOfPages) * CGFloat(pageIndex!)
        let point = CGPoint(x: contentOffsetX, y: 0)
        self.setContentOffset(point, animated: animated)
    }

    private func getCurrentPage() -> Int {
        guard let numberOfPages = numberOfPages
            else { return 0 }

        if contentOffset.x == 0
        {
            return 0
        }

        let pageWidth = contentSize.width/CGFloat(numberOfPages)
        return Int(contentOffset.x/pageWidth)
    }

    // MARK: - ScrollViewDelegate

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = getCurrentPage()

        if currentPage != pageIndex
        {
            pageIndex = currentPage

            if let pagerDelegate = pagerDelegate, let pageIndex = pageIndex, let result = pagerDelegate.didChangePage?(toPageIndex: pageIndex) {
                result
            }

        }
    }
}
