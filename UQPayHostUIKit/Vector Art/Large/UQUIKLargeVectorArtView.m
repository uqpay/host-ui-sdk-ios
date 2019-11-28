#import "UQUIKLargeVectorArtView.h"

@implementation UQUIKLargeVectorArtView

- (id)init {
    self = [super init];
    if (self) {
        self.artDimensions = CGSizeMake(80.0f, 80.0f);
        self.opaque = NO;
    }
    return self;
}

@end
