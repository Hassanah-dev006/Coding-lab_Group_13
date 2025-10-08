# Coding-lab_Group_13
# Hospital Data Monitoring & Archival System

## Project Overview
An automated log management system for hospital data that collects real-time patient health metrics and resource usage data, provides controlled log archiving, and generates analytical reports.

## Features
- Real-time data collection from simulated medical devices.
- Interactive log archival with user-friendly menu.
- Intelligent analysis with device statistics and timestamps.
- Automated directory organization.

## Directory Structure
hospital_data/
├── active_logs/
│   ├── heart_rate.log
│   ├── temperature.log
│   └── water_usage.log
└── archives/
├── heart_data_archive/
├── temp_data_archive/
└── water_data_archive/
reports/
└── analysis_report.txt

## Setup Instructions

### 1. Make Scripts Executable
```bash
chmod +x archive_logs.sh analyze_logs.sh heart_monitor.py temp_sensor.py water_meter.py
2. Start Data Collection
Run each simulator in a separate terminal:
bash# Terminal 1
python3 heart_monitor.py start

# Terminal 2
python3 temp_sensor.py start

# Terminal 3
python3 water_meter.py start
3. Archive Logs
bash./archive_logs.sh
Select option 1, 2, or 3 to archive the corresponding log file.
4. Analyze Logs
bash./analyze_logs.sh
Select option 1, 2, or 3 to analyze the corresponding log file.
File Descriptions
Python Simulators

heart_monitor.py - Simulates 2 heart rate monitors (55-105 bpm)
temp_sensor.py - Simulates 2 temperature sensors (36.0-38.5°C)
water_meter.py - Simulates 1 water meter (0.5-15.0L)

Bash Scripts

archive_logs.sh - Interactive log archival with timestamp naming
analyze_logs.sh - Generates statistical reports with device counts and timestamps
