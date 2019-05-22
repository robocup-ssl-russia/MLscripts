function [path] = buildPath(obstacles, pos, aim, left, right, down, up, verStep, horStep)
    import java.util.LinkedList;
    if (~(left <= pos(1) && pos(1) <= right && down <= pos(2) && pos(2) <= up))
        path = [pos(1), pos(2); pos(1), pos(2)];
    else
        l = floor((pos(1) - left) / verStep);
        r = floor((right - pos(1)) / verStep);
        d = floor((pos(2) - down) / horStep);
        u = floor((up - pos(2)) / horStep);
        field = buildField(obstacles, verStep, horStep, pos, l, r, d, u);
        %disp(field);

        q = LinkedList();
        q.add([l+1, d+1]);
        field(l+1, d+1) = 1;
        mv = [-1, 0; 0, -1; 1, 0; 0, 1; 1, 1; -1, -1; -1, 1; 1, -1];
        while ~q.isEmpty()
            tmp = q.pop();
            cur = [tmp(1), tmp(2)];
            for k = 1: 8
                t = cur + [mv(k, 1), mv(k, 2)];
                if t(1) >= 1 && t(2) >= 1 && t(1) <= l + r + 1 && t(2) <= u + d + 1 && field(t(1), t(2)) == 0
                    field(t(1), t(2)) = field(cur(1), cur(2)) + 1;
                    q.add(t);
                end
            end
        end
        %disp(field);

        nearPnt = pos;
        finish = [l + 1, d + 1];
        for x = -l: r
            for y = -d: u
                cur = pos + [x * verStep, y * horStep];
                if len(cur, aim) < len(nearPnt, aim) && field(x + l + 1, y + d + 1) ~= -1
                    nearPnt = cur;
                    finish = [x + l + 1, y + d + 1];
                end
            end
        end
        %disp(field);
        %disp(nearPnt);
        if (field(finish(1), finish(2)) <= 0)
            path = [pos(1), pos(2); pos(1), pos(2)];
        else
            road = LinkedList();
            road.push(finish);
            %disp([l + 1, d + 1]);
            %disp(field(finish(1), finish(2)));
            while field(finish(1), finish(2)) ~= 1
                for k = 1: 8
                    t = finish + [mv(k, 1), mv(k, 2)];
                    if t(1) >= 1 && t(2) >= 1 && t(1) <= l + r + 1 && t(2) <= u + d + 1 && field(t(1), t(2)) == field(finish(1), finish(2)) - 1
                        finish = t;
                        break;
                    end
                end
                %disp(finish);
                road.push(finish);
            end

            path = [];
            while ~road.isEmpty()
                cur = road.pop();
                path = [path; pos(1)+(cur(1)-l-1)*verStep, pos(2)+(cur(2)-d-1)*horStep];
            end
        end
    end
end

function [res] = len(A, B)
    res = sqrt((A(1) - B(1)) ^ 2 + (A(2) - B(2)) ^ 2);
end

