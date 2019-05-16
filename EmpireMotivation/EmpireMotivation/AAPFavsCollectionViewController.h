//
//  AAPFavsCollectionViewController.h
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/20/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAPFavsCollectionViewController : UICollectionViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@property (nonatomic) NSInteger favPicIndex;

-(IBAction)dismiss:(id)sender;

@end
