//
//  BrandCVC.m
//  eCom
//
//  Created by yogesh singh on 19/08/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import "BrandCVC.h"
#import "AppDelegate.h"
#import "Product.h"
#import "BrandCell.h"

@interface BrandCVC ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *brandProducts;
@end

@implementation BrandCVC

#pragma mark Collection View Initializations

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //   Standard Core Data Stack
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    [self getAllProductsForBrand:self.brandName];
}

- (NSArray *) getAllProductsForBrand: (NSString *)brand
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // get brandnames
    
    NSMutableArray *brandProductsArr = [[NSMutableArray alloc]init];
    
    for (Product *product in fetchedRecords) {
        if([product.brandName isEqualToString:self.brandName]){
            if(![brandProductsArr containsObject:product]) {
                [brandProductsArr addObject:product];
            }
        }
    }
    self.brandProducts = brandProductsArr;
    //    NSLog(@"%@",self.brandProducts);
    return self.brandProducts;
}


#pragma mark Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView { return 1; }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { return self.brandProducts.count; }

//- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
































@end
