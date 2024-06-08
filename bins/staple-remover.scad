include <base.scad>

/* [General Settings] */
// number of bases along x-axis
gridx = 3;
// number of bases along y-axis
gridy = 1;
// bin height. See bin height information and "gridz_define" below.
gridz = 4;

/* [Linear Compartments] */
// number of X Divisions (set to zero to have solid bin)
divx = 0;
// number of Y Divisions (set to zero to have solid bin)
divy = 0;

/* [Cylindrical Compartments] */
// number of cylindrical X Divisions (mutually exclusive to Linear Compartments)
cdivx = 0;
// number of cylindrical Y Divisions (mutually exclusive to Linear Compartments)
cdivy = 0;
// orientation
c_orientation = 2; // [0: x direction, 1: y direction, 2: z direction]
// diameter of cylindrical cut outs
cd = 10;
// cylinder height
ch = 1;
// spacing to lid
c_depth = 1;
// chamfer around the top rim of the holes
c_chamfer = 0.5;

module obj() {
    translate([-30,0,20]) rotate([0,0,90]) cube([30.5, 14, 31], true);
    
    for (i = [1:1:5])
        for (j = [1:1:2])
            translate([(12*i)-30,(20*j)-37,15]) cube([7, 14, 60]);
}


difference() {
    union() {
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {

            if (divx > 0 && divy > 0) {

                cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop);

            } else if (cdivx > 0 && cdivy > 0) {

                cutCylinders(n_divx=cdivx, n_divy=cdivy, cylinder_diameter=cd, cylinder_height=ch, coutout_depth=c_depth, orientation=c_orientation, chamfer=c_chamfer);
            }
        }
        gridfinityBase(gridx, gridy, l_grid, div_base_x, div_base_y, style_hole, only_corners=only_corners);
    }

    obj();
}