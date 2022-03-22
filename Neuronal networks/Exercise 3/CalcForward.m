function out = CalcForward(w, x)
    out = sigmf(w * x',  [1, 0]);
end

