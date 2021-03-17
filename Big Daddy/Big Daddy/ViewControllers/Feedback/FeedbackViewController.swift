//
//  FeedbackViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftBarButton()
        setTitle("Feedback")
        feedbackTableView.register(UINib(nibName: FeedbackCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FeedbackCell.reuseIdentifier)
        feedbackTableView.tableFooterView = UIView.init(frame: .zero)
    } 

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension FeedbackViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackCell.reuseIdentifier, for: indexPath) as! FeedbackCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:FeedbackHeaderView = UIView.fromNib()
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view:FeedbackView = UIView.fromNib()
        view.frame = CGRect(x: 0, y: 0, width: screenWidth-32, height: 575)
        showPopUp(popupView: view, gravity: .Center)
    }
}
