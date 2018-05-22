% IFUSION MATLAB IMPLEMENTATION
%    by Juan Diego Gomez PhD. Student
%    and Carlo Gatta PhD
%
% Medical Imaging Group
%
% Computer Vision Center CVC.
% Barcelona, Spain
% 2009


clc
close all
clear all

addpath './CORE-GEO'
addpath './CORE-IMP'
addpath './CORE-MISC'
addpath './HCI'

Ifusion_Global
CF_1=[]; CF_2=[]; CF_3=[]; CF_4=[];CORO=[];
N_ctrl_pts=4;im_size=512;sc_fact=0.34;old_case=0;

Ifusion_interface_1
Ifusion_interface_2
Ifusion_interface_3
