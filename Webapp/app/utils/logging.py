import logging
from logging.handlers import RotatingFileHandler
import os

# Load environment variables
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")

# Create logs directory if it doesn't exist
LOG_DIR = "logs"
os.makedirs(LOG_DIR, exist_ok=True)

# Logging configuration
log_formatter = logging.Formatter(
    "%(asctime)s - %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S"
)

file_handler = RotatingFileHandler(
    f"{LOG_DIR}/app.log", maxBytes=5 * 1024 * 1024, backupCount=3
)
file_handler.setFormatter(log_formatter)

console_handler = logging.StreamHandler()
console_handler.setFormatter(log_formatter)

logger = logging.getLogger("app_logger")
logger.setLevel(LOG_LEVEL)
logger.addHandler(file_handler)
logger.addHandler(console_handler)

def log_info(message: str):
    """Log an info message."""
    logger.info(message)

def log_error(message: str):
    """Log an error message."""
    logger.error(message)

def log_debug(message: str):
    """Log a debug message."""
    logger.debug(message)

def log_warning(message: str):
    """Log a warning message."""
    logger.warning(message)
