//
//  PDFeedAPIService.m
//  PopdeemSDK
//
//  Created by Niall Quinn on 04/11/2015.
//  Copyright © 2015 Popdeem. All rights reserved.
//

#import "PDFeedAPIService.h"
#import "PDFeeds.h"

@implementation PDFeedAPIService

-(id) init {
    if (self = [super init]) {
        return self;
    }
    return nil;
}

- (void) getFeedsWithCompletion:(void (^)(NSError *error))completion {
    [self getFeedsLimit:20 completion:completion];
}

- (void) getFeedsLimit:(NSInteger)limit completion:(void (^)(NSError *error))completion {
    NSURLSession *session = [NSURLSession createPopdeemSession];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",limit],@"limit", nil];
    NSString *path = [NSString stringWithFormat:@"%@/%@",self.baseUrl,FEEDS_PATH];
    [session GET:path params:params completion:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(error);
            });
            return;
        }
        NSError *jsonError;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        NSArray *feeds = [jsonObject objectForKey:@"feeds"];
        [PDFeeds populateFromAPI:feeds];
        [session invalidateAndCancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil);
        });
    }];
}

@end
