//
//  PDRewardTableViewController.m
//  Pods
//
//  Created by John Doran on 26/11/2015.
//
//

#import "PDRewardTableViewController.h"
#import "PDReward.h"
#import "PDModalLoadingView.h"
#import "RewardTableViewCell.h"
#import "NoRewardsTableViewCell.h"
#import "PDAPIClient.h"
#import "PDClaimViewController.h"
#import "PDClaimViewModel.h"
#import "PDUtils.h"

@interface PDRewardTableViewController ()
@property (nonatomic, strong)NSArray *rewards;
@property (nonatomic, strong)PDModalLoadingView *loadingView;
@property (nonatomic, strong)PDLocation *closestLocation;
@end

@implementation PDRewardTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = translationForKey(@"popdeem.rewards.title", @"Rewards");
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];
  [self renderView];
 }

- (void)renderView {
  self.loadingView = [[PDModalLoadingView alloc] initWithDefaultsForView:self.view];
  
  __weak typeof(self) weakSelf = self;
  [[PDAPIClient sharedInstance]getAllRewardsSuccess:^{
    weakSelf.rewards =  [PDRewardStore allRewards];
    [weakSelf fetchLocations];
  } failure:^(NSError * _Nonnull error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf.tableView reloadData];      
    });

  }];
  
}

-(void)close{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.rewards.count != 0 ? self.rewards.count : 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PDReward *reward;
  if (self.rewards.count == 0) {
    return [[NoRewardsTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80) text:translationForKey(@"popdeem.rewards.notavailable", @"There are no rewards available right now. Please check back later.")];
  } else {
    reward = [self.rewards objectAtIndex:indexPath.row];
    return [[RewardTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80) reward:reward];
  }
  
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.rewards objectAtIndex:indexPath.row]) {
      PDReward *reward = [self.rewards objectAtIndex:indexPath.row];
      PDClaimViewController *claimController = [[PDClaimViewController alloc] initWithMediaTypes:@[@(FacebookOnly)] andReward:reward location:_closestLocation];
      [[self navigationController] pushViewController:claimController animated:YES];
    }
}

- (void) fetchLocations {
  [[PDAPIClient sharedInstance] getAllLocationsSuccess:^{
    NSArray *locations = [PDLocationStore locationsOrderedByDistanceToUser];
    _closestLocation = [locations firstObject];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.tableView reloadData];
    });
  } failure:^(NSError *error){
    NSLog(@"Locations Fail: %@",error);
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.tableView reloadData];
    });
  }];
}

@end
