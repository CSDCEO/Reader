//
//  CanvasContentTile.m
//  Reader
//
//  Created by Benoit Gour on 2/11/2014.
//
//

#import "CanvasContentTile.h"

@implementation CanvasContentTile
#pragma mark Constants

#define LEVELS_OF_DETAIL 8

#pragma mark CanvasContentTile class methods

+ (CFTimeInterval)fadeDuration
{
    return 0.025;
	//return 0.001; // iOS bug (flickering tiles) workaround
}

#pragma mark CanvasContentTile instance methods

- (id)init
{
	if ((self = [super init]))
	{
		self.levelsOfDetail = LEVELS_OF_DETAIL; // Zoom levels
		self.levelsOfDetailBias =LEVELS_OF_DETAIL/2; // Bias
        self.tileSize = CGSizeMake(512, 512);
      //  self.borderColor = [[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5] CGColor];
      //  self.borderWidth = 1.2;
	}
    
	return self;
}

@end
