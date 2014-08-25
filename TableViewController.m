//
//  TableViewController.m
//  eCom
//
//  Created by yogesh singh on 19/08/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import "TableViewController.h"
#import "AppDelegate.h"
#import "Product.h"
#import "BrandTableCellTableViewCell.h"

@interface TableViewController ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *brandProducts;
@end

@implementation TableViewController

@synthesize brandName;

#pragma mark Table View Initializations

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.brandProducts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCell = @"tableCell";
    BrandTableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[BrandTableCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCell];
        
//        NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"tableCell" owner:self options:nil];
//        cell = (BrandTableCellTableViewCell*) [cellObjects objectAtIndex:0];
    }

    Product *product = self.brandProducts[indexPath.row];
    
        cell.serialNum.text = [NSString stringWithFormat:@"UID: %@ ",product.uid];
        cell.productName.text = [NSString stringWithFormat:@" %@ ",product.productName];
        cell.productDetails.text = [NSString stringWithFormat:@"Details: %@ ",product.productDetails];
        cell.price.text = [NSString stringWithFormat:@" Rs. %@ ",product.price];
    
    UIImage *image = [UIImage imageNamed:@"bookicon.png"];
    cell.imageView.image = image;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
