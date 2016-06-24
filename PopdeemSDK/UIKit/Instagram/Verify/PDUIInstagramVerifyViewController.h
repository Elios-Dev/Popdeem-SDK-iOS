//
//  PDUIInstagramVerifyViewController.h
//  PopdeemSDK
//
//  Created by Niall Quinn on 22/06/2016.
//  Copyright © 2016 Popdeem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDReward.h"
#import "PDUIModalLoadingView.h"

@interface PDUIInstagramVerifyViewController : UIViewController

@property (nonatomic, assign) UIViewController *parent;
@property (nonatomic, assign) PDReward *reward;
@property (nonatomic, retain) UIVisualEffectView *effectView;
@property (nonatomic, retain) UIView *cardView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *messageLabel;
@property (nonatomic, retain) UILabel *instructionsLabel;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UIButton *actionButton;
@property (nonatomic, retain) PDUIModalLoadingView *loadingView;

- (instancetype) initForParent:(UIViewController*)parent forReward:(PDReward*)reward;

@end
