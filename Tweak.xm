// Tweak.xm - JQYSAdAuto v12
// Captures scene ID from showAdWithSceneId: and auto-shows ads

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static void writeLog(NSString *msg) {
    NSString *path = @"/tmp/jqys_adauto.log";
    NSString *entry = [NSString stringWithFormat:@"[%@] %@\n", [NSDate date], msg];
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:path];
    if (!fh) {
        [entry writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } else {
        [fh seekToEndOfFile];
        [fh writeData:[entry dataUsingEncoding:NSUTF8StringEncoding]];
        [fh closeFile];
    }
}

%hook TradPlusAdRewarded

- (void)showAdWithSceneId:(NSString *)sceneId {
    NSString *logMsg = [NSString stringWithFormat:@"showAdWithSceneId: sceneId='%@'", sceneId ?: @"(nil)"];
    writeLog(logMsg);
    
    UIAlertView *av = [[UIAlertView alloc] 
        initWithTitle:@"JQYS Scene ID"
        message:[NSString stringWithFormat:@"sceneId=%@", sceneId ?: @"nil"]
        delegate:nil 
        cancelButtonTitle:@"OK" 
        otherButtonTitles:nil];
    [av show];
    
    %orig;
}

- (BOOL)isAdReady {
    BOOL ret = %orig;
    if (ret) {
        writeLog(@"isAdReady=YES");
    }
    return ret;
}

%end

%ctor {
    writeLog(@"=== JQYSAdAuto v12 loaded ===");
}
