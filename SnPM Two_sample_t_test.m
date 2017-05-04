%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------
clear all;
close all;

matlabbatch{1}.spm.tools.snpm.des.TwoSampT.DesignName = '2 Groups: Two Sample T test; 1 scan per subject';
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.DesignFile = 'snpm_bch_ui_TwoSampT';

%%%%%%%%%%%% The user has to specify the directory to save results %%%%%%%
f0 = spm_select([1 Inf],'dir','SELECT DIRECTORY TO SAVE THE RESULTS');
f0 = cellstr(f0);
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.dir = f0;
%%
%The user has to choose the con.images of the Group_1
f1 = spm_select([1 Inf],'Image','NOW SELECT THE .CON IMAGES OF THE "FIRST"GROUP');
f1 = cellstr(f1);
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.scans1 = f1;
%%
%The user has to choose the con.images of the Group_2
f2 = spm_select([1 Inf],'Image','NOW SELECT THE .CON IMAGES OF THE "SECOND"GROUP');
f2 = cellstr(f2);
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.scans2 = f2;
%%
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.cov = struct('c', {}, 'cname', {});
%choose number of permutations
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.nPerm = 5000;
%choose the desired FWHM for variance smoothing if degrees of freedom are few
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.vFWHM = [6 6 6];
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.bVolm = 1;
%define the CLUSTER-DEFINING-THRESHOLD giving p-value of T/F statistic
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.ST.ST_U = 0.005;
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.masking.tm.tm_none = 1;
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.masking.im = 1;
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.masking.em = {''};
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.globalc.g_omit = 1;
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.tools.snpm.des.TwoSampT.globalm.glonorm = 1;
matlabbatch{2}.spm.tools.snpm.cp.snpmcfg(1) = cfg_dep;
matlabbatch{2}.spm.tools.snpm.cp.snpmcfg(1).tname = 'SnPMcfg.mat configuration file';
matlabbatch{2}.spm.tools.snpm.cp.snpmcfg(1).tgt_spec = {};
matlabbatch{2}.spm.tools.snpm.cp.snpmcfg(1).sname = '2 Groups: Two Sample T test; 1 scan per subject: SnPMcfg.mat configuration file';
matlabbatch{2}.spm.tools.snpm.cp.snpmcfg(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.tools.snpm.cp.snpmcfg(1).src_output = substruct('.','SnPMcfg');
matlabbatch{3}.spm.tools.snpm.inference.SnPMmat(1) = cfg_dep;
matlabbatch{3}.spm.tools.snpm.inference.SnPMmat(1).tname = 'SnPM.mat results file';
matlabbatch{3}.spm.tools.snpm.inference.SnPMmat(1).tgt_spec = {};
matlabbatch{3}.spm.tools.snpm.inference.SnPMmat(1).sname = 'Compute: SnPM.mat results file';
matlabbatch{3}.spm.tools.snpm.inference.SnPMmat(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.tools.snpm.inference.SnPMmat(1).src_output = substruct('.','SnPM');
matlabbatch{3}.spm.tools.snpm.inference.Thr.Clus.ClusSize.CFth = NaN;
% Define the FWE p value for correction
matlabbatch{3}.spm.tools.snpm.inference.Thr.Clus.ClusSize.ClusSig.FWEthC = 0.05;
matlabbatch{3}.spm.tools.snpm.inference.Tsign = 1;
% Save the statistical maps as SnPM_filtered.nii
matlabbatch{3}.spm.tools.snpm.inference.WriteFiltImg.name = 'SnPM_filtered';
matlabbatch{3}.spm.tools.snpm.inference.Report = 'MIPtable';
%Run the job
save('SPM_analysis.mat','matlabbatch');
spm_jobman('initcfg'); 
spm_jobman('run','SPM_analysis.mat');
