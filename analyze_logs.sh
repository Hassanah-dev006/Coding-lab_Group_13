#!/bin/bash

# Hospital Data Analysis Script
# Analyzes log files and generates statistical reports

# Define paths
ACTIVE_LOGS_DIR="hospital_data/active_logs"
REPORTS_DIR="reports"
REPORT_FILE="$REPORTS_DIR/analysis_report.txt"

# Create reports directory if it doesn't exist
mkdir -p "$REPORTS_DIR"

# Function to display menu
show_menu() {
    echo "=================================="
    echo "  Hospital Log Analysis System"
    echo "=================================="
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    echo "4) Exit"
    echo "=================================="
}

# Function to analyze log file
analyze_log() {
    local log_file=$1
    local log_type=$2
    
    # Check if log file exists
    if [ ! -f "$log_file" ]; then
        echo "Error: Log file $log_file does not exist!"
        return 1
    fi
    
    # Check if log file is empty
    if [ ! -s "$log_file" ]; then
        echo "Warning: Log file $log_file is empty. Nothing to analyze."
        return 1
    fi
    
    echo ""
    echo "Analyzing $log_type log file..."
    echo ""
    
    # Generate report header
    local report_timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    {
        echo "========================================"
        echo "Analysis Report: $log_type"
        echo "Generated: $report_timestamp"
        echo "========================================"
        echo ""
    } >> "$REPORT_FILE"
    
    # Extract device information and count occurrences
    echo "Device Statistics:"
    echo "Device Statistics:" >> "$REPORT_FILE"
    echo "------------------" >> "$REPORT_FILE"
    
    # Use awk to extract device names and count occurrences
    awk -F'|' '{
        if ($2 ~ /Device:/) {
            gsub(/^[ \t]+|[ \t]+$/, "", $2)
            gsub(/Device: /, "", $2)
            devices[$2]++
            if (!first[$2]) {
                first[$2] = $1
            }
            last[$2] = $1
        }
    }
    END {
        for (device in devices) {
            gsub(/^[ \t]+|[ \t]+$/, "", first[device])
            gsub(/^[ \t]+|[ \t]+$/, "", last[device])
            print device ": " devices[device] " entries"
            print "  First entry: " first[device]
            print "  Last entry:  " last[device]
            print ""
        }
    }' "$log_file" | tee -a "$REPORT_FILE"
    
    # Total entries
    total_entries=$(wc -l < "$log_file")
    echo "Total Entries: $total_entries"
    echo "Total Entries: $total_entries" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    # Log file info
    echo "Log File: $log_file"
    echo "Log File: $log_file" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    echo "✓ Analysis complete!"
    echo "✓ Report appended to: $REPORT_FILE"
    echo ""
    
    return 0
}

# Main script logic
main() {
    while true; do
        show_menu
        read -p "Enter choice (1-4): " choice
        
        case $choice in
            1)
                analyze_log \
                    "$ACTIVE_LOGS_DIR/heart_rate.log" \
                    "Heart Rate"
                ;;
            2)
                analyze_log \
                    "$ACTIVE_LOGS_DIR/temperature.log" \
                    "Temperature"
                ;;
            3)
                analyze_log \
                    "$ACTIVE_LOGS_DIR/water_usage.log" \
                    "Water Usage"
                ;;
            4)
                echo "Exiting analysis system."
                exit 0
                ;;
            *)
                echo "Error: Invalid choice. Please enter 1, 2, 3, or 4."
                echo ""
                ;;
        esac
        
        # Pause before showing menu again
        read -p "Press Enter to continue..."
        echo ""
    done
}

# Run main function
main