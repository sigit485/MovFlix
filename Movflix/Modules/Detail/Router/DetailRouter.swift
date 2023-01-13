//
//  DetailRouter.swift
//  Movflix
//
//  Created by Sigit on 13/01/23.
//

import UIKit

class DetailRouter {
    
    func pushToReviewList(from rootViewController: UIViewController, idMovie: Int) {
        let vc = DetailViewBuilder.makeReviewListView(router: self, idMovie: idMovie)
        vc.hidesBottomBarWhenPushed = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
}
