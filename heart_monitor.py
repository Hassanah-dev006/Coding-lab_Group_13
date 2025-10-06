#!/usr/bin/env python3
"""
Heart Rate Monitor Simulator
Simulates 2 heart rate monitoring devices generating log data
"""

import time
import random
import sys
import os
from datetime import datetime

LOG_FILE = "hospital_data/active_logs/heart_rate.log"

def ensure_directory():
    """Create log directory if it doesn't exist"""
    os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)

def generate_heart_rate():
    """Generate realistic heart rate values (60-100 bpm normal range)"""
    return random.randint(55, 105)

def log_entry(device_id, heart_rate):
    """Write log entry to file"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_line = f"{timestamp} | Device: HR_Monitor_{device_id} | Heart Rate: {heart_rate} bpm\n"
    
    with open(LOG_FILE, "a") as f:
        f.write(log_line)
    
    print(f"[{timestamp}] HR_Monitor_{device_id}: {heart_rate} bpm")

def start_monitoring():
    """Start continuous monitoring from 2 devices"""
    ensure_directory()
    print(f"Starting heart rate monitoring...")
    print(f"Logging to: {LOG_FILE}")
    print("Press Ctrl+C to stop\n")
    
    try:
        while True:
            # Simulate readings from 2 devices
            for device_id in [1, 2]:
                heart_rate = generate_heart_rate()
                log_entry(device_id, heart_rate)
                time.sleep(2)  # 2 seconds between readings
            
    except KeyboardInterrupt:
        print("\n\nMonitoring stopped.")
        sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "start":
        start_monitoring()
    else:
        print("Usage: python3 heart_monitor.py start")
        sys.exit(1)