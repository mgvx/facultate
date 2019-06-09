load input.mat
data = load("input.mat")

brake = zeros(5);

for i = 1:(length(trackList)-1)
    t = trackList(i);
    for j = 1:(length(t.cycles)-1)

        wPed        = t.objType.obstacle_Mobile_prob1Pedestrian(j);
        wObst       = t.objType.obstacle_prob1Mobile(j);
        vEgo        = t.vehAttributes.vEgo(j);
        wExist      = t.objAttributes.wExistVec(j);
        vxVec       = t.objAttributes.vxVec(j);
        vyVec       = t.objAttributes.vyVec(j);
        dx          = t.objAttributes.dxVec(j);
        abs_vxVec   = vEgo + vxVec;

        if wExist > 0.95 && wPed > 0.8 && wObst > 0.8
            if vEgo > 50
                if dx < 15
                    if brake(i) == 0
                        brake(i) = j;
                    end
                end
            end
            if vEgo <= 50 && vEgo > 35
                if dx < 9
                    if brake(i) == 0
                        brake(i) = j;
                    end
                end
            end
            if vEgo <= 35
                if dx < 6
                    if brake(i) == 0
                        brake(i) = j;
                    end
                end
            end
        end
    end
end

for i = 1:5
    brake(i)
end



