//
//  PDSocialLoginViewController.m
//  PopdeemSDK
//
//  Created by Niall Quinn on 23/11/2015.
//  Copyright © 2015 Popdeem. All rights reserved.
//

#import "PDSocialLoginViewController.h"
#import "PDSocialLoginViewModel.h"
#import "PDSocialMediaManager.h"
#import "PDUIKitUtils.h"
#import "PDUtils.h"
#import "PDTheme.h"

@interface PDSocialLoginViewController ()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *poweredByLabel;

@end

@implementation PDSocialLoginViewController

- (instancetype) initFromNib {
  NSBundle *podBundle = [NSBundle bundleForClass:[self classForCoder]];
  if (self = [self initWithNibName:@"PDSocialLoginViewController" bundle:podBundle]) {
    self.view.backgroundColor = [UIColor clearColor];
    return self;
  }
  return nil;
}

- (instancetype) initWithLocationServices:(BOOL)shouldAskLocation {
  _shouldAskLocation = shouldAskLocation;
  return [self initFromNib];
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.viewModel = [[PDSocialLoginViewModel alloc] init];
  [self.viewModel setViewController:self];
  self.loginButton.readPermissions= @[@"public_profile", @"email", @"user_birthday", @"user_posts", @"user_friends", @"user_education_history"];
  [self.loginButton setDelegate:self.viewModel];
  self.snapshotView.image = [PDUIKitUtils screenSnapshot];
  
  //Backing View Dismiss Recogniser
  UITapGestureRecognizer *backingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backingViewTapped)];
  
  [_backingView addGestureRecognizer:backingTap];
  [self renderViewModelState];
  
  [self.continueButton setBackgroundColor:PopdeemColor(@"popdeem.login.continueButton.background")];
  [self.continueButton setTitleColor:PopdeemColor(@"popdeem.login.continueButton.textColor") forState:UIControlStateNormal];
}

- (void) viewDidAppear:(BOOL)animated {
  BOOL isLoggedIn = [[PDSocialMediaManager manager] isLoggedInWithFacebook];
  if (isLoggedIn && !_facebookLoginOccurring) {
    [_viewModel proceedWithLoggedInUser];
  }
}

- (void) didMoveToParentViewController:(UIViewController *)parent {
  [parent.view addSubview:self.view];
  self.view.frame = parent.view.frame;
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
  self.snapshotView.alpha = 0;
  self.backingView.alpha = 0;
  
  [UIView animateWithDuration:.4 animations:^{
    self.snapshotView.alpha = 1;
    self.backingView.alpha = 1;
  }];
  
}

- (void) backingViewTapped {
  [self dismissViewControllerAnimated:YES completion:^{
    //Any cleanup to do?
  }];
}

- (IBAction) continueAction:(id)sender {
  [self dismissViewControllerAnimated:YES completion:^{
    if(self.viewModel.loginState == LoginStateContinue){
      if([self.delegate respondsToSelector:@selector(loginDidSucceed)]){
        [self.delegate loginDidSucceed];
      }
    }
  }];
}

- (void) renderViewModelState {
  if (!_viewModel) return;
  [self.poweredByLabel setText:translationForKey(@"popdeem.sociallogin.footer", @"Powered by Popdeem")];
  [self.continueButton setTitle:translationForKey(@"popdeem.sociallogin.continue", @"Continue to App") forState:UIControlStateNormal];
  [self.titleLabel setText:_viewModel.titleLabelString];
  [self.subtitleLabel setText:_viewModel.subTitleLabelString];
  [self.descriptionLabel setText:_viewModel.descriptionLabelString];
  [self.iconView setImage:[UIImage imageNamed:_viewModel.iconImageName]];
  switch (_viewModel.loginState) {
    case LoginStateContinue:
      [self.loginButton setHidden:YES];
      [self.continueButton setHidden:NO];
      [_titleLabel setTextColor:[UIColor colorWithRed:0.184 green:0.553 blue:0.000 alpha:1.000]];
      break;
    case LoginStateLogin:
    default:
      [self.loginButton setHidden:NO];
      [self.continueButton setHidden:YES];
      [_titleLabel setTextColor:[UIColor colorWithRed:0.745 green:0.251 blue:0.286 alpha:1.000]];
      break;
      break;
  }
  [self.view setNeedsDisplay];
}

@end
