#!/bin/bash
sudo mkdir -p /var/backup
sudo tar czf /var/backup/home.tar /home
sudo mv /var/backup/home.tar /var/backup/home.01152022.tar
sudo tar cvf /var/backup/system.tar /home 
sudo ls -lh /var/backup > /var/backup/file_report.txt
sudo free -h > /var/backup/disk_report.txt
