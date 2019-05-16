//
//  AAPFavsCollectionViewController.m
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/20/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import "AAPFavsCollectionViewController.h"
#import "AAPPicsStore.h"
#import "AAPCollectionViewCell.h"
#import "AAPFavsDetailViewController.h"

@interface AAPFavsCollectionViewController () <UIAlertViewDelegate>

@end

@implementation AAPFavsCollectionViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    UINib *nib = [UINib nibWithNibName:@"AAPCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    // Do any additional setup after loading the view.
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(didLongPressToDelete:)];
    longPressGesture.minimumPressDuration = 0.5;
    longPressGesture.cancelsTouchesInView = YES;
    longPressGesture.delegate = self;
    
    for (UIGestureRecognizer* aRecognizer in [self.collectionView gestureRecognizers]) {
        if ([aRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
            [aRecognizer requireGestureRecognizerToFail:longPressGesture];
    }
    
    [self.collectionView addGestureRecognizer:longPressGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[AAPPicsStore picsStore]favPicsArray]count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AAPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    NSArray *favPicsArray = [[AAPPicsStore picsStore]favPicsArray];
    UIImage *cellImage = [UIImage imageNamed:favPicsArray[indexPath.row]];
    cell.imageView.image = cellImage;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.favPicIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"favsDetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"favsDetailSegue"])
    {
        AAPFavsDetailViewController *favsDetailView = [segue destinationViewController];
        favsDetailView.favPicsIndex = self.favPicIndex;
        [self.storyboard instantiateViewControllerWithIdentifier:@"favsDetailView"];
    }
}

-(void)didLongPressToDelete:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        CGPoint longPressLocation = [longPress locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:longPressLocation];
        
        UIAlertController *deleteConfirmController = [UIAlertController alertControllerWithTitle:@"Delete?" message:@"Delete this picture?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 [[[AAPPicsStore picsStore]favPicsArray]removeObjectAtIndex:indexPath.row];
                                 [self.collectionView reloadData];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                 {
                                     [deleteConfirmController dismissViewControllerAnimated:YES completion:NULL];
                                 }];
        
        [deleteConfirmController addAction:ok];
        [deleteConfirmController addAction:cancel];
        
        [self presentViewController:deleteConfirmController animated:YES completion:NULL];
    }
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

-(IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
