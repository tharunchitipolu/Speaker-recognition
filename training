function code = training(trainingdir, n)

k = 16;                         % number of centroids required

for i = 1:n                     % train a VQ codebook for each speaker
    file = sprintf('%ss%d.wav', trainingdir, i);           
    disp(file);
   
    [s, fs] = audioread(file);
    
    v = my_mfcc(s, fs);            % Compute MFCC's
   
    code{i} = codebooks(v, k);      % Train VQ codebook
end
