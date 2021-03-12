//
//  TrackOrderViewController.swift
//  Big Daddy
//
//  Created by Technomads on 20/02/21.
//

import UIKit

class TrackOrderViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var topOfTitleLabel: NSLayoutConstraint!
    @IBOutlet weak var topOfTopView: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var trackOrderTableView: UITableView!
    @IBOutlet weak var indicatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.dropShadowed(cornerRadius: 24, corners: [.topLeft,.topRight], borderColor: .clear, borderWidth: 0, shadowColor: .clear)
        trackOrderTableView.register(UINib(nibName: TrackOrderCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TrackOrderCell.reuseIdentifier)
        trackOrderTableView.tableFooterView = UIView(frame: .zero)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notification.isBackButton = true
        self.navigationController?.pushViewController(notification, animated: true)
    }
    
    func setupView() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        topView.addGestureRecognizer(gestureRecognizer)
        topView.isUserInteractionEnabled = true
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let velocity = gestureRecognizer.velocity(in: topView)
        if(velocity.y < 0) {
            moveUP()
        } else {
            moveDown()
        }
    }
    
    func moveUP() {
        UIView.animate(withDuration: 0.8) { [weak self] in
            self?.topOfTopView.constant = 0
            self?.indicatorView.alpha = 0
            self?.topOfTitleLabel.constant = 0
            self?.bgImageView.alpha = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    func moveDown(time:TimeInterval = 0.8) {
        UIView.animate(withDuration: time) { [weak self] in
            self?.topOfTopView.constant = 150
            self?.indicatorView.alpha = 1
            self?.topOfTitleLabel.constant = 64
            self?.bgImageView.alpha = 1
            self?.view.layoutIfNeeded()
        }
    }
}

extension TrackOrderViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackOrderCell.reuseIdentifier, for: indexPath) as! TrackOrderCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = TrackOrderDetailViewController(nibName: "TrackOrderDetailViewController", bundle: nil)
        track.isBackButton = true
        self.navigationController?.pushViewController(track, animated: true)
    }
}
extension TrackOrderViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 50 {
            moveUP()
        } else if scrollView.contentOffset.y < 50 {
            moveDown()
        }
    }
}
