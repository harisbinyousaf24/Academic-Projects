%-----------------ROBOTICS PROJECT-------------%
%Desigining and simulating two robotic arms for fetch and 
%tracing the path of picked object

%Steps of implementing this project:
% 1- First write the available parameters for the arms (link lengths)
% 2- Create the DH Tables
% 3- Design the arms using Peter Corkes robotic tool box
% 4- Determine the workspace of arm
% 5- For the workspace develop a user compatible interface 
%    to enter the coordiantes of object
% 6- Apply forward kinematics to determine the end effector coordinate
% 7- Apply inverse kinematics to determine joint angles for user given
%    coordinates
% 8- Develop a trajectory for the path followed
% 9- Now determine the coordinates of end effector of second arm
%    using forward kinematics
% 10- For that determined coordinates, use it for next goal
% 11- Now apply jaccobian matrix and inverse dynamics to draw 
%     the trajectory and reach the new goal
% 12- After giving the object to other arm, bring the arms to their
%     initial state
% 13- Perform simulation

%--------------------------------------------------%
clc
clear all
% Parameters defined
Length = [80 75 90 60]; %Link Lengths
Offset = [0 10 20 30]; %offset
Theeta = [45 90 60 45]; %Rotation
Alpha = [-pi/2 0 0 0]; %Rotation wrt to LFR
%DH Table
% L = Link([Theeta Offset Length Alpha])
L1(1) = Link([Theeta(1) Offset(1) Length(1) Alpha(1) ], 'standard');
L1(2) = Link([Theeta(2) Offset(2) Length(2) Alpha(2) ], 'standard');
L1(3) = Link([Theeta(3) Offset(3) Length(3) Alpha(3) ], 'standard');
L1(4) = Link([Theeta(4) Offset(4) Length(4) Alpha(4) ], 'standard');

L2(1) = Link([Theeta(1) Offset(1) Length(1) Alpha(1) ], 'standard');
L2(2) = Link([Theeta(2) Offset(2) Length(2) Alpha(2) ], 'standard');
L2(3) = Link([Theeta(3) Offset(3) Length(3) Alpha(3) ], 'standard');
L2(4) = Link([Theeta(4) Offset(4) Length(4) Alpha(4) ], 'standard');
%Designing Arms
Arm1 = SerialLink(L1)
Arm2 = SerialLink(L2)
%Assigning names
Arm1.name = 'Fetcher Arm';
Arm2.name = 'Taker Arm';
%Object Coordinates
xO = input('Enter x-coordinate of object to be picked x = ');
yO = input('Enter y-coordinate of object to be picked y = ');
zO = input('Enter z-coordinate of object to be picked z = ');
P = [xO yO zO];
%Transforming Coordinates to transformation matrix
trvec = [xO yO zO]; 
tform = trvec2tform(trvec)
inv = Arm2.ikunc(tform)
Arm2.fkine([inv(1),inv(2),inv(3),inv(4)])
%Joints Workspace
theeta1 = linspace(-pi,pi,4);
theeta2 = linspace(-pi,pi,4);
theeta3 = linspace(-pi,pi,4);	
theeta4 = linspace(-pi,pi,4);
%Plotting
Arm1.fkine([theeta1(1),theeta2(4),theeta3(3),theeta4(4)])
Arm1.plot([theeta1(1),theeta2(4),theeta3(3),theeta4(4)])
Arm2.plot([inv(1),inv(2),inv(3),inv(4)])
%Arm2 End Effector coordinates
x1 = input('Enter x-coordinate of Arm2 End-effector x = ');
y1 = input('Enter y-coordinate of Arm2 End-effector y = ');
z1 = input('Enter z-coordinate of Arm3 End-effector z = ');
Q = [x1 y1 z1];
%Transforming Coordinates to transformation matrix
trvec = Q; 
tform = trvec2tform(trvec);
Trans = Arm1.ikunc(tform);
%creating trajectories
q1 = [theeta1(1) theeta2(4) theeta3(3) theeta4(4)];
q3 = [inv(1) inv(2) inv(3) inv(4)];
q2 = [Trans(1) Trans(2) Trans(3) Trans(4)];
%Updated Positions
P1 = P;
Q1 = Q;
%First Trajectory
traj1 = jtraj(q1,q2,100); 
qf = Arm1.fkine(traj1);
x_trajectory = zeros(1,100);
y_trajectory = zeros(1,100); 
z_trajectory = zeros(1,100);
for i=1:100
x_trajectory(1,i) = qf(1,i).t(1);
y_trajectory(1,i) = qf(1,i).t(2);
z_trajectory(1,i) = qf(1,i).t(3); 
end
hold on
scatter3(x_trajectory,y_trajectory,z_trajectory,'.');
%Second Trajectory
traj2 = jtraj(q2,q3,100); 
qf1 = Arm1.fkine(traj2);
x_trajectory = zeros(1,100);
y_trajectory = zeros(1,100);
z_trajectory = zeros(1,100);
for i=1:100
x_trajectory(1,i) = qf1(1,i).t(1);
y_trajectory(1,i) = qf1(1,i).t(2);
z_trajectory(1,i) = qf1(1,i).t(3); 
end
hold on 
scatter3(x_trajectory,y_trajectory,z_trajectory,'.');
%Third Trajectory
traj3 = jtraj(q3,q1,50); 
qf1 = Arm1.fkine(traj3);
x_trajectory = zeros(1,50);
y_trajectory = zeros(1,50);
z_trajectory = zeros(1,50);
for i=1:50
x_trajectory(1,i) = qf1(1,i).t(1);
y_trajectory(1,i) = qf1(1,i).t(2);
z_trajectory(1,i) = qf1(1,i).t(3); 
end
hold on 
scatter3(x_trajectory,y_trajectory,z_trajectory,'.');
%Animation
vstup = 0;
while (vstup ~=1) 
    Arm1.plot(traj1)
    Arm1.plot(traj2)
    Arm1.plot(traj3)
    vstup=vstup+1;
end