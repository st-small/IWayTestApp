//
//  PointTableViewCell.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class PointTableViewCell: UITableViewCell {

    public static let reuseId = "PointTableViewCell"
    
    // MARK: - UI elements
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private var coordinatesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        prepareCityLabel()
        prepareCoordinatesLabel()
        prepareDateLabel()
    }
    
    public func set(_ model: MainModelResponse) {
        cityLabel.text = model.cityName
        coordinatesLabel.text = "lat: \(model.coordinates.lat), long: \(model.coordinates.lon)"
        dateLabel.text = model.date
    }
    
    private func prepareCityLabel() {
        addSubview(cityLabel)
        cityLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(20)
        }
    }
    
    private func prepareCoordinatesLabel() {
        addSubview(coordinatesLabel)
        coordinatesLabel.snp.remakeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom)
            make.leading.trailing.equalTo(cityLabel)
            make.height.equalTo(20)
        }
    }
    
    private func prepareDateLabel() {
        addSubview(dateLabel)
        dateLabel.snp.remakeConstraints { make in
            make.top.equalTo(coordinatesLabel.snp.bottom)
            make.leading.trailing.equalTo(cityLabel)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
