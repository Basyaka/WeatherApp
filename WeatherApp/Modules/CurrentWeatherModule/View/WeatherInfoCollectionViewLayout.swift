//
//  WeatherInfoCollectionViewLayout.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//

import UIKit

class WeatherInfoCollectionViewLayout {
    static func createCompositionalLayout() -> UICollectionViewLayout {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Group
        let firstLvlgroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/5)),
            subitem: item,
            count: 3
        )
        
        let secondLvlGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/5)),
            subitem: item,
            count: 2
        )
        secondLvlGroup.contentInsets = .init(top: 0, leading: 50, bottom: 0, trailing: 50)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            subitems: [firstLvlgroup, secondLvlGroup]
        )
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
