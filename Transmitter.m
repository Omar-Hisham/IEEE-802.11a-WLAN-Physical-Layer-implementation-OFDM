function all_frames = Transmitter(x, L, R, codeRate, mod_type, rep_type,  SCRAMBLER_INIT_STATE)

if (nargin < 7)
    NO_SCRAMBLE_FLAG = 1;
else
    NO_SCRAMBLE_FLAG = 0;
    state = SCRAMBLER_INIT_STATE;
end

% create preamble
preamble =create_preamble();
preamble =reshape(preamble, 1, length(preamble));

all_frames = [];

for i=0:8*L:length(x)
    
    if i+8000 >length(x)
        data = x(i+1:end);
        if ~NO_SCRAMBLE_FLAG
        [data, state] = scramble(data', state);
        data = data';
        end
        data = reshape(data, 1, length(data));
        
        if isempty(data)
            break
        end
        signal = create_sig(R,(length(x)-i)/8);
    else
        
        data = x(i+1:i+8000);
        % -------- Scrambling --------- %
        if ~NO_SCRAMBLE_FLAG
            [data, state] = scramble(data', state);
            data = data';
        end
        data = reshape(data, 1, length(data));
        signal = create_sig(R,L); 
    end
    
    out_signal = convEncoder(signal, 1/2);
    compledatasignal = mapping(out_signal ,'BPSK');
    signal_ifft_without_cp= ifft(compledatasignal);
    signal_ifft=[signal_ifft_without_cp(end-15:end) signal_ifft_without_cp];
    
    % data creation:
    out_data = convEncoder(data,codeRate);
    
    % -------- Interleaving --------- %
    if ~NO_SCRAMBLE_FLAG
      out_data = interleaving(out_data, R);
    end
    output_data = padding(out_data,mod_type);
    compledatadata = mapping(output_data ,mod_type);
    All_OFDM_data = convert_OFDM_symbol(compledatadata);
    frame = create_frame(preamble,signal_ifft,All_OFDM_data);
    all_frames = [all_frames frame];
    
end
%Fixed Point
if strcmpi(rep_type,'Fixed')
    all_frames = fi(all_frames,1,8,8);
    all_frames = all_frames;
end
end