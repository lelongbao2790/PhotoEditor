
#import "SNLoading.h"
#import "MBProgressHUD.h"

static MBProgressHUD *progressHud = nil;

@implementation SNLoading

+ (void)showWithTitle:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (progressHud)
        {
            [progressHud removeFromSuperview];
            progressHud = nil;
        }
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        progressHud = [[MBProgressHUD alloc] initWithWindow:window];
        progressHud.labelText = title ? title : @"Loading";
        progressHud.removeFromSuperViewOnHide = YES;
        [window addSubview:progressHud];
        [progressHud show:YES];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
    });
}

+ (void)hideWithTitle:(NSString *)title
{
    if (!progressHud) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        progressHud.labelText = title ? title : @"Loaded";
        [progressHud hide:YES];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    });
}

+ (void)updateWithTitle:(NSString *)title detailsText:(NSString *)detailsText
{
    progressHud.labelText = title ? title : @"Loading";
    progressHud.detailsLabelText = detailsText;
}

@end
