//
//  CollectionViewController.m
//  eCom
//
//  Created by yogesh singh on 19/08/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSArray* fetchedRecordsArray;

@end

@implementation CollectionViewController

#pragma mark Collection View controls 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //   Standard Core Data Stack
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.fetchedRecordsArray = [appDelegate getAllRecords];
    
    [self parse];

}

//- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//    
//    label = (UILabel*)[footerView viewWithTag:indexPath.row];
////    label.text = //set text;
//    return footerView;
//}

#pragma mark Parsing from CSV to Core Data

-(void)parse
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"products.csv"];
    ILCSVParser *parser = [[ILCSVParser alloc]init];
    [parser parseCSVFile:bundlePath delegate:self];
}

- (void) parsingDidFinish:(NSArray *)parseObjects
{
    
    
    for (int i = 1; i < [parseObjects count]; i++) {
        
        NSMutableDictionary *lineDict = (NSMutableDictionary *)[parseObjects objectAtIndex:i];
        
        //        sort each line array
        NSArray *sortedKeys = [[lineDict allKeys] sortedArrayUsingSelector: @selector(compare:)];
        NSMutableArray *sortedValues = [NSMutableArray array];
        for (NSString *key in sortedKeys)
            [sortedValues addObject: [lineDict objectForKey: key]];

        
   //      checking for multiple copies of data in core data sqlite storage..
        
        
        //        insert into core data
        Product *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product"
                                                            inManagedObjectContext:self.managedObjectContext];
        
            newProduct.uid = [sortedValues firstObject];
            newProduct.brandName = [sortedValues objectAtIndex:1];
            newProduct.productName = [sortedValues objectAtIndex:2];
            newProduct.productDetails = [sortedValues objectAtIndex:3];
            newProduct.price = [sortedValues lastObject];
        
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
//                NSLog(@"uid: %@",newProduct.uid);
//                NSLog(@"uid: %@",newProduct.brandName);
//                NSLog(@"uid: %@",newProduct.productName);
//                NSLog(@"uid: %@",newProduct.productDetails);
//                NSLog(@"uid: %@",newProduct.price);
    }
}

-(void) parsingFailed
{
    NSError *error;
    NSLog(@"Parsing faced an error : %@",[error localizedDescription]);
}

- (NSArray *) getBrandNames
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
    
    NSMutableArray *brandNames = [[NSMutableArray alloc]init];
    
    for (Product *product in fetchedRecords) {
        if(![brandNames containsObject:product.brandName])
            [brandNames addObject:product.brandName];
    }
    return brandNames;
}

#pragma mark Collection View Controls

//  Delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView { return 1; }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *brandNames = [self getBrandNames];
    return [brandNames count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCell = @"myCell";
     Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:myCell forIndexPath:indexPath];
    
    if(cell == nil) [collectionView registerClass:[Cell class] forCellWithReuseIdentifier:myCell];
    
    NSArray *brandNames = [self getBrandNames];
//    NSLog(@"%@",brandNames);
    NSString *data = [brandNames objectAtIndex:indexPath.row];
    [cell.label setText:data];
//    NSLog(@"%@",cell.label.text);
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"Brand"]) {
        
        NSIndexPath *index = [self.collectionView indexPathForCell:sender];
        
        NSArray *brandNames = [self getBrandNames];
        
        NSString *selectedBrand = brandNames[index.row];
        
        TableViewController *tvc = (TableViewController *)segue.destinationViewController;
        tvc.brandName = selectedBrand;
        tvc.title = selectedBrand;
        
    }


}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"Brand" sender:self];
//
//}























@end
