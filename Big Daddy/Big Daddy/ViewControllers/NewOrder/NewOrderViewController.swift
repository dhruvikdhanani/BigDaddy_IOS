//
//  NewOrderViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class NewOrderViewController: UIViewController {

    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var fileTableView: UITableView!
    @IBOutlet weak var btnUpload: UIControl!
    @IBOutlet weak var btnManually: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileTableView.register(UINib(nibName: FileCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FileCell.reuseIdentifier)
        fileTableView.tableFooterView = UIView(frame: .zero)
        heightOfTableView.constant = 60*3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btnUpload.drawDottedLine(.themeColor)
        btnManually.drawDottedLine(.themeColor)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func btnNextAction(_ sender: UIButton) {
        let upload = UploadSuccessViewController(nibName: "UploadSuccessViewController", bundle: nil)
        upload.isBackButton = true
        self.navigationController?.pushViewController(upload, animated: true)
    }
    
    @IBAction func btnUploadAction(_ sender: UIControl) {
        openDocumentPicker()
    }
    
    @IBAction func btnManualluAction(_ sender: UIControl) {
        let parcelDetails = ParcelDetailsViewController(nibName: "ParcelDetailsViewController", bundle: nil)
        parcelDetails.isBackButton = true
        self.navigationController?.pushViewController(parcelDetails, animated: true)
    }
    
    @IBAction func btnSideMenuAction(_ sender: UIButton) {
        sideMenuViewController?.showLeftMenuViewController()
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notification.isBackButton = true
        self.navigationController?.pushViewController(notification, animated: true)
    }
    
    
    func openDocumentPicker(){
        let docMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            docMenu.delegate = self
            docMenu.modalPresentationStyle = .formSheet
            self.present(docMenu, animated: true, completion: nil)
     }
}

extension NewOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileCell.reuseIdentifier, for: indexPath) as! FileCell
        if indexPath.row % 2 == 0 {
            cell.fileTypeImageView.image = UIImage(named: "upload_excel")
        } else {
            cell.fileTypeImageView.image = UIImage(named: "upload_image")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension NewOrderViewController : UIDocumentMenuDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
    }
    
    func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
}
