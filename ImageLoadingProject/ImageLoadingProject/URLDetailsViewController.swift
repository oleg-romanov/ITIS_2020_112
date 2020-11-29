//
//  URLDetailsViewController.swift
//  ImageLoadingProject
//
//  Created by Teacher on 16.11.2020.
//

import UIKit
import WebKit

class URLDetailsViewController: UIViewController {
    var pageUrl: URL?

    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageViewWidth: NSLayoutConstraint!
    @IBOutlet private var imageViewHeigth: NSLayoutConstraint!
    @IBOutlet private var imageView: UIImageView!
    private var dataTask: URLSessionDownloadTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadURL()
    }

    private func loadURL() {
        guard let url = pageUrl else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        dataTask = urlSession.downloadTask(with: url)
        dataTask?.resume()
    }
}

extension URLDetailsViewController: URLSessionDownloadDelegate {
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL
    ) {
        let data = try! Data(contentsOf: location)
        print(location.absoluteURL)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.progressView.isHidden = true
            self.imageView.image = UIImage(data: data)
            self.imageViewWidth.constant = self.imageView.image?.size.width ?? 0
            self.imageViewHeigth.constant = self.imageView.image?.size.height ?? 0
        }
    }
    
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64
    ) {
        if totalBytesExpectedToWrite > 0 {
                let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            DispatchQueue.main.async { [weak self] in
                self?.progressView.progress = progress
            }
        }
    }
}
