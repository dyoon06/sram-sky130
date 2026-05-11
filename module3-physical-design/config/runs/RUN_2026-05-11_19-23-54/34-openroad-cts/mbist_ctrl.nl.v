module mbist_ctrl (clk,
    done,
    mem_ce,
    mem_we,
    pass_fail,
    rst,
    start,
    diag_addr,
    mem_addr,
    mem_din,
    mem_dout);
 input clk;
 output done;
 output mem_ce;
 output mem_we;
 output pass_fail;
 input rst;
 input start;
 output [7:0] diag_addr;
 output [7:0] mem_addr;
 output [7:0] mem_din;
 input [7:0] mem_dout;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire _117_;
 wire _118_;
 wire _119_;
 wire _120_;
 wire _121_;
 wire _122_;
 wire _123_;
 wire _124_;
 wire _125_;
 wire _126_;
 wire _127_;
 wire _128_;
 wire _129_;
 wire _130_;
 wire _131_;
 wire _132_;
 wire _133_;
 wire _134_;
 wire _135_;
 wire _136_;
 wire _137_;
 wire _138_;
 wire _139_;
 wire _140_;
 wire _141_;
 wire _142_;
 wire _143_;
 wire _144_;
 wire _145_;
 wire diag_captured;
 wire \phase[0] ;
 wire \phase[1] ;
 wire \phase[2] ;
 wire \read_data[0] ;
 wire \read_data[1] ;
 wire \read_data[2] ;
 wire \read_data[3] ;
 wire \read_data[4] ;
 wire \read_data[5] ;
 wire \read_data[6] ;
 wire \read_data[7] ;
 wire \state[0] ;
 wire \state[1] ;
 wire \state[2] ;
 wire \state[3] ;
 wire \state[4] ;
 wire \state[5] ;
 wire \state[6] ;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net22;
 wire net23;
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net30;
 wire net31;
 wire net32;
 wire net33;
 wire net34;
 wire net35;
 wire net36;
 wire net37;
 wire net38;
 wire net39;
 wire net40;
 wire net41;
 wire net42;
 wire net43;
 wire net44;
 wire net45;
 wire net46;
 wire clknet_0_clk;
 wire clknet_2_0__leaf_clk;
 wire clknet_2_1__leaf_clk;
 wire clknet_2_2__leaf_clk;
 wire clknet_2_3__leaf_clk;

 sky130_fd_sc_hd__inv_2 _146_ (.A(diag_captured),
    .Y(_137_));
 sky130_fd_sc_hd__inv_2 _147_ (.A(\state[6] ),
    .Y(_138_));
 sky130_fd_sc_hd__inv_2 _148_ (.A(\state[5] ),
    .Y(_139_));
 sky130_fd_sc_hd__inv_2 _149_ (.A(net45),
    .Y(_140_));
 sky130_fd_sc_hd__or2_4 _150_ (.A(\state[5] ),
    .B(\state[1] ),
    .X(_141_));
 sky130_fd_sc_hd__nor2_1 _151_ (.A(\state[2] ),
    .B(\state[1] ),
    .Y(_142_));
 sky130_fd_sc_hd__or4_2 _152_ (.A(\state[6] ),
    .B(\state[5] ),
    .C(\state[2] ),
    .D(\state[1] ),
    .X(_143_));
 sky130_fd_sc_hd__and2_1 _153_ (.A(\phase[2] ),
    .B(_143_),
    .X(_144_));
 sky130_fd_sc_hd__nand2_2 _154_ (.A(\phase[2] ),
    .B(_143_),
    .Y(_145_));
 sky130_fd_sc_hd__nand2_1 _155_ (.A(net21),
    .B(net20),
    .Y(_040_));
 sky130_fd_sc_hd__and3_1 _156_ (.A(net22),
    .B(net21),
    .C(net20),
    .X(_041_));
 sky130_fd_sc_hd__and4_2 _157_ (.A(net23),
    .B(net22),
    .C(net21),
    .D(net20),
    .X(_042_));
 sky130_fd_sc_hd__nand2_1 _158_ (.A(net40),
    .B(_042_),
    .Y(_043_));
 sky130_fd_sc_hd__nand3_1 _159_ (.A(net25),
    .B(net40),
    .C(_042_),
    .Y(_044_));
 sky130_fd_sc_hd__and4_1 _160_ (.A(net26),
    .B(net25),
    .C(net40),
    .D(_042_),
    .X(_045_));
 sky130_fd_sc_hd__inv_2 _161_ (.A(_045_),
    .Y(_046_));
 sky130_fd_sc_hd__and2_2 _162_ (.A(net27),
    .B(_045_),
    .X(_047_));
 sky130_fd_sc_hd__a21bo_1 _163_ (.A1(net27),
    .A2(_045_),
    .B1_N(\state[4] ),
    .X(_048_));
 sky130_fd_sc_hd__nand2b_2 _164_ (.A_N(net10),
    .B(\state[0] ),
    .Y(_049_));
 sky130_fd_sc_hd__nor3_1 _165_ (.A(\state[6] ),
    .B(\state[2] ),
    .C(\state[1] ),
    .Y(_050_));
 sky130_fd_sc_hd__or3_1 _166_ (.A(\state[6] ),
    .B(\state[4] ),
    .C(\state[2] ),
    .X(_051_));
 sky130_fd_sc_hd__or2_1 _167_ (.A(\state[0] ),
    .B(\state[1] ),
    .X(_052_));
 sky130_fd_sc_hd__o31a_1 _168_ (.A1(\state[0] ),
    .A2(_141_),
    .A3(net39),
    .B1(_049_),
    .X(_053_));
 sky130_fd_sc_hd__nand2_1 _169_ (.A(_048_),
    .B(_053_),
    .Y(_054_));
 sky130_fd_sc_hd__and2_1 _170_ (.A(net42),
    .B(\phase[1] ),
    .X(_055_));
 sky130_fd_sc_hd__a22o_1 _171_ (.A1(net42),
    .A2(_144_),
    .B1(_054_),
    .B2(_055_),
    .X(_001_));
 sky130_fd_sc_hd__and3_1 _172_ (.A(net42),
    .B(\phase[0] ),
    .C(_143_),
    .X(_056_));
 sky130_fd_sc_hd__a31o_1 _173_ (.A1(net42),
    .A2(\phase[2] ),
    .A3(_054_),
    .B1(_056_),
    .X(_002_));
 sky130_fd_sc_hd__nand2_1 _174_ (.A(net42),
    .B(_049_),
    .Y(_003_));
 sky130_fd_sc_hd__a21oi_1 _175_ (.A1(\phase[1] ),
    .A2(_047_),
    .B1(net45),
    .Y(_057_));
 sky130_fd_sc_hd__a32o_1 _176_ (.A1(net41),
    .A2(\state[4] ),
    .A3(_047_),
    .B1(_057_),
    .B2(\state[2] ),
    .X(_005_));
 sky130_fd_sc_hd__or2_1 _177_ (.A(net21),
    .B(net20),
    .X(_058_));
 sky130_fd_sc_hd__or4_2 _178_ (.A(net23),
    .B(net22),
    .C(net21),
    .D(net20),
    .X(_059_));
 sky130_fd_sc_hd__or3_1 _179_ (.A(net25),
    .B(net40),
    .C(_059_),
    .X(_060_));
 sky130_fd_sc_hd__or4_1 _180_ (.A(net26),
    .B(net25),
    .C(net40),
    .D(_059_),
    .X(_061_));
 sky130_fd_sc_hd__nor2_1 _181_ (.A(net27),
    .B(_061_),
    .Y(_062_));
 sky130_fd_sc_hd__a32o_1 _182_ (.A1(\state[5] ),
    .A2(_055_),
    .A3(_062_),
    .B1(net42),
    .B2(\state[3] ),
    .X(_006_));
 sky130_fd_sc_hd__and2_1 _183_ (.A(net43),
    .B(\state[0] ),
    .X(_063_));
 sky130_fd_sc_hd__a2bb2o_1 _184_ (.A1_N(net46),
    .A2_N(_048_),
    .B1(_063_),
    .B2(net10),
    .X(_007_));
 sky130_fd_sc_hd__a21oi_1 _185_ (.A1(\phase[1] ),
    .A2(_062_),
    .B1(net45),
    .Y(_064_));
 sky130_fd_sc_hd__and3_1 _186_ (.A(\state[6] ),
    .B(_047_),
    .C(_055_),
    .X(_065_));
 sky130_fd_sc_hd__a21o_1 _187_ (.A1(\state[1] ),
    .A2(_064_),
    .B1(_065_),
    .X(_004_));
 sky130_fd_sc_hd__a32o_1 _188_ (.A1(\state[1] ),
    .A2(_055_),
    .A3(_062_),
    .B1(_064_),
    .B2(\state[5] ),
    .X(_008_));
 sky130_fd_sc_hd__a32o_1 _189_ (.A1(\state[2] ),
    .A2(_047_),
    .A3(_055_),
    .B1(_057_),
    .B2(\state[6] ),
    .X(_009_));
 sky130_fd_sc_hd__nor2_1 _190_ (.A(\state[0] ),
    .B(_143_),
    .Y(_066_));
 sky130_fd_sc_hd__o31a_1 _191_ (.A1(\state[4] ),
    .A2(_063_),
    .A3(_066_),
    .B1(\phase[0] ),
    .X(_067_));
 sky130_fd_sc_hd__and2_1 _192_ (.A(\phase[1] ),
    .B(_143_),
    .X(_068_));
 sky130_fd_sc_hd__a211o_1 _193_ (.A1(\state[0] ),
    .A2(net10),
    .B1(_068_),
    .C1(net46),
    .X(_069_));
 sky130_fd_sc_hd__a211o_1 _194_ (.A1(\state[4] ),
    .A2(_047_),
    .B1(_067_),
    .C1(_069_),
    .X(_000_));
 sky130_fd_sc_hd__or4_1 _195_ (.A(\read_data[3] ),
    .B(\read_data[2] ),
    .C(\read_data[1] ),
    .D(\read_data[0] ),
    .X(_070_));
 sky130_fd_sc_hd__or4_1 _196_ (.A(\read_data[7] ),
    .B(\read_data[6] ),
    .C(\read_data[5] ),
    .D(\read_data[4] ),
    .X(_071_));
 sky130_fd_sc_hd__or3_1 _197_ (.A(_142_),
    .B(_070_),
    .C(_071_),
    .X(_072_));
 sky130_fd_sc_hd__and4_1 _198_ (.A(\read_data[5] ),
    .B(\read_data[4] ),
    .C(\read_data[3] ),
    .D(\read_data[2] ),
    .X(_073_));
 sky130_fd_sc_hd__o211a_1 _199_ (.A1(\state[6] ),
    .A2(\state[5] ),
    .B1(\read_data[7] ),
    .C1(\read_data[6] ),
    .X(_074_));
 sky130_fd_sc_hd__and3_1 _200_ (.A(\read_data[1] ),
    .B(\read_data[0] ),
    .C(\phase[1] ),
    .X(_075_));
 sky130_fd_sc_hd__nand3_1 _201_ (.A(_073_),
    .B(_074_),
    .C(_075_),
    .Y(_076_));
 sky130_fd_sc_hd__nand3_1 _202_ (.A(_068_),
    .B(_072_),
    .C(_076_),
    .Y(_077_));
 sky130_fd_sc_hd__and4_2 _203_ (.A(_137_),
    .B(_068_),
    .C(_072_),
    .D(_076_),
    .X(_078_));
 sky130_fd_sc_hd__or2_2 _204_ (.A(diag_captured),
    .B(_077_),
    .X(_079_));
 sky130_fd_sc_hd__a21o_1 _205_ (.A1(net20),
    .A2(_078_),
    .B1(net45),
    .X(_080_));
 sky130_fd_sc_hd__a21o_1 _206_ (.A1(net11),
    .A2(_079_),
    .B1(_080_),
    .X(_010_));
 sky130_fd_sc_hd__a21o_1 _207_ (.A1(net21),
    .A2(_078_),
    .B1(net45),
    .X(_081_));
 sky130_fd_sc_hd__a21o_1 _208_ (.A1(net12),
    .A2(_079_),
    .B1(_081_),
    .X(_011_));
 sky130_fd_sc_hd__a21o_1 _209_ (.A1(net22),
    .A2(_078_),
    .B1(net45),
    .X(_082_));
 sky130_fd_sc_hd__a21o_1 _210_ (.A1(net13),
    .A2(_079_),
    .B1(_082_),
    .X(_012_));
 sky130_fd_sc_hd__a21o_1 _211_ (.A1(net23),
    .A2(_078_),
    .B1(net45),
    .X(_083_));
 sky130_fd_sc_hd__a21o_1 _212_ (.A1(net14),
    .A2(_079_),
    .B1(_083_),
    .X(_013_));
 sky130_fd_sc_hd__a21o_1 _213_ (.A1(net24),
    .A2(_078_),
    .B1(net46),
    .X(_084_));
 sky130_fd_sc_hd__a21o_1 _214_ (.A1(net15),
    .A2(_079_),
    .B1(_084_),
    .X(_014_));
 sky130_fd_sc_hd__a21o_1 _215_ (.A1(net25),
    .A2(_078_),
    .B1(net46),
    .X(_085_));
 sky130_fd_sc_hd__a21o_1 _216_ (.A1(net16),
    .A2(_079_),
    .B1(_085_),
    .X(_015_));
 sky130_fd_sc_hd__a21o_1 _217_ (.A1(net26),
    .A2(_078_),
    .B1(net46),
    .X(_086_));
 sky130_fd_sc_hd__a21o_1 _218_ (.A1(net17),
    .A2(_079_),
    .B1(_086_),
    .X(_016_));
 sky130_fd_sc_hd__a21o_1 _219_ (.A1(net27),
    .A2(_078_),
    .B1(net45),
    .X(_087_));
 sky130_fd_sc_hd__a21o_1 _220_ (.A1(net18),
    .A2(_079_),
    .B1(_087_),
    .X(_017_));
 sky130_fd_sc_hd__o21ba_1 _221_ (.A1(_141_),
    .A2(net39),
    .B1_N(net20),
    .X(_088_));
 sky130_fd_sc_hd__nand2b_1 _222_ (.A_N(\phase[1] ),
    .B(_143_),
    .Y(_089_));
 sky130_fd_sc_hd__o311a_2 _223_ (.A1(net27),
    .A2(_139_),
    .A3(_061_),
    .B1(_089_),
    .C1(_053_),
    .X(_090_));
 sky130_fd_sc_hd__a21bo_2 _224_ (.A1(\state[6] ),
    .A2(_047_),
    .B1_N(_090_),
    .X(_091_));
 sky130_fd_sc_hd__o221a_1 _225_ (.A1(net20),
    .A2(_090_),
    .B1(_091_),
    .B2(_088_),
    .C1(net41),
    .X(_018_));
 sky130_fd_sc_hd__and2_1 _226_ (.A(_040_),
    .B(_058_),
    .X(_092_));
 sky130_fd_sc_hd__mux2_1 _227_ (.A0(_141_),
    .A1(net39),
    .S(_092_),
    .X(_093_));
 sky130_fd_sc_hd__o221a_1 _228_ (.A1(net21),
    .A2(_090_),
    .B1(_091_),
    .B2(_093_),
    .C1(net44),
    .X(_019_));
 sky130_fd_sc_hd__xnor2_1 _229_ (.A(net22),
    .B(_058_),
    .Y(_094_));
 sky130_fd_sc_hd__a21oi_1 _230_ (.A1(net21),
    .A2(net20),
    .B1(net22),
    .Y(_095_));
 sky130_fd_sc_hd__nor2_1 _231_ (.A(_041_),
    .B(_095_),
    .Y(_096_));
 sky130_fd_sc_hd__a22o_1 _232_ (.A1(_141_),
    .A2(_094_),
    .B1(_096_),
    .B2(net39),
    .X(_097_));
 sky130_fd_sc_hd__o221a_1 _233_ (.A1(net22),
    .A2(_090_),
    .B1(_091_),
    .B2(_097_),
    .C1(net44),
    .X(_020_));
 sky130_fd_sc_hd__o21ai_1 _234_ (.A1(net22),
    .A2(_058_),
    .B1(net23),
    .Y(_098_));
 sky130_fd_sc_hd__nand2_1 _235_ (.A(_059_),
    .B(_098_),
    .Y(_099_));
 sky130_fd_sc_hd__o21ai_1 _236_ (.A1(net23),
    .A2(_041_),
    .B1(net39),
    .Y(_100_));
 sky130_fd_sc_hd__a2bb2o_1 _237_ (.A1_N(_042_),
    .A2_N(_100_),
    .B1(_099_),
    .B2(_141_),
    .X(_101_));
 sky130_fd_sc_hd__o221a_1 _238_ (.A1(net23),
    .A2(_090_),
    .B1(_091_),
    .B2(_101_),
    .C1(net43),
    .X(_021_));
 sky130_fd_sc_hd__xnor2_1 _239_ (.A(net40),
    .B(_059_),
    .Y(_102_));
 sky130_fd_sc_hd__or2_1 _240_ (.A(net40),
    .B(_042_),
    .X(_103_));
 sky130_fd_sc_hd__a32o_1 _241_ (.A1(_043_),
    .A2(net39),
    .A3(_103_),
    .B1(_102_),
    .B2(_141_),
    .X(_104_));
 sky130_fd_sc_hd__o221a_1 _242_ (.A1(net40),
    .A2(_090_),
    .B1(_091_),
    .B2(_104_),
    .C1(net43),
    .X(_022_));
 sky130_fd_sc_hd__o21ai_1 _243_ (.A1(net40),
    .A2(_059_),
    .B1(net25),
    .Y(_105_));
 sky130_fd_sc_hd__nand2_1 _244_ (.A(_060_),
    .B(_105_),
    .Y(_106_));
 sky130_fd_sc_hd__a21o_1 _245_ (.A1(net40),
    .A2(_042_),
    .B1(net25),
    .X(_107_));
 sky130_fd_sc_hd__a32o_1 _246_ (.A1(_044_),
    .A2(net39),
    .A3(_107_),
    .B1(_106_),
    .B2(_141_),
    .X(_108_));
 sky130_fd_sc_hd__o221a_1 _247_ (.A1(net25),
    .A2(_090_),
    .B1(_091_),
    .B2(_108_),
    .C1(net42),
    .X(_023_));
 sky130_fd_sc_hd__xnor2_1 _248_ (.A(net26),
    .B(_060_),
    .Y(_109_));
 sky130_fd_sc_hd__a31o_1 _249_ (.A1(net25),
    .A2(net24),
    .A3(_042_),
    .B1(net26),
    .X(_110_));
 sky130_fd_sc_hd__a32o_1 _250_ (.A1(_046_),
    .A2(net39),
    .A3(_110_),
    .B1(_109_),
    .B2(_141_),
    .X(_111_));
 sky130_fd_sc_hd__o221a_1 _251_ (.A1(net26),
    .A2(_090_),
    .B1(_091_),
    .B2(_111_),
    .C1(net43),
    .X(_024_));
 sky130_fd_sc_hd__and2_1 _252_ (.A(net27),
    .B(_061_),
    .X(_112_));
 sky130_fd_sc_hd__o21ai_1 _253_ (.A1(_062_),
    .A2(_112_),
    .B1(_141_),
    .Y(_113_));
 sky130_fd_sc_hd__o21ai_1 _254_ (.A1(net27),
    .A2(_045_),
    .B1(_051_),
    .Y(_114_));
 sky130_fd_sc_hd__a21o_1 _255_ (.A1(_138_),
    .A2(_047_),
    .B1(_114_),
    .X(_115_));
 sky130_fd_sc_hd__nor2_1 _256_ (.A(net27),
    .B(_090_),
    .Y(_116_));
 sky130_fd_sc_hd__a311oi_1 _257_ (.A1(_090_),
    .A2(_113_),
    .A3(_115_),
    .B1(_116_),
    .C1(net46),
    .Y(_025_));
 sky130_fd_sc_hd__o221a_1 _258_ (.A1(\phase[2] ),
    .A2(_050_),
    .B1(net39),
    .B2(_052_),
    .C1(_049_),
    .X(_117_));
 sky130_fd_sc_hd__nand2_1 _259_ (.A(_142_),
    .B(_117_),
    .Y(_118_));
 sky130_fd_sc_hd__o211a_1 _260_ (.A1(net36),
    .A2(_117_),
    .B1(_118_),
    .C1(net42),
    .X(_026_));
 sky130_fd_sc_hd__or3_1 _261_ (.A(\phase[1] ),
    .B(\phase[0] ),
    .C(_050_),
    .X(_119_));
 sky130_fd_sc_hd__and2_1 _262_ (.A(\state[3] ),
    .B(_049_),
    .X(_120_));
 sky130_fd_sc_hd__nand2_1 _263_ (.A(\state[3] ),
    .B(_049_),
    .Y(_121_));
 sky130_fd_sc_hd__o311a_1 _264_ (.A1(\state[3] ),
    .A2(_141_),
    .A3(net39),
    .B1(_119_),
    .C1(_049_),
    .X(_122_));
 sky130_fd_sc_hd__o22a_1 _265_ (.A1(\phase[2] ),
    .A2(_119_),
    .B1(_120_),
    .B2(_053_),
    .X(_123_));
 sky130_fd_sc_hd__nand2_1 _266_ (.A(_048_),
    .B(_122_),
    .Y(_124_));
 sky130_fd_sc_hd__o211a_1 _267_ (.A1(net37),
    .A2(_123_),
    .B1(_124_),
    .C1(net42),
    .X(_027_));
 sky130_fd_sc_hd__o211a_1 _268_ (.A1(net28),
    .A2(_053_),
    .B1(_121_),
    .C1(net43),
    .X(_028_));
 sky130_fd_sc_hd__nor2_1 _269_ (.A(net46),
    .B(\state[0] ),
    .Y(_125_));
 sky130_fd_sc_hd__a22o_1 _270_ (.A1(\state[3] ),
    .A2(net42),
    .B1(_125_),
    .B2(net19),
    .X(_029_));
 sky130_fd_sc_hd__and2b_1 _271_ (.A_N(_066_),
    .B(_089_),
    .X(_126_));
 sky130_fd_sc_hd__a31o_1 _272_ (.A1(_072_),
    .A2(_076_),
    .A3(_126_),
    .B1(net38),
    .X(_127_));
 sky130_fd_sc_hd__a21o_1 _273_ (.A1(_077_),
    .A2(_127_),
    .B1(net45),
    .X(_030_));
 sky130_fd_sc_hd__a31o_1 _274_ (.A1(_072_),
    .A2(_076_),
    .A3(_126_),
    .B1(_137_),
    .X(_128_));
 sky130_fd_sc_hd__a21oi_1 _275_ (.A1(_077_),
    .A2(_128_),
    .B1(net45),
    .Y(_031_));
 sky130_fd_sc_hd__or2_1 _276_ (.A(\read_data[0] ),
    .B(_144_),
    .X(_129_));
 sky130_fd_sc_hd__o211a_1 _277_ (.A1(net1),
    .A2(_145_),
    .B1(_129_),
    .C1(net41),
    .X(_032_));
 sky130_fd_sc_hd__or2_1 _278_ (.A(\read_data[1] ),
    .B(_144_),
    .X(_130_));
 sky130_fd_sc_hd__o211a_1 _279_ (.A1(net2),
    .A2(_145_),
    .B1(_130_),
    .C1(net41),
    .X(_033_));
 sky130_fd_sc_hd__or2_1 _280_ (.A(\read_data[2] ),
    .B(_144_),
    .X(_131_));
 sky130_fd_sc_hd__o211a_1 _281_ (.A1(net3),
    .A2(_145_),
    .B1(_131_),
    .C1(net41),
    .X(_034_));
 sky130_fd_sc_hd__or2_1 _282_ (.A(\read_data[3] ),
    .B(_144_),
    .X(_132_));
 sky130_fd_sc_hd__o211a_1 _283_ (.A1(net4),
    .A2(_145_),
    .B1(_132_),
    .C1(net41),
    .X(_035_));
 sky130_fd_sc_hd__or2_1 _284_ (.A(\read_data[4] ),
    .B(_144_),
    .X(_133_));
 sky130_fd_sc_hd__o211a_1 _285_ (.A1(net5),
    .A2(_145_),
    .B1(_133_),
    .C1(net41),
    .X(_036_));
 sky130_fd_sc_hd__or2_1 _286_ (.A(\read_data[5] ),
    .B(_144_),
    .X(_134_));
 sky130_fd_sc_hd__o211a_1 _287_ (.A1(net6),
    .A2(_145_),
    .B1(_134_),
    .C1(net41),
    .X(_037_));
 sky130_fd_sc_hd__or2_1 _288_ (.A(\read_data[6] ),
    .B(_144_),
    .X(_135_));
 sky130_fd_sc_hd__o211a_1 _289_ (.A1(net7),
    .A2(_145_),
    .B1(_135_),
    .C1(net41),
    .X(_038_));
 sky130_fd_sc_hd__or2_1 _290_ (.A(\read_data[7] ),
    .B(_144_),
    .X(_136_));
 sky130_fd_sc_hd__o211a_1 _291_ (.A1(net8),
    .A2(_145_),
    .B1(_136_),
    .C1(net41),
    .X(_039_));
 sky130_fd_sc_hd__dfxtp_1 _292_ (.CLK(clknet_2_3__leaf_clk),
    .D(_000_),
    .Q(\phase[0] ));
 sky130_fd_sc_hd__dfxtp_1 _293_ (.CLK(clknet_2_2__leaf_clk),
    .D(_001_),
    .Q(\phase[1] ));
 sky130_fd_sc_hd__dfxtp_1 _294_ (.CLK(clknet_2_2__leaf_clk),
    .D(_002_),
    .Q(\phase[2] ));
 sky130_fd_sc_hd__dfxtp_1 _295_ (.CLK(clknet_2_1__leaf_clk),
    .D(_010_),
    .Q(net11));
 sky130_fd_sc_hd__dfxtp_1 _296_ (.CLK(clknet_2_1__leaf_clk),
    .D(_011_),
    .Q(net12));
 sky130_fd_sc_hd__dfxtp_1 _297_ (.CLK(clknet_2_1__leaf_clk),
    .D(_012_),
    .Q(net13));
 sky130_fd_sc_hd__dfxtp_1 _298_ (.CLK(clknet_2_1__leaf_clk),
    .D(_013_),
    .Q(net14));
 sky130_fd_sc_hd__dfxtp_1 _299_ (.CLK(clknet_2_1__leaf_clk),
    .D(_014_),
    .Q(net15));
 sky130_fd_sc_hd__dfxtp_1 _300_ (.CLK(clknet_2_1__leaf_clk),
    .D(_015_),
    .Q(net16));
 sky130_fd_sc_hd__dfxtp_1 _301_ (.CLK(clknet_2_1__leaf_clk),
    .D(_016_),
    .Q(net17));
 sky130_fd_sc_hd__dfxtp_1 _302_ (.CLK(clknet_2_0__leaf_clk),
    .D(_017_),
    .Q(net18));
 sky130_fd_sc_hd__dfxtp_1 _303_ (.CLK(clknet_2_2__leaf_clk),
    .D(_003_),
    .Q(\state[0] ));
 sky130_fd_sc_hd__dfxtp_1 _304_ (.CLK(clknet_2_2__leaf_clk),
    .D(_004_),
    .Q(\state[1] ));
 sky130_fd_sc_hd__dfxtp_1 _305_ (.CLK(clknet_2_2__leaf_clk),
    .D(_005_),
    .Q(\state[2] ));
 sky130_fd_sc_hd__dfxtp_1 _306_ (.CLK(clknet_2_2__leaf_clk),
    .D(_006_),
    .Q(\state[3] ));
 sky130_fd_sc_hd__dfxtp_1 _307_ (.CLK(clknet_2_3__leaf_clk),
    .D(_007_),
    .Q(\state[4] ));
 sky130_fd_sc_hd__dfxtp_1 _308_ (.CLK(clknet_2_2__leaf_clk),
    .D(_008_),
    .Q(\state[5] ));
 sky130_fd_sc_hd__dfxtp_2 _309_ (.CLK(clknet_2_2__leaf_clk),
    .D(_009_),
    .Q(\state[6] ));
 sky130_fd_sc_hd__dfxtp_2 _310_ (.CLK(clknet_2_1__leaf_clk),
    .D(_018_),
    .Q(net20));
 sky130_fd_sc_hd__dfxtp_1 _311_ (.CLK(clknet_2_1__leaf_clk),
    .D(_019_),
    .Q(net21));
 sky130_fd_sc_hd__dfxtp_2 _312_ (.CLK(clknet_2_3__leaf_clk),
    .D(_020_),
    .Q(net22));
 sky130_fd_sc_hd__dfxtp_1 _313_ (.CLK(clknet_2_3__leaf_clk),
    .D(_021_),
    .Q(net23));
 sky130_fd_sc_hd__dfxtp_1 _314_ (.CLK(clknet_2_3__leaf_clk),
    .D(_022_),
    .Q(net24));
 sky130_fd_sc_hd__dfxtp_2 _315_ (.CLK(clknet_2_3__leaf_clk),
    .D(_023_),
    .Q(net25));
 sky130_fd_sc_hd__dfxtp_1 _316_ (.CLK(clknet_2_3__leaf_clk),
    .D(_024_),
    .Q(net26));
 sky130_fd_sc_hd__dfxtp_2 _317_ (.CLK(clknet_2_3__leaf_clk),
    .D(_025_),
    .Q(net27));
 sky130_fd_sc_hd__dfxtp_1 _318_ (.CLK(clknet_2_2__leaf_clk),
    .D(_026_),
    .Q(net36));
 sky130_fd_sc_hd__dfxtp_1 _319_ (.CLK(clknet_2_3__leaf_clk),
    .D(_027_),
    .Q(net37));
 sky130_fd_sc_hd__dfxtp_1 _320_ (.CLK(clknet_2_3__leaf_clk),
    .D(_028_),
    .Q(net28));
 sky130_fd_sc_hd__dfxtp_1 _321_ (.CLK(clknet_2_2__leaf_clk),
    .D(_029_),
    .Q(net19));
 sky130_fd_sc_hd__dfxtp_1 _322_ (.CLK(clknet_2_0__leaf_clk),
    .D(_030_),
    .Q(net38));
 sky130_fd_sc_hd__dfxtp_1 _323_ (.CLK(clknet_2_1__leaf_clk),
    .D(_031_),
    .Q(diag_captured));
 sky130_fd_sc_hd__dfxtp_1 _324_ (.CLK(clknet_2_2__leaf_clk),
    .D(_032_),
    .Q(\read_data[0] ));
 sky130_fd_sc_hd__dfxtp_1 _325_ (.CLK(clknet_2_0__leaf_clk),
    .D(_033_),
    .Q(\read_data[1] ));
 sky130_fd_sc_hd__dfxtp_1 _326_ (.CLK(clknet_2_0__leaf_clk),
    .D(_034_),
    .Q(\read_data[2] ));
 sky130_fd_sc_hd__dfxtp_1 _327_ (.CLK(clknet_2_0__leaf_clk),
    .D(_035_),
    .Q(\read_data[3] ));
 sky130_fd_sc_hd__dfxtp_1 _328_ (.CLK(clknet_2_0__leaf_clk),
    .D(_036_),
    .Q(\read_data[4] ));
 sky130_fd_sc_hd__dfxtp_1 _329_ (.CLK(clknet_2_0__leaf_clk),
    .D(_037_),
    .Q(\read_data[5] ));
 sky130_fd_sc_hd__dfxtp_1 _330_ (.CLK(clknet_2_0__leaf_clk),
    .D(_038_),
    .Q(\read_data[6] ));
 sky130_fd_sc_hd__dfxtp_1 _331_ (.CLK(clknet_2_0__leaf_clk),
    .D(_039_),
    .Q(\read_data[7] ));
 sky130_fd_sc_hd__clkbuf_1 _332_ (.A(net36),
    .X(net29));
 sky130_fd_sc_hd__clkbuf_1 _333_ (.A(net36),
    .X(net30));
 sky130_fd_sc_hd__clkbuf_1 _334_ (.A(net36),
    .X(net31));
 sky130_fd_sc_hd__clkbuf_1 _335_ (.A(net36),
    .X(net32));
 sky130_fd_sc_hd__clkbuf_1 _336_ (.A(net36),
    .X(net33));
 sky130_fd_sc_hd__clkbuf_1 _337_ (.A(net36),
    .X(net34));
 sky130_fd_sc_hd__clkbuf_1 _338_ (.A(net36),
    .X(net35));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Right_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Right_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Right_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Right_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Right_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Right_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_43 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_44 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Left_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_95 ();
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(mem_dout[0]),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(mem_dout[1]),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(mem_dout[2]),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(mem_dout[3]),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(mem_dout[4]),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_1 input6 (.A(mem_dout[5]),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_1 input7 (.A(mem_dout[6]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(mem_dout[7]),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(rst),
    .X(net9));
 sky130_fd_sc_hd__buf_1 input10 (.A(start),
    .X(net10));
 sky130_fd_sc_hd__buf_2 output11 (.A(net11),
    .X(diag_addr[0]));
 sky130_fd_sc_hd__buf_2 output12 (.A(net12),
    .X(diag_addr[1]));
 sky130_fd_sc_hd__buf_2 output13 (.A(net13),
    .X(diag_addr[2]));
 sky130_fd_sc_hd__buf_2 output14 (.A(net14),
    .X(diag_addr[3]));
 sky130_fd_sc_hd__buf_2 output15 (.A(net15),
    .X(diag_addr[4]));
 sky130_fd_sc_hd__buf_2 output16 (.A(net16),
    .X(diag_addr[5]));
 sky130_fd_sc_hd__buf_2 output17 (.A(net17),
    .X(diag_addr[6]));
 sky130_fd_sc_hd__buf_2 output18 (.A(net18),
    .X(diag_addr[7]));
 sky130_fd_sc_hd__buf_2 output19 (.A(net19),
    .X(done));
 sky130_fd_sc_hd__buf_2 output20 (.A(net20),
    .X(mem_addr[0]));
 sky130_fd_sc_hd__buf_2 output21 (.A(net21),
    .X(mem_addr[1]));
 sky130_fd_sc_hd__buf_2 output22 (.A(net22),
    .X(mem_addr[2]));
 sky130_fd_sc_hd__buf_2 output23 (.A(net23),
    .X(mem_addr[3]));
 sky130_fd_sc_hd__buf_2 output24 (.A(net24),
    .X(mem_addr[4]));
 sky130_fd_sc_hd__buf_2 output25 (.A(net25),
    .X(mem_addr[5]));
 sky130_fd_sc_hd__buf_2 output26 (.A(net26),
    .X(mem_addr[6]));
 sky130_fd_sc_hd__buf_2 output27 (.A(net27),
    .X(mem_addr[7]));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .X(mem_ce));
 sky130_fd_sc_hd__buf_2 output29 (.A(net29),
    .X(mem_din[0]));
 sky130_fd_sc_hd__buf_2 output30 (.A(net30),
    .X(mem_din[1]));
 sky130_fd_sc_hd__buf_2 output31 (.A(net31),
    .X(mem_din[2]));
 sky130_fd_sc_hd__buf_2 output32 (.A(net32),
    .X(mem_din[3]));
 sky130_fd_sc_hd__buf_2 output33 (.A(net33),
    .X(mem_din[4]));
 sky130_fd_sc_hd__buf_2 output34 (.A(net34),
    .X(mem_din[5]));
 sky130_fd_sc_hd__buf_2 output35 (.A(net35),
    .X(mem_din[6]));
 sky130_fd_sc_hd__buf_2 output36 (.A(net36),
    .X(mem_din[7]));
 sky130_fd_sc_hd__buf_2 output37 (.A(net37),
    .X(mem_we));
 sky130_fd_sc_hd__buf_2 output38 (.A(net38),
    .X(pass_fail));
 sky130_fd_sc_hd__buf_2 fanout39 (.A(_051_),
    .X(net39));
 sky130_fd_sc_hd__clkbuf_2 fanout40 (.A(net24),
    .X(net40));
 sky130_fd_sc_hd__buf_2 fanout41 (.A(net44),
    .X(net41));
 sky130_fd_sc_hd__buf_2 fanout42 (.A(net44),
    .X(net42));
 sky130_fd_sc_hd__buf_1 fanout43 (.A(net44),
    .X(net43));
 sky130_fd_sc_hd__buf_1 fanout44 (.A(_140_),
    .X(net44));
 sky130_fd_sc_hd__buf_2 fanout45 (.A(net46),
    .X(net45));
 sky130_fd_sc_hd__clkbuf_2 fanout46 (.A(net9),
    .X(net46));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_0__f_clk (.A(clknet_0_clk),
    .X(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_1__f_clk (.A(clknet_0_clk),
    .X(clknet_2_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_2__f_clk (.A(clknet_0_clk),
    .X(clknet_2_2__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_3__f_clk (.A(clknet_0_clk),
    .X(clknet_2_3__leaf_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload0 (.A(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkload1 (.A(clknet_2_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkload2 (.A(clknet_2_3__leaf_clk));
endmodule
