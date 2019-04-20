% (x,y) - robot's coordinates, (ox,oy) - obstacle's center, ro - radius of the obstacle,
%m - radius of the robot, theta_d - robot's direction
function rul = ObstacleAvoidace( x, y, ox, oy, ro, m, theta_d )
coef1 = 15;
% distance between robot and obstacle
dist = sqrt((ox-x)*(ox-x) + (y-oy)*(y-oy));
length = fabs( (ox-x)*sin(theta_d) + (y-oy)*cos(theta_d) );
angle = atan2( oy-y, ox-x );
diff_angle = theta_d - angle;

%while (diff_angle > PI)  
%    diff_angle = diff_angle - 2.*PI;
%end
%while( diff_angle < -PI ) 
%    diff_angle = diff_angle + 2.*PI;
%end 

if (length < ro+m) && (fabs(diff_angle )< PI/2)

	if dist <= ro 
        theta_d_new = angle - PI;
    else
        
    if dist <= ro+m 
		% modify theta_d to avoid it with CW direction
		if diff_angle > 0. 
		
			%make smooth transition near the obstacle
			%boundary
			tmp_x = ( (dist-ro)*cos(angle-1.5*PI) + (ro+m-dist)*cos(angle-PI)) / m;
			tmp_y = ( (dist-ro)*sin(angle-1.5*PI) + (ro+m-dist)*sin(angle-PI)) / m;
			theta_d_new = atan2( tmp_y, tmp_x );
        
		% modify theta_d to avoid it with CCW direction
		else
		
			% make smooth transition near the obstacle
			% boundary
			tmp_x = ( (dist-ro)*cos(angle-0.5*PI) + (ro+m-dist)*cos(angle-PI) ) / m;
			tmp_y = ( (dist-ro)*sin(angle-0.5*PI) + (ro+m-dist)*sin(angle-PI) ) / m;
			theta_d_new = atan2( tmp_y, tmp_x );
        end
   
	else
	
		% modify theta_d to avoid it with CW direction
		if diff_angle > 0. 
		
			theta_d_new = fabs( atan( (ro+m) / sqrt(dist*dist - (ro+m)*(ro+m) ))) + angle;
 
		% modify theta_d to avoid it with CCW direction
		else
		
			theta_d_new = -fabs( atan( (ro+m) / sqrt(dist*dist - (ro+m)*(ro+m) ))) + angle;
        end
    end
    end
end
rul = Crul(0, 0, 0, (theta_d_new - theta_d) * coef1, 0);
