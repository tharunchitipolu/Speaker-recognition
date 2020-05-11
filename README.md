# Speaker-recognition
An automatic speaker recognition system built from digital signal processing tools and LBG algorithm.
In this project we will experiment with the building and testing of an automatic speaker recognition system.
In order to build such a system, one have to go through the steps that were described in previous sections. 
We create two utility functions euc_dist and codebooks and two main functions: training and testing.
# Implementation
Our goal is to train a voice model (or more specific, a VQ codebook in the MFCC
vector space) for each speaker S1 – S3 using the corresponding sound file in the train
folder. After this training step, the system would have knowledge of the voice
characteristic of each (known) speaker. Next, in the testing phase, the system will be
able to identify the (assumed unknown) speaker of each sound file in the test folder
First we create a mfcc function. We take the input and do pre emphasis to it. Now cut
the speech signal (a vector) into frames with overlap (refer to the frame section in the
theory part). The result is a matrix where each column is a frame of N samples from
original speech signal. Applying the steps “Windowing” and “FFT” to transform the
signal into the frequency domain. This process is used in many different applications
and is referred in literature as Windowed Fourier Transform (WFT) or Short-Time
Fourier Transform (STFT).
The result of the last section is that we transform speech signals into vectors in an
acoustic space. In this section, we will apply the VQ-based pattern recognition
technique to build speaker reference models from those vectors in the training phase
and then can identify any sequences of acoustic vectors uttered by unknown speakers.
the utility function euc_distis used to compute the pairwise Euclidean distances
between the codewords and training vectors in the iterative process.
Now is the final part! Using the training and testing functions we perform our
Speaker Recognition.
