#!/usr/bin/env python3
"""
Temperature Sensor Simulator
Simulates 2 temperature monitoring devices generating log data
"""

import time
import random
import sys
import os
from datetime import datetime

LOG_FILE = "hospital_data/active_logs/temperature.log"

def ensure_directory():
    """Create log directory if it doesn't exist"""
    os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)

def generate_temperature():
    """Generate realistic body temperature values (36.5-37.5°C normal range)"""
    return round(random.uniform(36.0, 38.5), 1)

def log_entry(device_id, temperature):
    """Write log entry to file"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_line = f"{timestamp} | Device: Temp_Sensor_{device_id} | Temperature: {temperature}°C\n"
    
    with open(LOG_FILE, "a") as f:
        f.write(log_line)
    
    print(f"[{timestamp}] Temp_Sensor_{device_id}: {temperature}°C")

def start_monitoring():
    """Start continuous monitoring from 2 devices"""
    ensure_directory()
    print(f"Starting temperature monitoring...")
    print(f"Logging to: {LOG_FILE}")
    print("Press Ctrl+C to stop\n")
    
    try:
        while True:
            # Simulate readings from 2 devices
            for device_id in [1, 2]:
                temperature = generate_temperature()
                log_entry(device_id, temperature)
                time.sleep(3)  # 3 seconds between readings
            
    except KeyboardInterrupt:
        print("\n\nMonitoring stopped.")
        sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "start":
        start_monitoring()
    else:
        print("Usage: python3 temp_sensor.py start")
        sys.exit(1)