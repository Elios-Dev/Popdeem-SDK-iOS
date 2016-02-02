//
//  PDMsgCntrTblViewController.m
//  PopdeemSDK
//
//  Created by Niall Quinn on 29/01/2016.
//  Copyright © 2016 Popdeem. All rights reserved.
//

#import "PDMsgCntrTblViewController.h"
#import "MessageCell.h"
#import "NoRewardsTableViewCell.h"

@interface PDMsgCntrTblViewController ()

@end

@implementation PDMsgCntrTblViewController

- (instancetype) initFromNib {
  NSBundle *podBundle = [NSBundle bundleForClass:[self classForCoder]];
  if (self = [self initWithNibName:@"PDMsgCntrTblViewController" bundle:podBundle]) {
    self.model = [[MsgCntrViewModel alloc] init];
    [self.model fetchMessages];
    return self;
  }
  return nil;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return (_model.messages.count > 0) ? _model.messages.count : 1;
}


- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_model.messages.count > 0) {
    if ([model.messages objectAtIndex:indexPath.row]) {
      MessageCell *cell = [[MessageCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 85)];
      return cell;
    } else {
      return nil;
    }
  } else if (model.messagesLoading) {
    return [[NoRewardsTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65) text:@"Fetching messages..."];
  } else {
    return [[NoRewardsTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65) text:@"You have no messages right now..."];
  }
}

 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
