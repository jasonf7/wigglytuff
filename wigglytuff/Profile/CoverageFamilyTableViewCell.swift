//
//  CoverageFamilyTableViewCell.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class CoverageFamilyTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    static let cellIdentifier = "coverageFamilyServiceCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CoverageFamilyTableViewCell.cellIdentifier, forIndexPath: indexPath) as! CoverageFamilyServiceCollectionViewCell
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        
        let coverage = DataManager.sharedInstance.familyCoverage["medical"]!["health_benefit_plan_coverage"]!
        
        cell.deductibleLabel.text = formatter.stringFromNumber(NSNumber(double: coverage.deductible.total))
        cell.spentLabel.text = formatter.stringFromNumber(NSNumber(double: coverage.deductible.spent))
        cell.copayLabel.text = formatter.stringFromNumber(NSNumber(double: coverage.copay))
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.pokeColor().CGColor
        
        return cell
    }

}
