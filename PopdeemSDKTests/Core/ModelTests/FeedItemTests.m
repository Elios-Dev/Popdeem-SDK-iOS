//
//  FeedItemTests.m
//  PopdeemSDK
//
//  Created by Niall Quinn on 21/08/2015.
//  Copyright (c) 2015 Popdeem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "PDFeedItem.h"

@interface FeedItemTests : XCTestCase {
    PDFeedItem *feedItem;
}

@end

@implementation FeedItemTests

- (void)setUp {
    [super setUp];
    
    NSString *resourcePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"PDFeedItem_WithPicture" ofType:@"json"];
    NSString *userJSON = [NSString stringWithContentsOfFile:resourcePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [userJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = [[NSError alloc] initWithDomain:NSURLErrorDomain code:27501 userInfo:nil];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    
    feedItem = [[PDFeedItem alloc] initFromAPI:json];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testItemExists {
    expect(feedItem).toNot.beNil;
}

- (void) testBrandName {
    expect(feedItem.brandName).to.equal(@"Popdeem Bakery");
}

- (void) testBrandLogo {
    expect(feedItem.brandLogoUrlString).to.equal(@"http://s3-eu-west-1.amazonaws.com/popdeem-staging/brands/logo_images/000/000/010/original/popdeem_logo.png?1370879332");
}

- (void) testRewardType {
    expect(feedItem.rewardTypeString).to.equal(@"coupon");
}

- (void) testRewardDescription {
    expect(feedItem.descriptionString).to.equal(@"Free Coffee");
}

- (void) testTimeAgo {
    expect(feedItem.timeAgoString).to.equal(@"10 months ago");
}

- (void) testPictureUrl {
    expect(feedItem.imageUrlString).to.equal(@"http://s3-eu-west-1.amazonaws.com/popdeem-staging/requests/photos/000/000/455/original/455.png?1413206567");
}

- (void) testUserName {
    expect(feedItem.userFirstName).to.equal(@"Niall");
    expect(feedItem.userLastName).to.equal(@"Quinn");
}

- (void) testUserIdentifier {
    expect(feedItem.userId).to.equal(1231);
}

- (void) testUserProfilePic {
    expect(feedItem.userProfilePicUrlString).to.equal(@"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfp1/v/t1.0-1/p200x200/10561791_10152587847771069_6128016419296960032_n.jpg?oh=dfcfc553c9aaf041416d0860c08d2c43&oe=561003BD&__gda__=1444320298_77b07a28640de42951ba6293df2e9621");
}

@end
