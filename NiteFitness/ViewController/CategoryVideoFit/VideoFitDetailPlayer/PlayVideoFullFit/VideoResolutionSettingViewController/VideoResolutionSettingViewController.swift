//
//  VideoSettingViewController.swift
//  1SK
//
//  Created by Valerian on 04/07/2022.
//

import UIKit

protocol VideoResolutionSettingViewDelegate: AnyObject {
    func onResolutionSelected(index: Int)
    func onDismissResolution()
}

class VideoResolutionSettingViewController: BaseViewController {
    
    @IBOutlet weak var tbv_QualityVideo: UITableView!
    @IBOutlet weak var view_container: UIView!
    
    weak var delegate: VideoResolutionSettingViewDelegate?
    
    var video: VideoModel?
    var resolution: VideoResolution?
    var selectedIndex: Int?
    var currentVideoResolution: VideoResolution = .auto
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitUITableView()
        self.setInitUIGestureRecognizer()
    }
}

//MARK: - UIGestureRecognizer
extension VideoResolutionSettingViewController {
    func setInitUIGestureRecognizer() {
        self.view_container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onBgGestureAction)))
        self.tbv_QualityVideo.isHidden = false
    }
    
    @objc func onBgGestureAction() {
        self.dismiss(animated: false) {
            self.delegate?.onDismissResolution()
        }
    }
}

//MARK: - UITableViewDataSource
extension VideoResolutionSettingViewController: UITableViewDataSource {
    func setInitUITableView() {
        self.tbv_QualityVideo.registerNib(ofType: CellTableViewResolutionVideo.self)
        
        self.tbv_QualityVideo.separatorStyle = .none
        self.tbv_QualityVideo.delegate = self
        self.tbv_QualityVideo.dataSource = self
        
        let resolutionIndex = self.currentVideoResolution.ordinal()
        self.tbv_QualityVideo.selectRow(at: IndexPath(row: resolutionIndex, section: 0), animated: true, scrollPosition: .bottom)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideoResolution.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: CellTableViewResolutionVideo.self, for: indexPath)
        cell.label = VideoResolution.allCases[indexPath.row].name
        return cell
    }
}

//MARK: - UITableViewDelegate
extension VideoResolutionSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.onResolutionSelected(index: indexPath.row)
        self.dismiss(animated: false)
    }
}
