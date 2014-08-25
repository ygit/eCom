//
//  BrandTableCellTableViewCell.h
//  eCom
//
//  Created by yogesh singh on 19/08/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandTableCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *serialNum;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productDetails;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
