//
//  CategoryViewController.swift
//  CollectionView
//
//  Created by Chandrakant Shingala on 03/01/23.
//

import UIKit

struct Toy{
    var id: Int
    var type: String
    var price: Double
}

struct FoodItem{
    var id: Int
    var name: String
    var price: Double
}

class CategoryViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var toyItemCollectionView: UICollectionView!
    // MARK: - Variable
    var arrToys: [Toy] = []
    var arrFoodItem: [FoodItem] = []
    var numberOfItemsInRow: Int = 3
    var interItemSpace: CGFloat = 16
    var selectedIndex: Int = -1
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        loadToys()
        loadFoodItem()
        configureCategoryCollectionView()
    }
    
    private func loadToys(){
        let car: Toy = Toy(id: 1, type: "Car", price: 2000)
        let airplane: Toy = Toy(id: 2, type: "Airplane", price: 3900)
        let eKeyBoard: Toy = Toy(id: 3, type: "E KeyBoard", price: 5000)
        let phone: Toy = Toy(id: 4, type: "Phone", price: 200)
        let bike: Toy = Toy(id: 5, type: "Bike", price: 800)
        arrToys = [car,airplane,eKeyBoard,phone,bike]
    }
    
    private func loadFoodItem(){
        let pasta: FoodItem = FoodItem(id: 1, name: "Pasta", price: 100)
        let meggi: FoodItem = FoodItem(id: 2, name: "Meggi", price: 90)
        let pizza: FoodItem = FoodItem(id: 3, name: "Pizza", price: 600)
        let takos: FoodItem = FoodItem(id: 4, name: "Takos", price: 250)
        let cake: FoodItem = FoodItem(id: 5, name: "Cake", price: 400)
        arrFoodItem = [pasta,meggi,pizza,takos,cake]
    }

    private func configureCategoryCollectionView() {
        let nibFile: UINib = UINib(nibName: "ToyCollectionViewCell", bundle: nil)
        toyItemCollectionView.register(nibFile, forCellWithReuseIdentifier: "ToyCollectionViewCell")
        
//        toyItemCollectionView.register(nibFile, forCellWithReuseIdentifier: "ToyCollectionViewCell")
    }
    
}

extension CategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return arrToys.count
        } else {
            return arrFoodItem.count
        }
//        return arrToys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            let cell: ToyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToyCollectionViewCell", for: indexPath) as! ToyCollectionViewCell
            let toy = arrToys[indexPath.row]
//          cell.nameLabel.text = "\(toy.type) \n$\(FoodItem)")
            
            if indexPath.row == selectedIndex {
                cell.layer.borderColor = UIColor.red.cgColor
            } else {
                cell.layer.borderColor = UIColor.black.cgColor
            }
            cell.layer.borderWidth = 10
            cell.layer.masksToBounds = true
            return cell
        } else {
            
            let cell: FoodItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemCollectionViewCell", for: indexPath) as! FoodItemCollectionViewCell
            cell.nameLable.text = arrFoodItem[indexPath.row].name
//            cell.priceLable.text = "$\(arrFoodItem[indexpath.row])"
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let toy = arrToys[indexPath.row]
            selectedIndex = indexPath.row
            print(toy.type)
            print(toy.id)
            collectionView.reloadData()
        }
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let spacing = CGFloat(numberOfItemsInRow+1) * interItemSpace
            let avilabelWidth = collectionView.frame.width - spacing
            let cellWidth = avilabelWidth / CGFloat(numberOfItemsInRow)
            return CGSize(width: cellWidth, height: cellWidth)
        } else {
            let spacing = CGFloat(numberOfItemsInRow+1) * interItemSpace
            let avilabelWidth = collectionView.frame.width - spacing
            let cellWidth = avilabelWidth / CGFloat(numberOfItemsInRow)
            return CGSize(width: cellWidth, height: 80)
        }
    }
    
    func collectionView(_ collection: UICollectionView, layout collectionViewlayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
