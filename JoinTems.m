function [Struct] = JoinTems(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O)

[A1,B1] = RevmoveDplicados(A,B);
j1 = join(A1,B1,'Keys','Chave');

[j1a,C1] = RevmoveDplicados(j1,C);
j2 = join(j1a,C1,'Keys','Chave');

[j2a,D1] = RevmoveDplicados(j2,D);
j3 = join(j2a,D1,'Keys','Chave');

[j3a,E1] = RevmoveDplicados(j3,E);
j4 = join(j3a,E1,'Keys','Chave');

[j4a,F1] = RevmoveDplicados(j4,F);
j5 = join(j4a,F1,'Keys','Chave');

[j5a,G1] = RevmoveDplicados(j5,G);
j6 = join(j5a,G1,'Keys','Chave');

[j6a,H1] = RevmoveDplicados(j6,H);
j7 = join(j6a,H1,'Keys','Chave');

[j7a,I1] = RevmoveDplicados(j7,I);
j8 = join(j7a,I1,'Keys','Chave');

[j8a,J1] = RevmoveDplicados(j8,J);
j9 = join(j8a,J1,'Keys','Chave');

[j9a,K1] = RevmoveDplicados(j9,K);
j10 = join(j9a,K1,'Keys','Chave');

[j10a,L1] = RevmoveDplicados(j10,L);
j11 = join(j10a,L1,'Keys','Chave');

[j11a,M1] = RevmoveDplicados(j11,M);
j12 = join(j11a,M1,'Keys','Chave');

[j12a,N1] = RevmoveDplicados(j12,N);
j13 = join(j12a,N1,'Keys','Chave');

[j13a,O1] = RevmoveDplicados(j13,O);
j14 = join(j13a,O1,'Keys','Chave');

Struct = j14;

end