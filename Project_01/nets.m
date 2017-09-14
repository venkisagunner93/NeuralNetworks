close all;
clear all;
clc;
rng(10);

[c1train,c2train,c1test,c2test] = GenerateClusters(-4);

% prep training input
y1 = ones(1,1000);
y2 = zeros(1,1000);
train_set = [c1train,c2train];
order = randperm(2000);
train_set = train_set(:,order);
target = [y1,y2];
target = target(order);

% training algorithm
net = feedforwardnet(3,'traingd');
net = configure(net,train_set,target);
net.trainParam.lr = 0.5;
net = train(net,train_set,target);
classifier = GenerateBoundary(net);
train_op = net(train_set);

figure(1)
hold on;
scatter(c1train(1,:),c1train(2,:),5,'r','filled');
scatter(c2train(1,:),c2train(2,:),5,'g','filled');
plot(classifier(1,:),classifier(2,:),'b');

figure(2)
plotconfusion(target,train_op);