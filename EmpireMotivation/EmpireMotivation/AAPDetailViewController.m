//
//  AAPDetailViewController.m
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/15/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import "AAPDetailViewController.h"
#import "AAPCollectionViewController.h"
#import "AAPPicsStore.h"
#import <Social/Social.h>

@interface AAPDetailViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@end

@implementation AAPDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftSwipe.delegate = self;
    self.rightSwipe.delegate = self;
    self.tapGesture.delegate = self;
    self.doubleTapGesture.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect frame = self.view.window.bounds;
    self.zoomView.delegate = self;
    self.zoomView.minimumZoomScale = 0.5;
    self.zoomView.maximumZoomScale = 3.0;
    self.zoomView.contentSize = frame.size;
    self.zoomView.pagingEnabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *picArray = [[AAPPicsStore picsStore]picsArray];
    UIImage *detailImage = [UIImage imageNamed:picArray[self.picsIndex]];
    self.imageView.image = detailImage;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    NSArray *picArray2 = [[AAPPicsStore picsStore]picsArray];
    self.picsIndex += 1;
    if (self.picsIndex > picArray2.count - 1)
    {
        self.picsIndex = picArray2.count - 1;
    }
    
    UIImage *nextImage = [UIImage imageNamed:picArray2[self.picsIndex]];
    self.imageView.image = nextImage;
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender
{
    NSArray *picArray2 = [[AAPPicsStore picsStore]picsArray];
    self.picsIndex -= 1;
    if (self.picsIndex < 0)
    {
        self.picsIndex = 0;
    }
    
    UIImage *nextImage = [UIImage imageNamed:picArray2[self.picsIndex]];
    self.imageView.image = nextImage;
}

-(IBAction)tapForMenu:(UITapGestureRecognizer *)tapGesture
{
    [tapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
    
    [self becomeFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    UIMenuItem *saveToFavs = [[UIMenuItem alloc]initWithTitle:@"Favorite" action:@selector(saveToFavorites:)];
    UIMenuItem *share = [[UIMenuItem alloc]initWithTitle:@"Share To Social" action:@selector(shareToSocial)];
    
    menu.menuItems = @[saveToFavs, share];
    
    CGPoint tapPoint = [tapGesture locationInView:self.imageView];
    
    [menu setTargetRect:CGRectMake(tapPoint.x, tapPoint.y, 100, 100) inView:self.imageView];
    [menu setMenuVisible:YES animated:YES];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)saveToFavorites:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirm" message:@"Add picture to Favorites?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             NSArray *saveFavPicArray = [[AAPPicsStore picsStore]picsArray];
                             [[[AAPPicsStore picsStore]favPicsArray]addObject:saveFavPicArray[self.picsIndex]];
                             [[AAPPicsStore picsStore]saveFavs];
                         }
                         ];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:NULL];
                             }];
    
    [alertController addAction:ok];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)shareToSocial
{
    NSArray *currentPicArray = [[AAPPicsStore picsStore]picsArray];
    
    UIAlertController *socialAlertController = [UIAlertController alertControllerWithTitle:@"Social Share" message:@"Share to: " preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *facebook = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
                                   {
                                       SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                                       
                                       [facebookController addImage:[UIImage imageNamed:currentPicArray[self.picsIndex]]];
                                       //Not allowed to set initial text for Facebook! Lame!
                                       
                                       [self presentViewController:facebookController animated:YES completion:nil];
                                   }
                               }];
    
    UIAlertAction *twitter = [UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
                                  {
                                      SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                      
                                      [twitterController addImage:[UIImage imageNamed:currentPicArray[self.picsIndex]]];
                                      [twitterController setInitialText:@"Just wanted to share some GREAT motivation from the Empire Motivation app! Get it here: https://itunes.apple.com/us/app/id1054270159"];
                                      
                                      [self presentViewController:twitterController animated:YES completion:nil];
                                  }
                              }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 [socialAlertController dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [socialAlertController addAction:facebook];
    [socialAlertController addAction:twitter];
    [socialAlertController addAction:cancel];
    
    [self presentViewController:socialAlertController animated:YES completion:nil];
}

-(IBAction)dismissMenu:(UIGestureRecognizer *)doubleTap
{
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}

-(IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}*/


@end
