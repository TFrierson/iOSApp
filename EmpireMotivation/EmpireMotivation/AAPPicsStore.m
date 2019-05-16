//
//  AAPPicsStore.m
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/2/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import "AAPPicsStore.h"

@interface AAPPicsStore ()

@property (nonatomic, strong) NSArray *privatePicsArray;

@end


@implementation AAPPicsStore

+(instancetype)picsStore
{
    static AAPPicsStore *picsStore;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{picsStore = [[self alloc]initPrivate];});
    
    return picsStore;

}

-(instancetype)initPrivate
{
    self = [super init];
    
    if (self)
    {
        self.privatePicsArray = @[@"apppic1.jpg", @"apppic2.jpg", @"apppic3.jpg", @"apppic4.jpg", @"apppic5.jpg", @"apppic6.png", @"apppic7.jpg", @"apppic8.jpg", @"apppic9.jpg", @"apppic10.jpg", @"apppic11.jpg", @"apppic12.jpg", @"apppic13.jpg", @"apppic14.jpg", @"apppic15.jpg", @"apppic16.jpg", @"apppic17.jpg", @"apppic18.jpg", @"apppic19.jpg", @"apppic20.jpg", @"apppic21.jpg", @"apppic22.jpg", @"apppic23.jpg", @"apppic24.jpg", @"apppic25.jpg", @"apppic26.jpg", @"apppic27.jpg", @"apppic28.jpg", @"apppic29.jpg", @"apppic30.jpg", @"apppic31.jpg", @"apppic32.jpg", @"apppic33.jpg", @"apppic34.jpg", @"apppic35.jpg", @"apppic36.jpg", @"apppic37.jpg", @"apppic38.jpg", @"apppic39.jpg", @"apppic40.jpg", @"apppic41.jpg", @"apppic42.jpg", @"apppic43.jpg", @"apppic44.jpg", @"apppic45.jpg", @"apppic46.jpg", @"apppic47.jpg", @"apppic48.jpg", @"apppic49.jpg", @"apppic50.jpg"];
        
        NSString *path = [self favsArchivePath];
        _favPicsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_favPicsArray)
        {
            self.favPicsArray = [[NSMutableArray alloc]init];
        }
    }
    
    return self;
}

-(NSArray *)picsArray
{
    return self.privatePicsArray;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.favPicsArray forKey:@"favPicsArray"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _favPicsArray = [aDecoder decodeObjectForKey:@"favPicsArray"];
    }
    
    return self;
}

-(NSString *)favsArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"favs.archive"];
}

-(BOOL)saveFavs
{
    NSString *path = [self favsArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:self.favPicsArray toFile:path];
}

@end
