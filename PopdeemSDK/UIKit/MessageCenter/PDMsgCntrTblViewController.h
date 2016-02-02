//
//  PDMsgCntrTblViewController.h
//  PopdeemSDK
//
//  Created by Niall Quinn on 29/01/2016.
//  Copyright © 2016 Popdeem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgCntrViewModel.h"

@interface PDMsgCntrTblViewController : UITableViewController

@property (nonatomic) MsgCntrViewModel *model;

- (instancetype) initFromNib;

@end
