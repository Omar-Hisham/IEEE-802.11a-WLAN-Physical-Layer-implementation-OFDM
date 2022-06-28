# IEEE-802.11a-WLAN-Physical-Layer-implementation-OFDM
In this project, IEEE 802.11a WLAN Physical Layer (OFDM) is implmented. In OFDM, multiple
closely spaced orthogonal subcarrier signals with overlapping spectra are transmitted to carry
data in parallel. The number of subcarriers is 64, where only 48 subcarriers are used for the sake
of data transmission and the rest of the 64 are zeroed to reduce adjacent channel interference.
Convolutional encoding with rates 1/2, 2/3, and 3/4 are used for forward error correction. On
the other hand, Veterbi decoder is used at the receiver to correct possible errors accumulated
through noise. For channel estimation and equalization, both Zero Forcing (ZF), and Weiner
Filter are used. Additionally, the modulation schemes that our implemented system supports
are “BPSK”, “QPSK”, “16QAM” and “64QAM” with different rates up to 54 Mbps. The following
diagram shows the main stages of our implmentation.
