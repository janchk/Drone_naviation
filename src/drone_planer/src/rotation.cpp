#include <drone_planer/gnc_functions.hpp>

int main(int argc, char **argv)
{

    ros::init(argc, argv, "gnc_mode");
    ros::NodeHandle gnc_node("~");

    init_publisher_subscriber(gnc_node);
    wait4connect();
    wait4start();

    initialize_local_frame();

    takeoff(1); // todo as argument

    std::vector<gnc_api_waypoint> waypointList;
    gnc_api_waypoint nextWayPoint;
    nextWayPoint.x = 0;
    nextWayPoint.y = 0;
    nextWayPoint.z = 1.0;
    nextWayPoint.psi = 90;
    waypointList.push_back(nextWayPoint);
    nextWayPoint.x = 0;
    nextWayPoint.y = 0;
    nextWayPoint.z = 1.0;
    nextWayPoint.psi = 180;
    waypointList.push_back(nextWayPoint);
    nextWayPoint.x = 0;
    nextWayPoint.y = 0;
    nextWayPoint.z = 1.0;
    nextWayPoint.psi = 270;
    waypointList.push_back(nextWayPoint);
    nextWayPoint.x = 0;
    nextWayPoint.y = 0;
    nextWayPoint.z = 1.0;
    nextWayPoint.psi = 360;
    waypointList.push_back(nextWayPoint);

    ros::Rate rate(2.0);
    int counter = 0;

    while (ros::ok())
    {
        ros::spinOnce();
        rate.sleep();
        if (check_waypoint_reached(.3) == 1)
        {
            if (counter < waypointList.size())
            {
                set_destination(waypointList[counter].x, waypointList[counter].y, waypointList[counter].z, waypointList[counter].psi);
                counter++;
            }
            else
            {
                // land after all waypoints are reached
                land();
                return 0;
            }
        }
    }

    // land();
    return 0;
}