#!/bin/bash

# Hospital Data Archival Script
# Archives selected log files with timestamp

# Define paths
ACTIVE_LOGS_DIR="hospital_data/active_logs"
HEART_ARCHIVE_DIR="hospital_data/archives/heart_data_archive"
TEMP_ARCHIVE_DIR="hospital_data/archives/temp_data_archive"
WATER_ARCHIVE_DIR="hospital_data/archives/water_data_archive"

# Create archive directories if they don't exist
mkdir -p "$HEART_ARCHIVE_DIR" "$TEMP_ARCHIVE_DIR" "$WATER_ARCHIVE_DIR"

# Function to display menu
show_menu() {
    echo "=================================="
    echo "  Hospital Log Archival System"
    echo "=================================="
    echo "Select log to archive:"
    echo "1) Heart Rate"
    echo "2) Temperature"
    echo "3) Water Usage"
    echo "4) Exit"
    echo "=================================="
}

# Function to archive log file
archive_log() {
    local log_file=$1
    local archive_dir=$2
    local log_type=$3
    
    # Check if log file exists
    if [ ! -f "$log_file" ]; then
        echo "Error: Log file $log_file does not exist!"
        return 1
    fi
    
    # Check if log file is empty
    if [ ! -s "$log_file" ]; then
        echo "Warning: Log file $log_file is empty. Nothing to archive."
        return 1
    fi
    
    # Generate timestamp for archive filename
    timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
    archive_filename="${log_type}_${timestamp}.log"
    archive_path="${archive_dir}/${archive_filename}"
    
    # Archive the log file
    echo ""
    echo "Archiving ${log_type}.log..."
    
    if mv "$log_file" "$archive_path"; then
        echo "✓ Successfully archived to $archive_path"
        
        # Create new empty log file for continued monitoring
        touch "$log_file"
        echo "✓ Created new empty log file: $log_file"
        echo ""
        return 0
    else
        echo "✗ Error: Failed to archive log file!"
        return 1
    fi
}

# Main script logic
main() {
    while true; do
        show_menu
        read -p "Enter choice (1-4): " choice
        
        case $choice in
            1)
                archive_log \
                    "$ACTIVE_LOGS_DIR/heart_rate.log" \
                    "$HEART_ARCHIVE_DIR" \
                    "heart_rate"
                ;;
            2)
                archive_log \
                    "$ACTIVE_LOGS_DIR/temperature.log" \
                    "$TEMP_ARCHIVE_DIR" \
                    "temperature"
                ;;
            3)
                archive_log \
                    "$ACTIVE_LOGS_DIR/water_usage.log" \
                    "$WATER_ARCHIVE_DIR" \
                    "water_usage"
                ;;
            4)
                echo "Exiting archival system."
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