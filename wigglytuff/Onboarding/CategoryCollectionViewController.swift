//
//  CategoryCollectionViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

protocol CategoryCollectionDelegate {
    func onCategorySelected(categoryCollectionViewController: CategoryCollectionViewController, category: InsuranceCategory)
}

class CategoryCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static let cellIdentifier = "categoryCollectionViewCell"
    
    var delegate: CategoryCollectionDelegate?
    var filters: [String]?
    
    let insuranceCategories = [
        InsuranceCategory(name: "Medical", camelCaseName: "medical", image: UIImage(named: "stethoscope")!),
        InsuranceCategory(name: "Teeth", camelCaseName: "teeth", image: UIImage(named: "tooth")!),
        InsuranceCategory(name: "Eye", camelCaseName: "eye", image: UIImage(named: "eye")!),
        InsuranceCategory(name: "Family", camelCaseName: "family", image: UIImage(named: "heart-hand")!),
        InsuranceCategory(name: "Prescription", camelCaseName: "prescription", image: UIImage(named: "pills")!),
        InsuranceCategory(name: "Emergency", camelCaseName: "emergency", image: UIImage(named: "ambulance")!),
        InsuranceCategory(name: "X-Ray", camelCaseName: "xray", image: UIImage(named: "x-ray")!),
        InsuranceCategory(name: "Hospital Repairs", camelCaseName: "hospitalRepairs", image: UIImage(named: "plastered-foot")!),
        InsuranceCategory(name: "Immunizations", camelCaseName: "immunizations", image: UIImage(named: "syringe")!),
        InsuranceCategory(name: "Mental Health", camelCaseName: "mentalHealth", image: UIImage(named: "brain")!),
        InsuranceCategory(name: "Ear", camelCaseName: "ear", image: UIImage(named: "ear")!),
        InsuranceCategory(name: "Long Term Care", camelCaseName: "longTermCare", image: UIImage(named: "wheelchair")!),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let catFilters = filters {
            return catFilters.count
        } else {
            return insuranceCategories.count
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CategoryCollectionViewController.cellIdentifier, forIndexPath: indexPath) as! CategoryCollectionViewCell
        
        var category: InsuranceCategory
        if let catFilters = filters {
            let catName = catFilters[indexPath.row]
            category = insuranceCategories.filter({ $0.name == catName })[0]
        } else {
            category = insuranceCategories[indexPath.row]
        }
        
        cell.nameLabel.text = category.name
        cell.imageView.image = category.image
        cell.imageView.layer.borderColor = UIColor.darkGrayColor().CGColor
        cell.imageView.layer.borderWidth = 1.0
        if category.selected {
            cell.checkmarkImageView.image = UIImage(named: "checkmark")
        } else {
            cell.checkmarkImageView.image = nil
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let mDelegate = delegate else {
            insuranceCategories[indexPath.row].selected = !insuranceCategories[indexPath.row].selected
            collectionView.reloadItemsAtIndexPaths([indexPath])
            return
        }
        
        mDelegate.onCategorySelected(self, category: insuranceCategories[indexPath.row])
    }
    
    func getSelectedCategories() -> [String] {
        var categories = [String]()
        
        for category in insuranceCategories {
            if category.selected {
                categories.append(category.name)
            }
        }
        
        return categories
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
