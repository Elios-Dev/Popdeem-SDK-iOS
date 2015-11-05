//
//  PDBrandApiService.m
//  PopdeemSDK
//
//  Created by Niall Quinn on 04/11/2015.
//  Copyright © 2015 Popdeem. All rights reserved.
//

#import "PDBrandApiService.h"
#import "PDBrand.h"
#import "PDBrandStore.h"

@implementation PDBrandApiService

-(id) init {
    if (self = [super init]) {
        return self;
    }
    return nil;
}

- (void) getBrandsWithCompletion:(void (^)(NSError *error))completion {
    
    NSURLSession *session = [NSURLSession createPopdeemSession];
    NSString *path = [NSString stringWithFormat:@"%@,%@",self.baseUrl,BRANDS_PATH];
    [session GET:path params:nil completion:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(error);
            });
        }
        NSError *jsonError;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        for (id attributes in jsonObject[@"brands"]) {
            PDBrand *b = [[PDBrand alloc] initFromApi:attributes];
            if ([PDBrandStore findBrandByIdentifier:b.identifier] == nil) {
                [PDBrandStore add:b];
            } else {
                [[PDBrandStore findBrandByIdentifier:b.identifier] setNumberOfRewardsAvailable:b.numberOfRewardsAvailable];
            }
        }
        [session invalidateAndCancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil);
        });
    }];
}

@end
