//
//  CollectionViewController.h
//  eCom
//
//  Created by yogesh singh on 19/08/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILCSVParser.h"
#import "AppDelegate.h"
#import "Product.h"
#import "Cell.h"
#import "TableViewController.h"

@interface CollectionViewController : UICollectionViewController <ILCSVParserDelegate, UICollectionViewDelegate,UICollectionViewDataSource>

- (void) parsingDidFinish:(NSArray *)parseObjects;
-(void) parsingFailed;

@end
