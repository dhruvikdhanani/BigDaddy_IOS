//
//  UIViewController+EXTRA.m
//  Demo
//

#import "UIViewController+EXTRA.h"
#import <objc/runtime.h>

@implementation UIViewController (EXTRA)
static char const * const IsBackTagKey = "iSBACKBUTTON";
- (void) setIsBackButton:(BOOL)isBackButton
{
    NSNumber *number = [NSNumber numberWithBool: isBackButton];
    objc_setAssociatedObject(self, IsBackTagKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL) isBackButton
{
    NSNumber *number = objc_getAssociatedObject(self, IsBackTagKey);
    return [number boolValue];
    
    

}
@end
