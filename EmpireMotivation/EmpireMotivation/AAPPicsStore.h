//
//  AAPPicsStore.h
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/2/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AAPPicsStore : NSObject <NSCoding>

@property (nonatomic, readonly, copy) NSArray *picsArray;
@property (strong, nonatomic) NSMutableArray *favPicsArray;

+(instancetype)picsStore;

-(BOOL)saveFavs;

@end
