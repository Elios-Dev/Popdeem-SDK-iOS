//
//  PDLocationAPIService.m
//  PopdeemSDK
//
//  Created by Niall Quinn on 04/11/2015.
//  Copyright © 2015 Popdeem. All rights reserved.
//

#import "PDLocationAPIService.h"
#import "PDLocation.h"
#import "PDLocationStore.h"

@implementation PDLocationAPIService

- (id) init {
    if (self = [super init]) {
        return self;
    }
    return nil;
}

- (void) getAllLocationsWithCompletion:(void (^)(NSError *error))completion {
    NSURLSession *session = [NSURLSession createPopdeemSession];
    NSString *path = [NSString stringWithFormat:@"%@/%@",self.baseUrl, LOCATIONS_PATH];
    [session GET:path params:nil completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(error);
            });
        }
        NSError *jsonError;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        for (id loc in jsonObject[@"locations"]) {
            PDLocation *location = [[PDLocation alloc] initFromApi:loc];
            [PDLocationStore add:location];
        }
        [session invalidateAndCancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil);
        });
    }];
}

- (void) getLocationForId:(NSInteger)identifier completion:(void (^)(NSError *error))completion {
    NSURLSession *session = [NSURLSession createPopdeemSession];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%ld",self.baseUrl,LOCATIONS_PATH,(long)identifier];
    [session GET:path params:nil completion:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(error);
            });
        }
        NSError *jsonError;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        PDLocation *location = [[PDLocation alloc] initFromApi:jsonObject[@"location"]];
        [PDLocationStore add:location];
        [session invalidateAndCancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil);
        });
    }];
}

- (void) getLocationsForBrandId:(NSInteger)brandId completion:(void (^)(NSError *error))completion {
    NSURLSession *session = [NSURLSession createPopdeemSession];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%ld/locations",self.baseUrl,BRANDS_PATH,(long)brandId];
    [session GET:path params:nil completion:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(error);
            });
        }
        NSError *jsonError;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        for (id loc in jsonObject[@"locations"]) {
            PDLocation *location = [[PDLocation alloc] initFromApi:loc];
            [PDLocationStore add:location];
        }
        [session invalidateAndCancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil);
        });
    }];
}

@end
