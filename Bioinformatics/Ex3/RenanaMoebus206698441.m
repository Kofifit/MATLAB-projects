%% clean
clear all
close all
clc

%% Load and read files
humanHEXA = genbankread('humanHEXA.gb');
mouseHEXA = genbankread('mouseHEXA.gb');    

%% Retrieve the nucleotides and the coding region sequence
 
humanSeq = humanHEXA.Sequence;
humanCDS = humanHEXA.CDS.indices;

mouseSeq = mouseHEXA.Sequence;
mouseCDS = mouseHEXA.CDS.indices;

%% Create variable for CDS sequence

humanCDSseq = humanSeq(humanCDS(1):humanCDS(2));
mouseCDSseq = mouseSeq(mouseCDS(1):mouseCDS(2));

%% Translate CDS from genetic code to Amino acids

humanCDSAA = nt2aa(humanCDSseq);
mouseCDSAA = nt2aa(mouseCDSseq);

%% Global alignment for CDS sequence and CDS amino acid sequence

[scoreSeq, alignmentSeq] = nwalign(humanCDSseq, mouseCDSseq, 'Showscore', true);
[scoreAA, alignmentAA] = nwalign(humanCDSAA, mouseCDSAA, 'Showscore', true);

%% Find number of matches, mismatches and gaps for each alignment

matchSeq = length(strfind(alignmentSeq(2,:),'|'));
matchAA = length(strfind(alignmentAA(2,:),'|'));
mismatchSeq = length(strfind(alignmentSeq(2,:),':'));
mismatchAA = length(strfind(alignmentAA(2,:),':'));
gapSeq = length(alignmentSeq) - matchSeq - mismatchSeq;
gapAA = length(alignmentAA) - matchAA - mismatchAA;



