//
//  ViewController.swift
//  ImageLoadingProject
//
//  Created by Teacher on 16.11.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum Row {
        case image(title: String, urlString: String)
        case largeImage(title: String, previewUrlString: String, urlString: String)
    }
    
    private var selectedUrl: URL?

    private var rows: [Row] = [
        .image(
            title: "Guinea pig",
            urlString: "https://news.clas.ufl.edu/files/2020/06/AdobeStock_345118478-copy-1440x961-1.jpg"
        ),
        .largeImage(
            title: "Large satellite photo",
            previewUrlString: "https://ichef.bbci.co.uk/news/976/cpsprodpb/F3BC/production/_113769326_1.jpg",
            urlString: "https://www.dropbox.com/s/vylo8edr24nzrcz/Airbus_Pleiades_50cm_8bit_RGB_Yogyakarta.jpg?dl=1"
        )
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ImageCell else {
            fatalError("Could not dequeue cell")
        }
        let row = rows[indexPath.row]
        switch row {
        case let .largeImage(_, previewUrlString, _):
            cell.imageUrl = URL(string: previewUrlString)!
        case let .image(_, urlString):
            cell.imageUrl = URL(string: urlString)!
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = rows[indexPath.row]
        switch row {
        case let .largeImage(_, _, urlString):
            selectedUrl =  URL(string: urlString)!
        case let .image(_, urlString):
            selectedUrl =  URL(string: urlString)!
        }
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destantionViewController = segue.destination as! URLDetailsViewController
        destantionViewController.pageUrl = selectedUrl
    }
}

