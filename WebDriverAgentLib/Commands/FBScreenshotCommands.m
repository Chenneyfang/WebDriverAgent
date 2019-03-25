/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "FBScreenshotCommands.h"

#import "XCUIDevice+FBHelpers.h"

#import "XCUIScreen.h"

#import "ScreenHelper.h"

@implementation FBScreenshotCommands

#pragma mark - <FBCommandHandler>

+ (NSArray *)routes
{
  return
  @[
    [[FBRoute GET:@"/screenshot"].withoutSession respondWithTarget:self action:@selector(handleGetScreenshot:)],
    [[FBRoute GET:@"/screenshot"] respondWithTarget:self action:@selector(handleGetScreenshot:)],
  ];
}


#pragma mark - Commands

+ (id<FBResponsePayload>)handleGetScreenshot:(FBRouteRequest *)request
{
//  NSError *error;
//  NSData *screenshotData = [[XCUIDevice sharedDevice] fb_screenshotWithError:&error];
//  if (nil == screenshotData) {
//    return FBResponseWithError(error);
//  }
//  NSString *screenshot = [screenshotData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//  return FBResponseWithObject(screenshot);
  NSError *error;
  
  CGRect rect = [ScreenHelper screenRect];
  NSData * data = (NSData* )[[XCUIScreen mainScreen] screenshotDataForQuality:1 rect:rect error:&error];

  if (data) {
    NSString *screenshot = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return FBResponseWithObject(screenshot);
  }
  else{
    return FBResponseWithError(error);
  }
}

@end
