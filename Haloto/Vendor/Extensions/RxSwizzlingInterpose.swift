//
//  RxSwizzlingInterpose.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//
import Foundation
import InterposeKit
import UIKit


internal class RxSwizzlingInterpose {
    internal static let shared = RxSwizzlingInterpose()

    internal struct ViewControllerInterpose {
        internal var viewWillAppear: Interpose?
        internal var viewDidAppear: Interpose?
        internal var viewDidLayoutSubviews: Interpose?
        internal var viewWillDisappear: Interpose?
        internal var viewDidDisappear: Interpose?
    }

    private var interpose = ViewControllerInterpose()
    private var environment: RxSwizzlingEnvironment { .current }

    internal func hookViewWillAppearIfNeeded() {
        guard interpose.viewWillAppear == nil else { return }

        let selector = environment.viewWillAppearSelector
        do {
            interpose.viewWillAppear = try Interpose(UIViewController.self) {
                try $0.prepareHook(selector,
                    methodSignature: (@convention(c) (AnyObject, Selector) -> Void).self,
                    hookSignature: (@convention(block) (AnyObject) -> Void).self) {
                    store in { object in
                        guard let viewController = object as? UIViewController else { return }
                        self.synchronized {
                            // call the original viewWillAppear
                            store.original(object, store.selector)

                            // trigger reactive viewWillAppear
                            viewController.rxSwizzling.trigger.viewWillAppear.onNext(())
                        }
                    }
                }
            }
        } catch {
            environment.errorLog(error)
        }
    }

    internal func hookViewDidAppearIfNeeded() {
        guard interpose.viewDidAppear == nil else { return }

        let selector = environment.viewDidAppearSelector
        do {
            interpose.viewDidAppear = try Interpose(UIViewController.self) {
                try $0.prepareHook(selector,
                    methodSignature: (@convention(c) (AnyObject, Selector) -> Void).self,
                    hookSignature: (@convention(block) (AnyObject) -> Void).self) {
                    store in { object in
                        guard let viewController = object as? UIViewController else { return }
                        self.synchronized {
                            // call the original viewDidAppear
                            store.original(object, store.selector)

                            // trigger reactive viewDidAppear
                            viewController.rxSwizzling.trigger.viewDidAppear.onNext(())
                        }
                    }
                }
            }
        } catch {
            environment.errorLog(error)
        }
    }

    internal func hookViewDidLayoutSubviewsIfNeeded() {
        guard interpose.viewDidLayoutSubviews == nil else { return }

        let selector = environment.viewDidLayoutSubviewsSelector
        do {
            interpose.viewDidLayoutSubviews = try Interpose(UIViewController.self) {
                try $0.prepareHook(selector,
                    methodSignature: (@convention(c) (AnyObject, Selector) -> Void).self,
                    hookSignature: (@convention(block) (AnyObject) -> Void).self) {
                    store in { object in
                        guard let viewController = object as? UIViewController else { return }
                        self.synchronized {
                            // call the original viewDidLayoutSubviews
                            store.original(object, store.selector)

                            // trigger reactive viewDidLayoutSubviews
                            viewController.rxSwizzling.trigger.viewDidLayoutSubviews.onNext(())
                        }
                    }
                }
            }
        } catch {
            environment.errorLog(error)
        }
    }

    internal func hookViewWillDisappearIfNeeded() {
        guard interpose.viewWillDisappear == nil else { return }

        let selector = environment.viewWillDisappearSelector
        do {
            interpose.viewWillDisappear = try Interpose(UIViewController.self) {
                try $0.prepareHook(selector,
                    methodSignature: (@convention(c) (AnyObject, Selector) -> Void).self,
                    hookSignature: (@convention(block) (AnyObject) -> Void).self) {
                    store in { object in
                        guard let viewController = object as? UIViewController else { return }
                        self.synchronized {
                            // call the original viewWillDisappear
                            store.original(object, store.selector)

                            // trigger reactive viewWillDisappear
                            viewController.rxSwizzling.trigger.viewWillDisappear.onNext(())
                        }
                    }
                }
            }
        } catch {
            environment.errorLog(error)
        }
    }

    internal func hookViewDidDisappearIfNeeded() {
        guard interpose.viewDidDisappear == nil else { return }

        let selector = environment.viewDidDisappearSelector
        do {
            interpose.viewDidDisappear = try Interpose(UIViewController.self) {
                try $0.prepareHook(selector,
                    methodSignature: (@convention(c) (AnyObject, Selector) -> Void).self,
                    hookSignature: (@convention(block) (AnyObject) -> Void).self) {
                    store in { object in
                        guard let viewController = object as? UIViewController else { return }
                        self.synchronized {
                            // call the original viewDidDisappear
                            store.original(object, store.selector)

                            // trigger reactive viewDidDisappear
                            viewController.rxSwizzling.trigger.viewDidDisappear.onNext(())
                        }
                    }
                }
            }
        } catch {
            environment.errorLog(error)
        }
    }

    private func synchronized<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
}

public struct RxSwizzlingEnvironment {
    internal let errorLog: (Error) -> Void
    internal let viewWillAppearSelector: Selector
    internal let viewDidAppearSelector: Selector
    internal let viewDidLayoutSubviewsSelector: Selector
    internal let viewWillDisappearSelector: Selector
    internal let viewDidDisappearSelector: Selector

    internal init(errorLog interposeFailedLog: @escaping ((Error) -> Void),
        viewWillAppearSelector: Selector = #selector(UIViewController.viewWillAppear(_:)),
        viewDidAppearSelector: Selector = #selector(UIViewController.viewDidAppear(_:)),
        viewDidLayoutSubviewsSelector: Selector = #selector(UIViewController.viewDidLayoutSubviews),
        viewWillDisappearSelector: Selector = #selector(UIViewController.viewWillDisappear(_:)),
        viewDidDisappearSelector: Selector = #selector(UIViewController.viewDidDisappear(_:))) {
        errorLog = interposeFailedLog
        self.viewWillAppearSelector = viewWillAppearSelector
        self.viewDidAppearSelector = viewDidAppearSelector
        self.viewDidLayoutSubviewsSelector = viewDidLayoutSubviewsSelector
        self.viewWillDisappearSelector = viewWillDisappearSelector
        self.viewDidDisappearSelector = viewDidDisappearSelector
    }

    public init(interposeFailedLog: @escaping ((Error) -> Void)) {
        self.init(errorLog: interposeFailedLog)
    }

    public static var current: Self = {
            .init(interposeFailedLog: { _ in })
    }()
}
