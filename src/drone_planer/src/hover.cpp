#include <drone_planer/gnc_functions.hpp>

int main(int argc, char** argv) {
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
	nextWayPoint.z = 0.5;
	nextWayPoint.psi = 0;

    ros::spinOnce();
    sleep(10);
    land();
}