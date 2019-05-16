//
//  AAPFavsDetailViewController.m
//  EmpireMotivation
//
//  Created by Tiffany Frierson on 10/22/15.
//  Copyright © 2015 Aberration Apps. All rights reserved.
//

#import "AAPFavsDetailViewController.h"
#import "AAPPicsStore.h"
#import "AAPFavsCollectionViewController.h"
#import <Social/Social.h>

@interface AAPFavsDetailViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation AAPFavsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect frame = self.view.window.bounds;
    self.favScrollView.delegate = self;
    self.favScrollView.minimumZoomScale = 0.5;
    self.favScrollView.maximumZoomScale = 3.0;
    self.favScrollView.contentSize = frame.size;
    self.favScrollView.pagingEnabled = NO;
    
    NSArray *favPicArray = [[AAPPicsStore picsStore]favPicsArray];
    UIImage *favDetailImage = [UIImage imageNamed:favPicArray[self.favPicsIndex]];
    self.favDetailImageView.image = favDetailImage;
    
    self.leftSwipe.delegate = self;
    self.rightSwipe.delegate = self;
    self.tapRecognizer.delegate = self;
    self.doubleTap.delegate = self;
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.favDetailImageView;
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    NSArray *favPicsArray2 = [[AAPPicsStore picsStore]favPicsArray];
    self.favPicsIndex += 1;
    if (self.favPicsIndex > favPicsArray2.count - 1)
    {
        self.favPicsIndex = favPicsArray2.count - 1;
    }
    
    UIImage *nextImage = [UIImage imageNamed:favPicsArray2[self.favPicsIndex]];
    self.favDetailImageView.image = nextImage;
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender
{
    NSArray *favPicsArray3 = [[AAPPicsStore picsStore]favPicsArray];
    self.favPicsIndex -= 1;
    if (self.favPicsIndex < 0)
    {
        self.favPicsIndex = 0;
    }
    
    UIImage *nextImage = [UIImage imageNamed:favPicsArray3[self.favPicsIndex]];
    self.favDetailImageView.image = nextImage;
}

-(IBAction)tapForMenu:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self becomeFirstResponder];
    
    [tapGestureRecognizer requireGestureRecognizerToFail:self.doubleTap];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    UIMenuItem *share = [[UIMenuItem alloc]initWithTitle:@"Share To Social" action:@selector(shareToSocial)];
    
    menu.menuItems = @[share];
    
    CGPoint tapPoint = [tapGestureRecognizer locationInView:self.favDetailImageView];
    
    [menu setTargetRect:CGRectMake(tapPoint.x, tapPoint.y, 100, 100) inView:self.favDetailImageView];
    [menu setMenuVisible:YES animated:YES];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)shareToSocial
{
    NSArray *currentFavPicArray = [[AAPPicsStore picsStore]favPicsArray];
    
    UIAlertController *socialAlertController = [UIAlertController alertControllerWithTitle:@"Social Share" message:@"Share to: " preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *facebook = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
                                   {
                                       SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                                       
                                       [facebookController addImage:[UIImage imageNamed:currentFavPicArray[self.favPicsIndex]]];
                                       //Not allowed to set initial text for Facebook! Lame!
                                       
                                       [self presentViewController:facebookController animated:YES completion:nil];
                                   }
                               }];
    
    UIAlertAction *twitter = [UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
                                  {
                                      SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                      
                                      [twitterController addImage:[UIImage imageNamed:currentFavPicArray[self.favPicsIndex]]];
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

-(IBAction)dismissMenu:(UITapGestureRecognizer *)doubleTap
{
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}

-(IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
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

@end
