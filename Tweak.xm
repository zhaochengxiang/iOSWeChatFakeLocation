#import "iOSWeChatFakeLocation.h"
#import <CoreLocation/CoreLocation.h>

%hook SeePeopleNearByLogicController
- (void)onRetrieveLocationOK:(CLLocation*)location
{
    CGFloat lat = [[[NSUserDefaults standardUserDefaults] objectForKey:@"PD_FAKE_LOCATION_LAT"] doubleValue];
    CGFloat lng = [[[NSUserDefaults standardUserDefaults] objectForKey:@"PD_FAKE_LOCATION_LNG"] doubleValue];
    if (lat < 0.1 || lng < 0.1) {
        lat = 35.707013;
        lng = 139.730562;
    }

    location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];

    %orig;
}
%end

%hook NewSettingViewController

- (void)reloadTableData {
    %orig;

    MMTableViewInfo *tableViewInfo = MSHookIvar<id>(self, "m_tableViewInfo");

    MMTableViewSectionInfo *sectionInfo = [%c(MMTableViewSectionInfo) sectionInfoDefaut];

    MMTableViewCellInfo *fakeLocationCell = [%c(MMTableViewCellInfo) normalCellForSel:@selector(fakeLocation) target:self title:@"伪装定位" accessoryType:1];
    [sectionInfo addCell:fakeLocationCell];

    [tableViewInfo insertSection:sectionInfo At:0];

    MMTableView *tableView = [tableViewInfo getTableView];
    [tableView reloadData];
}

static MMPickLocationViewController* pickLocationViewController = nil;

%new
- (void)fakeLocation {
    pickLocationViewController = [[%c(MMPickLocationViewController) alloc] initWithScene:0 OnlyUseUserLocation:NO];

    pickLocationViewController.delegate = self;

    MMUINavigationController* nc = [[%c(MMUINavigationController) alloc] initWithRootViewController:pickLocationViewController];

    [self PresentModalViewController:nc animated:YES];
}

%new
- (UIBarButtonItem *)onGetRightBarButton {
    return [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onSureSeletctedLocation)];
}

%new
- (void)onCancelSeletctedLocation {
    if (pickLocationViewController) {
        [pickLocationViewController DismissMyselfAnimated:YES];
        [pickLocationViewController reportOnDone];
    }
}

%new
- (void)onSureSeletctedLocation {
    if (pickLocationViewController) {
        [pickLocationViewController DismissMyselfAnimated:YES];

        POIInfo* poiItem = [pickLocationViewController getCurrentPOIInfo];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:poiItem.coordinate.latitude] forKey:@"PD_FAKE_LOCATION_LAT"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:poiItem.coordinate.longitude] forKey:@"PD_FAKE_LOCATION_LNG"];
        [pickLocationViewController reportOnDone];
    }
}

%end
