#import "BlogDetailHeaderView.h"
#import "Blog.h"
#import "UIImageView+Gravatar.h"

const CGFloat BlogDetailHeaderViewBlavatarSize = 60.0;
const CGFloat BlogDetailHeaderViewLabelHeight = 18.0;

@interface BlogDetailHeaderView ()

@property (nonatomic, strong) UIImageView *blavatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation BlogDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _blavatarImageView = [self imageViewForBlavatar];
        [self addSubview:_blavatarImageView];

        _titleLabel = [self labelForTitle];
        [self addSubview:_titleLabel];

        _subtitleLabel = [self labelForSubtitle];
        [self addSubview:_subtitleLabel];

        [self configureConstraints];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setBlog:(Blog *)blog
{
    [self.blavatarImageView setImageWithBlavatarUrl:blog.blavatarUrl isWPcom:blog.isWPcom];
    [self.titleLabel setText:blog.blogName];
    [self.subtitleLabel setText:blog.url];
}

#pragma mark - Private Methods

- (void)configureConstraints
{
    NSDictionary *views = NSDictionaryOfVariableBindings(_blavatarImageView, _titleLabel, _subtitleLabel);
    NSDictionary *metrics = @{@"blavatarSize": @(BlogDetailHeaderViewBlavatarSize),
                              @"labelHeight":@(BlogDetailHeaderViewLabelHeight)};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_blavatarImageView(blavatarSize)]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_blavatarImageView(blavatarSize)]-[_titleLabel]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_blavatarImageView(blavatarSize)]-[_subtitleLabel]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel(labelHeight)]-[_subtitleLabel(labelHeight)]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    [super setNeedsUpdateConstraints];
}

#pragma mark - Subview factories

- (UILabel *)labelForTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 1;
    label.backgroundColor = [UIColor clearColor];
    label.opaque = YES;
    label.textColor = [WPStyleGuide littleEddieGrey];
    label.font = [WPStyleGuide subtitleFont];
    label.adjustsFontSizeToFitWidth = NO;

    return label;
}

- (UILabel *)labelForSubtitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 1;
    label.backgroundColor = [UIColor clearColor];
    label.opaque = YES;
    label.textColor = [WPStyleGuide allTAllShadeGrey];
    label.font = [WPStyleGuide subtitleFont];
    label.adjustsFontSizeToFitWidth = NO;

    return label;
}

- (UIImageView *)imageViewForBlavatar
{
    CGRect blavatarFrame = CGRectMake(0.0f, 0.0f, BlogDetailHeaderViewBlavatarSize, BlogDetailHeaderViewBlavatarSize);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:blavatarFrame];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    return imageView;
}

@end