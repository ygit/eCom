//
//  Product.h
//  eCom
//
//  Created by yogesh singh on 18/08/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * brandName;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * productDetails;
@property (nonatomic, retain) NSString * price;

@end
