%use for the bootstrap
load Data4.mat
bootstat = bootstrp(100,@(bootsample)bootfun(bootsample),Data4);
se=std(bootstat,0,1);
