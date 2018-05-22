%
% This .m file defines all the global variables
%

%
% Global variables that stores paths and user-entered parameters. This
% variables can be saved to a file, thus saving all the information of a
% patient 'case'.
%
global path1 path2 path3 path4 path5 path6 Focus_distance Patient_case current_path N_ctrl_pts
%
% path1, path2, path3, path4:   Path+filename of the four DICOM files of
%                               angiographies.
%
% Focus_distance:   The focus to global reference system origin distance.
%
% Patient_case:     The patht to a saved (or loaded) patient case.
%
% current_path:     Temporary path used to simplify the loading of
%                   different DICOMs from the same directory.
% 
% N_ctrl_pts:       The number of control points (this variable is set in
%                   Ifusion_Global.m)
%

%
% Global variables representing input data (e.g. dicom data) and
% important/relevant data in the iFusion process.
%
global CF_1 CF_2 CF_3 CF_4 BPB_L BPB_R APB_L APB_R CORO PullBack Curves Epi pts3D Spts3D 
%
% CF_1, CF_2, CF_3, CF_4:
%
% BPB_L, BPB_R, APB_L, APB_R:   3D Volumes containing the
%                               - 'BeforePullBack_Left' angiography, the
%                               - 'BeforePullBack_Right' angiography, the 
%                               - 'AfterPullBack_Left' angiography and the
%                               - 'AfterPullBack_Right' angiography respectively.
%
% CORO:                         3D Volume containing the Coronography angiography                      
%
% PullBack:	3D Volume of the IVUS pullback.
%
% Curves:   Curve is a cell array of two elements, one for the 'left' curve
%           (Curves{1}) and one for the 'right' curve (Curves{2}). Each
%           cells contain a structure with different fields:
%           - .coor[]           ---> Nx2 array of 2D curve coordinates.
%           - .old_curve[]      ---> Nx2 array of 2D curve coordinates.
%           - .ctrl_points{}    ---> 1x5 cell array containing 'impoint'
%                                    objects.
%           - .api{}            ---> 1x5 cell array containing the api
%                                    structures for the control points.
%           - .pointer          ---> handle of the 'plot' object that shows
%                                    the curve.
%
% Epi:      Handler of the graphical segment that represent the epipolar
%           line.
%
% pts3D:    An Mx3 array of 3D points that represent the reconstructed
%           point.
%
% Spts3D:   Temporary variable that mirrors pts3D.
%

%
% Lists of candidate points to be used as the tip (start of the path) and
% extreme (end of the path) plus the 4 selected points.
%
global TipCandLeft TipCandRight ExtCandLeft ExtCandRight Tip_R Tip_L Ext_R Ext_L TipSlide_R TipSlide_L 
%
% TipCandLeft TipCandRight: Two arrays of Nx2 elements containing the 2D
%                           coordinates of candidate points for the catether
%                           tip (path starting point).
%
% ExtCandLeft ExtCandRight: Two arrays of Nx2 elements containing the 2D
%                           coordinates of candidate points for the extreme
%                           (path ending point).
%
% Tip_R Tip_L:              Selected tip points for the 'right' and 'left'
%                           images respectively.
%
% Ext_R Ext_L:              Selected extreme points for the 'right' and 'left'
%                           images respectively.
%
% TipSlide_R  TipSlide_L:   Two integer indices that points to the best
%                           'right' and 'left' frames from the BPB_R and BPB_L
%                           angiography videos. These frames are selected in
%                           interface_2.m; see that function for details.

%
% Variables storing information regarding the geometry of local reference systems.
%
global l k c C F im_size sc_fact old_case
%
% l k c:    The 'l', 'k' and 'c' axis of the local reference systems. Each
%           variable is a 2x3 matrix. First rows refers to 'left' local reference
%           system. Second rows refers to 'right' local reference system.
%
% C:        A 1x2 matrix containing the local reference system center to
%           global reference system center distance. Column 1 refers to
%           'left' local reference system, column 2 to the 'right' one.
%
% F:        A 1x2 matrix containing the focus to global reference system
%           center distance. Column 1 refers to 'left' local reference system,
%           column 2 to the 'right'.
%
% im_size:  The size, in pixel, of the angiographies (this variable is set in
%           Ifusion_Global.m)
%
% sc_fact:  The scale factor to convert pixels in the angiography to real world
%           millimeters (this variable is set in Ifusion_Global.m).
%
% old_case: This variable can assume two values:
%           - 0: We are running a brand new clinical case.
%           - 1: We are running using data loaded from a previously stored
%                case.
%
     
%
% Variables for the Ifusion_interface_3.m
%
global  r m1 m2 long a b a2 centerx centery im6 im2 p2 p6 p5 Coronary_curve PB_real
%
% r:                Radius of the IVUS short-axis image.
%
% m1, m2:           Distances of different markers to the beginning of the IVUS
%                   pullback, as shown in the visual interface Ifusion_interface_3.fig      
%
% long:             The distance between m1 and m2, i.e. abs(m1 - m2).
%
% a, b, a2:         Auxiliary variables to compute the IVUS longitudinal cuts.
%
% centerx, centery: The coordinates of the center of short-axis IVUS image.
%
% im6, im2:         Current image in axes 6 and 2 of
%                   Ifusion_interface_3.fig
%
% p2, p5, p6:       Auxiliary variables to store click positions in the
%                   axes, respectively the number 2, 5 and 6.
%
% Coronary_curve:   A Nx2 matrix containing the 2D curve plotted on the
%                   Coronography in axes 2.
%
% PB_real:          This variable can assume two values:
%                   - 0: The user does not desire to load the IVUS pullback;
%                        the system will work in 'simulation' mode. 
%                   - 1: The user desire to load the IVUS pullback. The
%                        system will try to load it, if there is enough memory.
%
