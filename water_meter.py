#!/usr/bin/env python3
"""
Water Meter Simulator
Simulates water usage monitoring generating log data
"""

import time
import random
import sys
import os
from datetime import datetime

LOG_FILE = "hospital_data/active_logs/water_usage.log"

def ensure_directory():
    """Create log directory if it doesn't exist"""
    os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)

def generate_water_usage():
    """Generate realistic water usage values in liters"""
    return round(random.uniform(0.5, 15.0), 2)

def log_entry(meter_id, usage):
    """Write log entry to file"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_line = f"{timestamp} | Device: Water_Meter_{meter_id} | Usage: {usage}L\n"
    
    with open(LOG_FILE, "a") as f:
        f.write(log_line)
    
    print(f"[{timestamp}] Water_Meter_{meter_id}: {usage}L")

def start_monitoring():
    """Start continuous monitoring"""
    ensure_directory()
    print(f"Starting water usage monitoring...")
    print(f"Logging to: {LOG_FILE}")
    print("Press Ctrl+C to stop\n")
    
    try:
        meter_id = 1
        while True:
            usage = generate_water_usage()
            log_entry(meter_id, usage)
            time.sleep(5)  # 5 seconds between readings
            
    except KeyboardInterrupt:
        print("\n\nMonitoring stopped.")
        sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "start":
        start_monitoring()
    else:
        print("Usage: python3 water_meter.py start")
        sys.exit(1)