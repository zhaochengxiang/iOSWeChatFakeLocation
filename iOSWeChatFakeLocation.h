
@interface MMTableView : UITableView

@end

@interface MMTableViewCellInfo : NSObject

+ (id)normalCellForSel:(SEL)sel target:(id)target title:(NSString*)title accessoryType:(long long)type;

@end

@interface MMTableViewSectionInfo : NSObject

+ (MMTableViewSectionInfo*)sectionInfoDefaut;
- (void)addCell:(MMTableViewCellInfo*)sectionInfo;

@end

@interface MMTableViewInfo : NSObject

- (MMTableView*)getTableView;
- (void)insertSection:(MMTableViewSectionInfo*)sectionInfo At:(unsigned int)index;

@end

@interface UIViewController (ModalView)
- (void)DismissMyselfAnimated:(BOOL)animated;
- (void)DismissModalViewControllerAnimated:(BOOL)animated;
- (void)PresentModalViewController:(id)arg1 animated:(BOOL)animated;

@end

@interface UINavigationController (LogicController)

- (void)PushViewController:(UIViewController*)vc animated:(BOOL)animated;

@end

@interface MMUIViewController : UIViewController

@end

@interface MMUINavigationController : UINavigationController

@end

@protocol MMPickLocationViewControllerDelegate

@optional
- (UIBarButtonItem *)onGetRightBarButton;
- (void)onCancelSeletctedLocation;

@end

@interface NewSettingViewController : MMUIViewController<MMPickLocationViewControllerDelegate>

- (void)reloadTableData;

@end

@interface MMSearchBarDisplayController : MMUIViewController

@end

@interface POIInfo : NSObject

@property(nonatomic) struct CLLocationCoordinate2D coordinate;

@end

@interface MMPickLocationViewController : MMSearchBarDisplayController

@property(nonatomic,weak) id <MMPickLocationViewControllerDelegate> delegate; // @synthesize delegate=_delegate;

- (id)initWithScene:(unsigned int)arg1 OnlyUseUserLocation:(BOOL)arg2;
- (POIInfo*)getCurrentPOIInfo;
- (void)reportOnDone;

@end





