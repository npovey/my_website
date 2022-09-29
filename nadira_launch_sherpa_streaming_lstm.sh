#######!/bin/bash
##screen -dm bash -c '/home/ubuntu/my_website/run_lstm.sh;'
screen -S server bash -c 'bash /home/ubuntu/my_website/run_lstm.sh'
screen -S web bash -c 'bash /home/ubuntu/my_website/run_web.sh'
