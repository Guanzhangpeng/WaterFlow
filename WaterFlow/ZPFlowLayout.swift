//
//  ZPFlowLayout.swift
//  WaterFlow
//
//  Created by 管章鹏 on 17/3/24.
//  Copyright © 2017年 stw. All rights reserved.
//

import UIKit

protocol ZPFlowLayoutDataSource : class {
    
    func zpFlowLayout(_ layout :ZPFlowLayout , cellForItemAt indexPath: IndexPath) -> CGFloat
}

class ZPFlowLayout: UICollectionViewFlowLayout {
    
      // MARK : 存储列数
     lazy var columns = 0
    
      // MARK : 数据源
     weak var dataSource : ZPFlowLayoutDataSource?
    
      // MARK : 用来存放所有的UICollectionViewLayoutAttributes
     fileprivate lazy var attributs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
      // MARK : 存储最大的高度
     fileprivate lazy var itemMaxHeight : CGFloat = self.sectionInset.top + self.sectionInset.bottom
    
    
     fileprivate lazy var itemHeights : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.columns)
}

// MARK : 准备好所有cell的布局
extension ZPFlowLayout
{
    override func prepare() {
        
        super.prepare()
        
        //1.0 获取当前collectionview中cell的个数
        guard let collectionView = collectionView else {return}
        let cellCount = collectionView.numberOfItems(inSection: 0)
        
        // 根据列数计算item的宽度
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - ( CGFloat(columns) - 1  ) * minimumInteritemSpacing ) / CGFloat(columns)
        
        for item in 0..<cellCount {
            
            //2.0 根据IndexPath创建UICollectionViewLayoutAttributes
            let indexPath = IndexPath(item: item, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            //3.0 给attribute设置对应的frame
              guard  let itemH = dataSource?.zpFlowLayout(self, cellForItemAt: indexPath) else
              {
                fatalError("请先设置数据源")
              }
            
            let itemMinH = itemHeights.min()!
            let itemofIndex = itemHeights.index(of: itemMinH)!
            
            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(itemofIndex)
            
            let itemY = itemMinH
            
            attribute.frame=CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            
            //将attribute添加到数组中,后面会用到
            attributs.append(attribute)
            
            //改变itemofIndex位置的高度
            itemHeights[itemofIndex] = attribute.frame.maxY + minimumLineSpacing
        }
        
        //获取最大的高度
        itemMaxHeight = itemHeights.max()!
    }
}


// MARK : 告诉系统准备好的布局
extension ZPFlowLayout
{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributs
    }
}

// MARK : 告诉系统滚动的范围
extension ZPFlowLayout
{
    override var collectionViewContentSize: CGSize
    {
        return CGSize(width: 0, height: itemMaxHeight + sectionInset.bottom)
    }
}
