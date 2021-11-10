//
//  BottomSheetViewController+Rx.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import RxCocoa
import RxSwift
import RxOptional

extension Reactive where Base: BottomSheetViewController {
    public var onDismissed: ControlEvent<BottomsheetDismissType> {
        let source = base.rx.viewDidDisappear
            .map { [weak bottomsheet = self.base] _ -> BottomsheetDismissType? in
            // prevent memory leak, access base with weak
            guard let currentBottomsheet = bottomsheet else { return nil }

            return currentBottomsheet.dismissType
        }.compactMap { $0 }

        return ControlEvent(events: source)
    }
}

