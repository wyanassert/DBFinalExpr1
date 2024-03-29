//
//  PurchaseLogCollectionViewCell.h
//  DBFinalExpr1
//
//  Created by 万延 on 16/6/8.
//  Copyright © 2016年 万延. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseLogCollectionViewController.h"

@class PurchaseLogModel;

@interface PurchaseLogCollectionViewCell : UICollectionViewCell

- (void)loadData:(PurchaseLogModel *)shoppingCart withCellMode:(PurchaseControllerType)type;

@end
