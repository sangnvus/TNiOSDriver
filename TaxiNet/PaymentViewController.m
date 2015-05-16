

#import "PaymentViewController.h"
#import "unity.h"
#import "AppDelegate.h"
@interface PaymentViewController ()

@end

@implementation PaymentViewController
{
    AppDelegate*appdelegate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view from its nib.
    [self.phonenumber setTitle:self.phone forState:UIControlStateNormal];
    NSString* distanceString = [[NSUserDefaults standardUserDefaults] stringForKey:@"distanceString"];
    self.distance.text=distanceString;
    self.price.text=[NSString stringWithFormat:@"%0.2f",[distanceString floatValue]*10];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callPhone:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString:[NSString stringWithFormat:@"tel:%@",self.phone]];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)SentPayment:(id)sender {
    appdelegate.GetDistance=0;
    
    NSString* distanceString = [[NSUserDefaults standardUserDefaults] stringForKey:@"distanceString"];
    NSString* requestid = [[NSUserDefaults standardUserDefaults] stringForKey:@"requestID"];
    [unity CompleteTrip:requestid cost:[NSString stringWithFormat:@"%0.2f",[distanceString floatValue]*10] distance:distanceString];
    [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
    }];
    //    }
    
}
@end
