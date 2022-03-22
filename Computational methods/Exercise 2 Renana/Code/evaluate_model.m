function [precision,error] = evaluate_model(predict_Y, real_Y)

Hit = 0;

for i = 1:length(real_Y)
    if predict_Y(i) == real_Y(i)
        Hit = Hit + 1;
    end
end

precision = (Hit/length(real_Y))*100;
end