

import UIKit

class YYSideMenuController: UIViewController {

    var needSwipeShowMenu:Bool!
    var leftViewController:UIViewController!
    var rightViewController:UIViewController!
    var rootViewController:UIViewController!
    
    var leftViewShowWidth:Float!
    var rightViewShowWidth:Float!
    
    var animationDuration:NSTimeInterval!
    var showBoundsShadow:Bool!
    
    var rootViewMoveBlock:(rootView:UIView,orginFrame:CGRect,xoffset:Float)->() = {(rootView:UIView,orginFrame:CGRect,xoffset:Float)->() in}
    
    
    func setRootViewMoveBlock(rootViewMoveBlock:(rootView:UIView,orginFrame:CGRect,xoffset:Float)->()){
        
    }
    
    func showLeftViewController(animatied:Bool){
        
    }
    
    func showRightViewController(animatied:Bool){
        
    }
    
    func showRootViewController(animatied:Bool){
        
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
