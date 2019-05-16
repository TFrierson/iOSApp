//
//  AAPCollectionViewController.m
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/2/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import "AAPCollectionViewController.h"
#import "AAPPicsStore.h"
#import "AAPCollectionViewCell.h"
#import "AAPDetailViewController.h"
#import "AAPFavsCollectionViewController.h"

@interface AAPCollectionViewController ()

@end

@implementation AAPCollectionViewController

/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
}*/



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    UINib *nib = [UINib nibWithNibName:@"AAPCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CollectionViewCell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Received memory warning in main collection view");
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [[[AAPPicsStore picsStore]picsArray]count];
}

/*
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AAPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    return cell.frame.size;
}*/


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AAPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    // Configure the cell
    NSArray *picsForCells = [[AAPPicsStore picsStore]picsArray];
    UIImage *cellImage = [UIImage imageNamed:picsForCells[indexPath.row]];
    cell.imageView.image = cellImage;
    
    return cell;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.picIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"detailViewSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailViewSegue"])
    {
        AAPDetailViewController *detailView = [segue destinationViewController];
        detailView.picsIndex = self.picIndex;
        [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    }
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
