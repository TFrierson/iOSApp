//
//  AAPDetailViewController.h
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/15/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAPDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *zoomView;
@property (nonatomic) NSInteger picsIndex;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipe;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTapGesture;
@property (weak, nonatomic) IBOutlet UINavigationItem *detailNavItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *galleryButton;

-(IBAction)swipeLeft:(UISwipeGestureRecognizer *) leftGestureRecognizer;
-(IBAction)swipeRight:(UISwipeGestureRecognizer *) rightGestureRecognizer;
-(void)saveToFavorites:(id)sender;
-(IBAction)tapForMenu:(UITapGestureRecognizer *)tapGestureRecognizer;
-(void)shareToSocial;
-(IBAction)dismissMenu:(UIGestureRecognizer *)doubleTap;
-(IBAction)dismiss:(id)sender;


@end
