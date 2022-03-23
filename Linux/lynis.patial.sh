#!/bin/bash
sudo lynis audit --tests-from-groups malware, authentication, networking, storage, filesystems >> /tmp/lynis.partial_scan.log

