#!/bin/bash

# Standard output device for logging
STDOUT="/dev/stdout"

# Use double quotes so the variable is expanded.
# Using single quotes ('$STDOUT') stores the literal string "$STDOUT"
# instead of "/dev/stdout".
LOG_FILE="$STDOUT"

# Descriptive log message.
LOG_MESSAGE="Application started"

# Log a message with a timestamp.
log_message() {
    # Use the correct variable name (LOG_FILE instead of LOGFILE).
    # Quote "$1" to preserve spaces and avoid word splitting.
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Quote the variable to prevent word splitting.
log_message "$LOG_MESSAGE"