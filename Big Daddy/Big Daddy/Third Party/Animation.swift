//
//  Animation.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import Foundation

final class Presenter: NSObject, UIViewControllerTransitioningDelegate {
    private let transition = Transition()

    func present(_ viewController: UIViewController, from parent: UIViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.transitioningDelegate = self
        parent.present(viewController, animated: true)
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.direction = .present
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.direction = .dismiss
        return transition
    }
}
final class Transition: NSObject, UIViewControllerAnimatedTransitioning {
    enum Direction {
        case present
        case dismiss
    }

    var direction: Direction = .present
    private var presentedConstraints: [NSLayoutConstraint] = []
    private var dismissedConstraints: [NSLayoutConstraint] = []

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { 0.5 }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch direction {
        case .present:
            present(using: transitionContext)
        case .dismiss:
            dismiss(using: transitionContext)
        }
    }

    private func present(using context: UIViewControllerContextTransitioning) {
        guard let presentedView = context.view(forKey: .to) else {
            context.completeTransition(false)
            return
        }
        context.containerView.alpha = 0
        context.containerView.addSubview(presentedView)
        presentedView.translatesAutoresizingMaskIntoConstraints = false

        presentedConstraints = [
            presentedView.leftAnchor.constraint(equalTo: context.containerView.leftAnchor),
            presentedView.rightAnchor.constraint(equalTo: context.containerView.rightAnchor),
            presentedView.topAnchor.constraint(equalTo: context.containerView.topAnchor),
            presentedView.bottomAnchor.constraint(equalTo: context.containerView.bottomAnchor)
        ]

        dismissedConstraints = [
            presentedView.leftAnchor.constraint(equalTo: context.containerView.leftAnchor),
            presentedView.rightAnchor.constraint(equalTo: context.containerView.rightAnchor),
            presentedView.topAnchor.constraint(equalTo: context.containerView.topAnchor),
            presentedView.bottomAnchor.constraint(equalTo: context.containerView.centerYAnchor)
        ]

        NSLayoutConstraint.activate(dismissedConstraints)

        context.containerView.setNeedsLayout()
        context.containerView.layoutIfNeeded()

        NSLayoutConstraint.deactivate(dismissedConstraints)
        NSLayoutConstraint.activate(presentedConstraints)

        UIView.animate(
            withDuration: transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                context.containerView.alpha = 1
                context.containerView.setNeedsLayout()
                context.containerView.layoutIfNeeded()
            },
            completion: { _ in
                context.completeTransition(true)
            })
    }

    private func dismiss(using context: UIViewControllerContextTransitioning) {
        NSLayoutConstraint.deactivate(presentedConstraints)
        NSLayoutConstraint.activate(dismissedConstraints)

        UIView.animate(
            withDuration: transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                context.containerView.alpha = 0
                context.containerView.setNeedsLayout()
                context.containerView.layoutIfNeeded()
            },
            completion: { _ in
                context.completeTransition(true)
            })
    }
}
