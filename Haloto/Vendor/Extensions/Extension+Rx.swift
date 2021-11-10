//
//  Extension+Rx.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import ObjectiveC

fileprivate var disposeBagContext: UInt8 = 0

extension Reactive where Base: AnyObject {
    func synchronizedBag<T>(_ action: () -> T) -> T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }
}

public extension Reactive where Base: AnyObject {
    /// a unique DisposeBag that is related to the Reactive.Base instance only for Reference type
    var disposeBag: DisposeBag {
        get {
            return synchronizedBag {
                if let disposeObject = objc_getAssociatedObject(base, &disposeBagContext) as? DisposeBag {
                    return disposeObject
                }
                let disposeObject = DisposeBag()
                objc_setAssociatedObject(base, &disposeBagContext, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObject
            }
        }

        set {
            synchronizedBag {
                objc_setAssociatedObject(base, &disposeBagContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

public extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        return ControlEvent(events: base.rxSwizzling.viewWillAppear)
    }

    var viewDidLayoutSubviews: ControlEvent<Void> {
        return ControlEvent(events: base.rxSwizzling.viewDidLayoutSubviews)
    }

    var viewDidAppear: ControlEvent<Void> {
        return ControlEvent(events: base.rxSwizzling.viewDidAppear)
    }

    var viewWillDisappear: ControlEvent<Void> {
        return ControlEvent(events: base.rxSwizzling.viewWillDisappear)
    }

    var viewDidDisappear: ControlEvent<Void> {
        return ControlEvent(events: base.rxSwizzling.viewDidDisappear)
    }
}

extension UIViewController {
    internal var rxSwizzling: RxSwizzlingValue {
        if let existingSwizzling = objc_getAssociatedObject(self, &RxSwizzlingValue.AssociatedKeys.swizzlingKey) as? RxSwizzlingValue {
            return existingSwizzling
        }

        let swizzling = RxSwizzlingValue(viewController: self)
        objc_setAssociatedObject(self, &RxSwizzlingValue.AssociatedKeys.swizzlingKey, swizzling, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return swizzling
    }
}

internal class RxSwizzlingValue {
    internal struct AssociatedKeys {
        internal static var swizzlingKey = "com.tokopedia.swizzlingKey"
    }

    internal struct ViewControllerTrigger {
        internal let viewWillAppear = PublishSubject<Void>()
        internal let viewDidAppear = PublishSubject<Void>()
        internal let viewDidLayoutSubviews = PublishSubject<Void>()
        internal let viewWillDisappear = PublishSubject<Void>()
        internal let viewDidDisappear = PublishSubject<Void>()
    }

    private weak var viewController: UIViewController?
    private let swizzling = RxSwizzlingInterpose.shared

    internal let trigger = ViewControllerTrigger()

    internal init(viewController: UIViewController) {
        self.viewController = viewController
    }

    /* Use Swizzling with Singleton instead of per instance,
     due the imp_implementationWithBlock has no way to undo or deregister the IMP,
     so once you submit a block that captures state, you have a permanent memory leak
     */

    internal var viewWillAppear: Observable<Void> {
        swizzling.hookViewWillAppearIfNeeded()
        return trigger.viewWillAppear.asObservable()
    }

    internal var viewDidAppear: Observable<Void> {
        swizzling.hookViewDidAppearIfNeeded()
        return trigger.viewDidAppear.asObservable()
    }

    internal var viewDidLayoutSubviews: Observable<Void> {
        swizzling.hookViewDidLayoutSubviewsIfNeeded()
        return trigger.viewDidLayoutSubviews.asObservable()
    }

    internal var viewWillDisappear: Observable<Void> {
        swizzling.hookViewWillDisappearIfNeeded()
        return trigger.viewWillDisappear.asObservable()
    }

    internal var viewDidDisappear: Observable<Void> {
        swizzling.hookViewDidDisappearIfNeeded()
        return trigger.viewDidDisappear.asObservable()
    }
}
