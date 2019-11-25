//
//  PointsTableView.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class PointsTableView: UITableView {
    
    // MARK: - Data
    private var models = [MainModelResponse]()
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        delegate = self
        dataSource = self
        
        separatorInset = .zero
        tableFooterView = UIView()
        register(PointTableViewCell.self, forCellReuseIdentifier: PointTableViewCell.reuseId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func set(_ models: [MainModelResponse]) {
        self.models = models
        reloadData()
    }
}

extension PointsTableView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointTableViewCell.reuseId, for: indexPath) as! PointTableViewCell
        cell.set(models[indexPath.row])
        return cell
    }
}

extension PointsTableView: UITableViewDelegate {
    
}
