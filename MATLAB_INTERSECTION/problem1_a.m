originalpoint = [-1,-1,2; -1,-1,3; 0,-1,2;0,-1,3;1,-1,2;1,-1,3];
P = transpose(originalpoint); %to project
newpoint = [project_point(P(:,1)), project_point(P(:,2)), project_point(P(:,3)), project_point(P(:,4)), project_point(P(:,5)), project_point(P(:,6))];
newpoint1=transpose(newpoint)
originalpoint