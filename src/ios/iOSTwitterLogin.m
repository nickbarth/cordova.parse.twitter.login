#import "iOSTwitterLogin.h"

@implementation iOSTwitterLogin

@synthesize callbackId;

- (void)iOSTwitterLogin:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;

    PFUser *currentUser = [PFUser currentUser];
    
    if (![PFTwitterUtils isLinkedWithUser:currentUser]) {
        [PFTwitterUtils linkUser:currentUser block:^(BOOL succeeded, NSError *error) {
            NSString *result = [NSString stringWithFormat: @"{ \"error\": \"%@\" }", error];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        }];
    }
    
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (user) {
            NSString *result = [NSString stringWithFormat: @"{ \"error\": false, \"sessionToken\": \"%@\" }", user.sessionToken];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        } else if (error) {
            NSString *result = [NSString stringWithFormat: @"{ \"error\": \"%@\" }", error];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        } else {
            NSString *result = @"{ \"error\": \"Request for Twitter Login was declined.\" }";
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        }
    }];
}

@end
