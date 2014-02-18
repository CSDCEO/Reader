//
//  ReaderAnnotationToolbar.h
//  Reader
//
//  Created by Benoit Gour on 2/18/2014.
//
//

#import <Foundation/Foundation.h>

@protocol ReaderAnnotationToolbarDelegate <NSObject>

@end

@interface ReaderAnnotationToolbar : UIView

@property (nonatomic, weak, readwrite) id <ReaderAnnotationToolbarDelegate> delegate;

- (id) initWithFrame:(CGRect)frame;

- (void)hideToolbar;
- (void)showToolbar;

@end

@interface ReaderAnnotationToolbarShadow : UIView

@end