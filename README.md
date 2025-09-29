# Data Pipeline Automation (Linux + Bash)

This project demonstrates how to build a simple **data processing pipeline** using **Linux commands** and **bash scripts**.  
It covers file manipulation, automation with cron jobs, permissions, and logging.

---

## Project Structure
```
data_pipeline/
   input/                    # Raw input CSV files
      sales_data.csv
   output/                   # Cleaned output files
      cleaned_sales_data.csv
   logs/                     # Log files for monitoring
      preprocess.log
      monitor_summary.log
   preprocess.sh             # Data cleaning script
   monitor.sh                # Log monitoring script
```

---

## Features
1. **Data Ingestion**  
   - Place the raw `sales_data.csv` into `input/`.

2. **Data Preprocessing (`preprocess.sh`)**  
   - Removes the last column (`extra_col`)  
   - Filters out rows where `status = Failed`  
   - Saves cleaned data into `output/cleaned_sales_data.csv`  
   - Logs every step into `logs/preprocess.log`  
   - Skips processing if the output file already exists  

3. **Monitoring (`monitor.sh`)**  
   - Scans `preprocess.log` for errors using key words like: (`ERROR` or `failed`)  
   - Writes findings into `logs/monitor_summary.log`
   - Prints findings to the terminal. 

4. **Automation with Cron Jobs**  
   - `preprocess.sh` runs daily at **12:00 AM**  
   - `monitor.sh` runs daily at **12:05 AM**  

5. **Permissions & Security**  
   - Input folder writable only by the user  
   - Logs restricted to authorized users  

---

## Setup Instructions

### 1. Clone the Repository
```bash
cd ~
git clone https://github.com/faruksedik/data_pipeline.git
cd data_pipeline
```

### 2. Create Required Directories
```bash
mkdir -p ~/data_pipeline/input ~/data_pipeline/output ~/data_pipeline/logs
```

### 3. Place the Dataset
Download the dataset (`sales_data.csv`) into the input folder:
```bash
wget -P ~/data_pipeline/input/ https://raw.githubusercontent.com/dataengineering-community/launchpad/refs/heads/main/Linux/sales_data.csv
```

---

## Usage

### Run Preprocessing Script
This script removes the last column, filters out rows where `status = Failed`, and saves the cleaned file.
```bash
chmod +x preprocess.sh
./preprocess.sh
```

Logs will be saved in:
```
~/data_pipeline/logs/preprocess.log
```

### Run Monitoring Script
This script checks logs for errors and writes a summary report.
```bash
chmod +x monitor.sh
./monitor.sh
```

Summary will be saved in:
```
~/data_pipeline/logs/monitor_summary.log
```

---

## Automating with Cron

### 1. Edit Cron Jobs
```bash
crontab -e
```

### 2. Add Jobs
- Run preprocessing daily at **12:00 AM**:
  ```cron
  0 0 * * * ~/data_pipeline/preprocess.sh
  ```
- Run monitoring daily at **12:05 AM**:
  ```cron
  5 0 * * * ~/data_pipeline/monitor.sh
  ```

### 3. Verify Cron Jobs
```bash
crontab -l
```

---

## Permissions & Security
- Input folder: Writable only by user (Owner of the directory).
     - For the owner (you): rwx (read, write and execute)
     - For the group:       --- (no permission)
     - For others:          --- (no permission)
- Use the command below:
  ```bash
  chmod 700 ~/data_pipeline/input
  ```
  
- Logs folder: Readable only by authorized users (Owner and members in your group).
     - For the owner (you): rw- (read and write)
     - For the group:       r-- (read only)
     - For others:          --- (no permission)
- Use the command below:
  ```bash
  chmod 640 ~/data_pipeline/logs/*
  ```

---

## Author
- **Faruk Sedik**  
- Project for practicing Linux + Bash + Automation in Data Engineering
