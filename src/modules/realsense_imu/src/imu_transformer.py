#!/usr/bin/env python3

import rospy
from nav_msgs.msg import Odometry
from geometry_msgs.msg import *
from sensor_msgs.msg import *
import sys
import math
import numpy as np

class ImuTransformer:
    def __init__(self):
        self.m = Imu()
        self.odom = False
        self.gyro = False
        self.accel = False
        self.msg_ = False

        rospy.Subscriber("/camera/odom/sample", Odometry, self.callback_odom)
        rospy.Subscriber('/camera/gyro/sample', Imu, self.callback_gyro)
        rospy.Subscriber("/camera/accel/sample", Imu, self.callback_accel)
        pub = rospy.Publisher('/camera/imu', Imu, queue_size=10)

        while not rospy.is_shutdown():
            if self.odom and self.gyro and self.accel:
                pub.publish(self.m)
                print ("got pose, publish fake imu")
                self.odom = self.gyro = self.accel = False
        

    def callback_odom(self, msg):
        self.m.header = msg.header
        self.m.orientation = msg.pose.pose.orientation
        self.odom = True

    def callback_gyro(self, msg):
        self.m.angular_velocity = msg.angular_velocity
        self.m.angular_velocity_covariance = msg.angular_velocity_covariance
        self.gyro = True

    def callback_accel(self, msg):
        self.m.linear_acceleration = msg.linear_acceleration
        self.m.linear_acceleration_covariance = msg.linear_acceleration_covariance
        self.accel = True

if __name__ == '__main__':
    rospy.init_node('fake_imu', anonymous=True)
    try:
        transformer = ImuTransformer()
    except rospy.ROSInterruptException:  pass