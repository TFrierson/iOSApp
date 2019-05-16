//
//  AAPFavsDetailViewController.h
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/22/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAPFavsDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *favScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *favDetailImageView;
@property (nonatomic) NSInteger favPicsIndex;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipe;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backToFavsButton;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *doubleTap;


-(IBAction)swipeLeft:(UISwipeGestureRecognizer *) leftGestureRecognizer;
-(IBAction)swipeRight:(UISwipeGestureRecognizer *) rightGestureRecognizer;
-(IBAction)tapForMenu:(UITapGestureRecognizer *)tapGestureRecognizer;
-(IBAction)dismissMenu:(UITapGestureRecognizer *)doubleTap;

-(IBAction)dismiss:(id)sender;

@end
