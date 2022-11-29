//
//  VideoSegmentSettingViewController.swift
//  1SK
//
//  Created by Valerian on 06/07/2022.
//

import UIKit

protocol VideoSegmentSettingViewDelegate: AnyObject {
    func onSegmentSelected(second: Double)
    func onDismissSegment()
}

class VideoSegmentSettingViewController: UIViewController {
    weak var delegate: VideoSegmentSettingViewDelegate?
    
    @IBOutlet weak var tbv_SegmentVideo: UITableView!
    @IBOutlet weak var view_container: UIView!
    
    var video: VideoModel?
    var timePlaying: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitUITableView()
        self.setInitUIGestureRecognizer()
    }
}

//MARK: - UIGestureRecognizer
extension VideoSegmentSettingViewController {
    func setInitUIGestureRecognizer() {
        self.view_container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onBgGestureAction)))
    }
    
    @objc func onBgGestureAction() {
        self.dismiss(animated: false) {
            self.delegate?.onDismissSegment()
        }
    }
}

//MARK: - UITableViewDataSource
extension VideoSegmentSettingViewController: UITableViewDataSource {
    func setInitUITableView() {
        self.tbv_SegmentVideo.registerNib(ofType: CellTableViewSegmentTime.self)
        
        self.tbv_SegmentVideo.separatorStyle = .none
        self.tbv_SegmentVideo.delegate = self
        self.tbv_SegmentVideo.dataSource = self
        
        if let segments = self.video?.segments, segments.count > 0 {
            var indexSegment = 0
            segments.enumerated().forEach { (index, segment) in
                if self.timePlaying >= segment.startTime ?? 0 {
                    indexSegment = index
                }
            }
            self.tbv_SegmentVideo.selectRow(at: IndexPath(row: indexSegment, section: 0), animated: true, scrollPosition: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.video?.segments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: CellTableViewSegmentTime.self, for: indexPath)
        cell.segmentVideo = self.video?.segments?[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate
extension VideoSegmentSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let second = self.video?.segments?[indexPath.row].startAt else { return }
        if let second = second.toTimeInterval() {
            self.timePlaying = second
            self.delegate?.onSegmentSelected(second: Double(second))
        }
        self.dismiss(animated: false)
    }
}
