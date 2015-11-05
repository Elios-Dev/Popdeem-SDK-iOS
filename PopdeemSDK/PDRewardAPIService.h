//
//  PDRewardAPIService.h
//  PopdeemSDK
//
//  Created by Niall Quinn on 04/11/2015.
//  Copyright © 2015 Popdeem. All rights reserved.
//

#import "PDAPIService.h"

@interface PDRewardAPIService : PDAPIService

- (void) getAllRewardsWithCompletion:(void (^)(NSError *error))completion;
- (void) getAllRewardsForLocationWithId:(NSInteger)locationIdentifier completion:(void (^)(NSError *error))completion;
- (void) getAllRewardsForBrandId:(NSInteger)brandid completion:(void (^)(NSError *error))completion;

@end
