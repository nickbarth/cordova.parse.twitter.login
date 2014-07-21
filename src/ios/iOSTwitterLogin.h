#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import <Cordova/CDV.h>

@interface iOSTwitterLogin: CDVPlugin{
  NSString* callbackId;
}

@property (nonatomic, retain) NSString* callbackId;
- (void)iOSTwitterLogin:(CDVInvokedUrlCommand *)command;
@end
