//
//  Extension+UIScrollView.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 10/11/21.
//

import UIKit

extension UIScrollView {
  var isAtBottom: Bool {
    return contentOffset.y >= verticalOffsetForBottom
  }

  var verticalOffsetForBottom: CGFloat {
    let scrollViewHeight = bounds.height
    let scrollContentSizeHeight = contentSize.height
    let bottomInset = contentInset.bottom
    let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
    return scrollViewBottomOffset
  }
}

