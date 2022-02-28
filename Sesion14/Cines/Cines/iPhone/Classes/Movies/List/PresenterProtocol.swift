//
//  PresenterProtocol.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 28/02/22.
//

import Foundation

@objc protocol ListMoviesPresenterProtocol: NSObjectProtocol {
    @objc optional func didLoad()
    @objc optional func willAppear()
    @objc optional func pullToRefresh()
}
