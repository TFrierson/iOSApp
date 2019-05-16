//
//  AAPCollectionViewController.h
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/2/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAPCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSInteger picIndex;

@end
